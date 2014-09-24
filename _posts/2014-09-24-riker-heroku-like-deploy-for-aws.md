---
layout: post
title: Riker - Heroku-like app deployments for AWS
permalink: "riker-heroku-like-app-deploy-for-aws"
tags: [aws, heroku, devops, zero-downtime, paas, announcement, open-source, riker]
---

[![William Riker](/images/riker-phaser.jpg)][1]

[Riker][1] turns [Amazon Web Services][5] into your very own
[Platform as a Service][6], giving you the same ease-of-use that platforms like [Heroku][7]
provide, while retaining the control that is attractive about [AWS][5].


### Getting Started

Getting started with [Riker][1] is easy: just install it using [pip][] and Riker
will prompt you for the necessary information it needs:

{% highlight bash %}
$ pip install riker
$ riker config
{% endhighlight %}


### Deploy a Node.js app

First, let’s clone a sample [Node.js][8] app:

{% highlight bash %}
$ git clone git@github.com:heroku/node-js-sample.git
$ cd node-js-sample
{% endhighlight %}

Then deploy it with just one command:

{% highlight bash %}
$ riker deploy
{% endhighlight %}

And open it in your default web browser:

{% highlight bash %}
$ riker open
{% endhighlight %}

That’s it! While this example deploys a sample [Node.js][8] application, any
language can be deployed, since Riker uses [Heroku Buildpacks][9]. [More
information on exactly what buildpacks Riker supports, and how to use a custom
buildpack](https://github.com/jschementi/riker/issues/30).


### Deploy a static website

Riker can also be used to deploy static websites to [S3][], rather than running
[nginx][] or [apache][] in an [EC2][] instance to serve static files:

First, generate a static website:

{% highlight bash %}
$ mkdir static-website && cd static-website
$ echo "Hello, World" > index.html
$ touch .s3 # tells Riker to deploy to Amazon S3
$ git init && git add -A && git commit -m "Initial commit"
{% endhighlight %}

Then use the same commands as before to deploy and open the website:

{% highlight bash %}
$ riker deploy
$ riker open
{% endhighlight %}


### Scalable, zero-downtime deployments

Riker provides a scalable mode (`--scale`), where [load balancing][load-balancing] and
[auto-scaling][] are configured for you. This also ensures zero-downtime during
deployments.

{% highlight bash %}
$ riker deploy --scale
{% endhighlight %}


### How It Works

Riker provides a set of best-practices and structure to your infrastructure,
while leaning on as much of the features AWS provides as possible.

   * Load Balancing: [Elastic Load Balancer (ELB)][load-balancing]
   * Scaling: [EC2 Auto-Scaling and Launch Configurations][auto-scaling]
   * DNS: [Route 53][route-53]
   * Static website hosting: [Simple Storage Service (S3)][s3]

Riker doesn’t require its own server to be running; it’s just a deployment
tool (though it’s best to run Riker in a [CI][] server like [Jenkins][]).

Riker also abstracts away the [EC2][] instances, and instead lets you only care
about the application itself: code, dependencies, and configuration. Riker
makes your instances easy to destroy and recreate, removing the need to ever
manually provision a machine. This also makes scaling trivial. To enable this
abstraction, Riker uses Docker to run your application in its own sandbox,
as well as [Heroku Buildpacks][9] to deploy many different types of applications.
Today, Riker also uses [Dokku], but may move away from it to allow Riker to also
run your application locally during development, but more about that later.

By default, Riker will deploy changes directly to existing instances.
However, with the `--scale` flag, Riker will deploy changes to new instances,
and only swap old instances out for new instances when the new instances
become healthy, and the old instances no longer have active connections.


### Disclaimer

While Riker is in active development, it’s probably not ready for prime-time,
unless you’re really willing to help contribute and test things out.

### Contribute

There are many ways you can help make Riker better:

- **Use it!** [Report bugs, suggest features and ask questions on GitHub][3]
- **Write documentation**: Anything you feel requires documentation, please feel
  free to write it in the [Wiki][2].
  [Please follow these instructions for contributing to Wikis](http://fusiongrokker.com/post/how-you-can-contribute-to-taffy-documentation)
- **Write code**: Either from the [Issues list][3],
  or your own idea.
  [Pull requests are encouraged!][4]

Let me know what you think! Look for subsequent posts about the rationale behind
Riker and why it’s different than other comparable services.


<div style="text-align:center; font-style: italic;">You’re the captain - make Riker your "Number One"</div>

[![William Riker](/images/riker-grin.jpg)][1]

  [1]:                https://github.com/jschementi/riker
                      "Riker"
  [2]:                https://github.com/jschementi/riker/wiki
                      "Riker Wiki"
  [3]:                https://github.com/jschementi/riker/issues
                      "Riker Issues"
  [4]:                https://github.com/jschementi/riker/pulls
                      "Riker Pull Requests"
  [5]:                http://aws.amazon.com/
                      "Amazon Web Services"
  [6]:                http://en.wikipedia.org/wiki/Platform_as_a_service
                      "Platform as a Service"
  [7]:                http://heroku.com
                      "Heroku"
  [8]:                http://nodejs.org/
                      "Node.js"
  [9]:                https://devcenter.heroku.com/articles/buildpacks
                      "Heroku Buildpacks"
  [s3]:               http://aws.amazon.com/s3/
                      "Simple Storage Service"
  [ec2]:              http://aws.amazon.com/ec2/
                      "Elastic Compute Cloud"
  [nginx]:            http://nginx.org/
                      "NGINX"
  [apache]:           http://httpd.apache.org/
                      "Apache"
  [load-balancing]:   http://aws.amazon.com/elasticloadbalancing/
                      "Elastic Load Balancing"
  [auto-scaling]:     http://aws.amazon.com/autoscaling/
                      "Auto-scaling"
  [route-53]:         http://aws.amazon.com/route53/
                      "Route 53"
  [jenkins]:          http://jenkins-ci.org/
                      "Jenkins CI"
  [ci]:               http://en.wikipedia.org/wiki/Continuous_integration
                      "Continuous Integration"
  [dokku]:            https://github.com/progrium/dokku
                      "Dokku"
  [pip]:              http://pip.readthedocs.org/en/latest/installing.html#install-pip
                      "Python Install Python"
