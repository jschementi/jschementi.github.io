---
layout: "post"
title: "Splitting up a Git repo"
permalink: "/splitting-up-a-git-repo"
categories: [Git]
date: "2014-07-17 18:19:00"
---

When it comes to organizing Git repositories, there's only one way to do it:
**a repository per project or component** (a web server, an iOS app, etc...).

If you've done anything other than that, **you've fucked up**. Maybe you have a
single repository for everything? Some combination? Sure, it might be easier to just
have one repository, but as your system grows, the ramifications of that fuck-up
become clear:

- A 1-line change to the app performs a full-redeploy of your web-server -
  now you have to have your CI server only build certain jobs based on
  directory's touched. **Yuck.**

- Every single server has the code for all the other servers. Now you have to
  perform a build step to remove files from deployments. **Yuck.**

- Large commits cutting across multiple components. Commit messages could be
  considered novels. Now we have to selectively commit certain files that touch a
  server, and certain files that touch the app, etc. **Yuck.**

If this sounds like your project, don't keep working around the problem - **let's
fix it.** It's probably going to be a bit of work, but it's necessary, so take a
deep breath, and let's get started.

The first choice you have to make is whether to preserve history or not. For
almost all cases you should preserve history, but if for some reason
you decide it's not important, then *"these aren't the droids you're looking for"*.
You just need to create new repositories, copy files to each as appropriate, and
you're done. That might be the right choice for your project, but this isn't
the post for you.

Git gives us many tools to rewrite history, so let's look at situations you'll
run into, and how to use Git to deal with them.


### Extract a sub-directory

This is the best-case scenario: everything is perfect about your repository,
only you have each project/component in a sub-directory of your large repo.
For this, `git subtree split` is exactly what you want.

    git subtree split -prefix=subdir_to_remove -b new_project_branch


> For some older versions of git, the `subtree` subcommand may be unavailable.
> Instead, you can use the `filter-branch` subcommand:
>
>     git filter-branch --subdirectory-filter subdir_to_remove new_project_branch

Then you can push each new branch to its own remote.


### Arbitrary paths

What if a project has two top-level directories, or shares files between projects?
Maybe a `.env` or `Procfile`?
In this case you'll have to extract history by arbitrary paths.

To do this, first we remove all non-wanted files from all git commits with the
`git filter-branch` command. Any commits that do not touch those paths will be
removed because of the `--ignore-unmatch` flag.

    PATHS_TO_KEEP="./some_dir ./some_other_dir .env Procfile"
    git filter-branch -f --index-filter "git rm --ignore-unmatch --cached -qr -- . && git reset -q \$GIT_COMMIT -- $PATHS_TO_KEEP" --prune-empty -- HEAD

> The `-- HEAD` means to only do this transformation in the current branch.
> You can replace it with `-- --all` to do it across all branches. Or
> `--tag-name-filter cat -- --all` to do it across all branches AND tags. Pick your poison.

While this is great, empty merge commits are not removed by the last command!
A `parent-filter` can be used to rewrite commit parents to remove them:

    tmpfile=`mktemp -t splitgit`
    chmod 755 $tmpfile
    echo '#!/usr/bin/env ruby
    old_parents = gets.chomp.gsub("-p ", " ")
    new_parents = old_parents.empty? ? [] : `git show-branch --independent #{old_parents}`.split
    puts new_parents.map{|p| "-p " + p}.join(" ")' > $tmpfile
    git filter-branch -f --prune-empty --parent-filter $tmpfile HEAD
    rm $tmpfile

> You can simplify this by writing $tmpfile to disk in a well-known location,
> instead of using `mktemp` each time.


### Moving files around

Let's say a new repo should still have a  file, but you want to change its
path in the new repo?  If so, `tree-filter` can help with this. For this example,
we want to move an entire sub-directory up one level.

    git filter-branch -f --tree-filter 'shopt -s dotglob nullglob; test -d sub_dir && mv sub_dir/* . || :' HEAD


### Deleting files

What if you just don't want a particualr file around?

    git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' --prune-empty -- HEAD

> We use `index-filter` here to not require files be checked out for each commit,
> which makes it faster. This is different from `tree-filter` in that it checks out
> each commit's files. This is good in that it lets you use `rm` and `test`, but is
> slower. When formulating your own history manipulations, keep this in mind.


### Keeping only certain lines in a file

(I know, this is crazy...) What if, in your old repo, you had a configuration
file that was for all projects, but now you want to only keep commits that
affected the variables for the particuar sub-project? `tree-filter` + `cat` + `grep`:

    git filter-branch -f --tree-filter 'test -f .env && cat .env | grep "\(^VAR_X\|^VAR_Y\|^VAR_Z\)" > .newenv && mv .newenv .env || :' --prune-empty -- HEAD


### Fucking symlinks

OK, this is harder, but all your fault. You have symlinks in your repo, presumably to
share code between projects. Bad. Share code through a package manager, a submodule,
or some other means, but not through a symlink.

This is a problem when your repository split makes a symlink invalid, since Git
stores symlinks as a file with its only contents a path.

To fix this, we'll convert all symlinks into hard links, which Git will then
treat as any other file and commit its contents.

Convert all symlinks to hard links (if the symlinks are relative paths):

    git filter-branch -f --tree-filter \
    'find . -type l -exec bash -c '"'"'ln -f "$(dirname "$0")/""$(readlink -n "$0")" "$0"'"'" {} \;' \
    --prune-empty -- HEAD

> If the paths are absolute, WTF? How the hell did that ever work to begin with??


### Empty commits

If for some reason you have empty commits (maybe you forgot a `--ignore-unmatch` ?),
you can remove them with a special `--commit-filter`:

    git filter-branch --commit-filter 'git_commit_non_empty_tree "$@"' HEAD


#### The initial commit is still empty, what gives?

That's the only price your going to pay for not doing the right thing to start, so
be OK with it. Your initial commit is most likely going to be an empty one saying
"Initial commit" or whatever you said.

You could rebase your entire repository (`git rebase --interactive --root`)
but if you have any legitimate merge commits you'll find yourself attempting to merge
years old code in the right order. It's not worth it.


### Fixing author info

If you notice certain committers used a non-company email, or there are commits
from non-human accounts, you can use a `--env-filter` to rewrite author and 
committer name and emails. [GitHub's Help site has a good example of this](https://help.github.com/articles/changing-author-info).


### Holy crap I deleted the wrong thing/everything!

No problem! If anything goes wrong, you can undo the last `filter-branch`:

    git reset --hard refs/original/refs/heads/master


### Next steps

After you've got all your new shiny respositories how you want them, you're may not
be entirely done. Some things that you probably need to do:

- Create new CI or deployment jobs to work against new repos
- Reference GitHub issues in commits? Well, now `#1234` points to your new repo,
  not the old one. To reference an issue in a different repo than the current one,
  use `user/repo#1234` (and make it a habit to always reference them like that).
  I'll leave it to the reader to figure out how to rewrite commit messages from
  `#1234` to `user/repo#1234`.
- Delete old code from old repo, and put a message up on your old repo telling
  visitors where to look for the new repo.

Happy history rewriting!
