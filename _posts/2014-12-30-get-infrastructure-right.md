---
layout: post
title: Get Your Infrastructure Right
permalink: "get-infrastructure-right"
---

<style>
  .post {
    position: relative;
    font-weight: 300;
    font-family: "Helvetica Neue", Helvetica, sans-serif;
  }
  .brooklynjs-box {
    border: 4px solid #222;
    background: #222;
    color: #fff;
  }
  .brooklynjs-box-caption {
    width: 500px;
    margin: 0px auto;
    margin-top: 2em;
  }
  .brooklynjs-box p {
    color: #eee;
    font-size: 17px;
    line-height: 1.5em;
  }
  .brooklynjs-box a {
    color: #fff;
    text-decoration: none;
    font-weight: bold;
  }
  .brooklynjs-box a:hover {
    text-decoration: underline;
  }
  .brooklynjs-logo-box {
    font-size: 20px;
    font-weight: 300;
    font-family: "Helvetica Neue", Helvetica, sans-serif;
    letter-spacing: .015em;
  }
  .brooklynjs-logo {
    width: 500px;
    margin: 20px auto;
    font-weight: bold;
    font-size: 72px;
    text-align: left;
    border-top: 4px solid #fff;
    line-height: 68px;
    position: relative;
  }
  .brooklynjs-logo .j {
    right: 80px;
  }
  .brooklynjs-logo .s {
    right: 0;
  }
  .brooklynjs-logo span {
    position: absolute;
    top: 7px;
    height: 72px;
    width: 72px;
    border-radius: 50%;
    line-height: 72px;
    font-size: 60px;
    text-align: center;
    background: #f7df1e;
    color: #222;
  }
  img[title="Heroku"],
  img[title="Docker"],
  img[title="Amazon Web Services"],
  img[title="Digital Ocean"] {
    margin-bottom: -15px;
    margin-top: 15px;
  }
  img[title="Heroku"] {
    height: 5em;
  }
  img[title="Docker"],
  img[title="Amazon Web Services"]{
    height: 7em;
  }
  img[title="Digital Ocean"] {
    height: 8em;
  }
  span.center {
    display: block;
    text-align: center;
    padding: 1em;
  }
  a[title="Fuck you!"] {
    color: inherit;
    text-decoration: inherit;
  }
  a[title="Fuck you!"]:hover {
    color: inherit;
    text-decoration: underline;
  }
</style>

<style>
/*! normalize.css v3.0.0 | MIT License | git.io/normalize */
.slide-style article,.slide-style aside,.slide-style details,.slide-style figcaption,.slide-style figure,.slide-style footer,.slide-style header,.slide-style hgroup,.slide-style main,.slide-style nav,.slide-style section,.slide-style summary{display:block}
.slide-style audio,.slide-style canvas,.slide-style progress,.slide-style video{display:inline-block;vertical-align:baseline}
.slide-style audio:not([controls]){display:none;height:0}
.slide-style [hidden],.slide-style template{display:none}
.slide-style a{background:0 0}
.slide-style a:active,.slide-style a:hover{outline:0}
.slide-style abbr[title]{border-bottom:1px dotted}
.slide-style b{font-weight:700}
.slide-style dfn{font-style:italic}
.slide-style h1{font-size:2em}
.slide-style mark{background:#ff0;color:#000}
.slide-style small{font-size:80%}sub,.slide-style sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}.slide-style sup{top:-.5em}.slide-style sub{bottom:-.25em}.slide-style img{border:0}
.slide-style svg:not(:root){overflow:hidden}
.slide-style figure{margin:1em 40px}
.slide-style hr{box-sizing:content-box}
.slide-style pre{overflow:auto}
.slide-style code,.slide-style kbd,.slide-style pre,.slide-style samp{font-size:1em}
.slide-style kbd,.slide-style pre,.slide-style samp{font-family:monospace, monospace}
.slide-style button,.slide-style input,.slide-style optgroup,.slide-style select,.slide-style textarea{color:inherit;font:inherit;margin:0}
.slide-style button{overflow:visible}
.slide-style button,.slide-style select{text-transform:none}
.slide-style button,.slide-style input[type="button"],.slide-style input[type="reset"],.slide-style input[type="submit"]{-webkit-appearance:button;cursor:pointer}
.slide-style button[disabled],.slide-style input[disabled]{cursor:default}
.slide-style button::-moz-focus-inner,.slide-style input::-moz-focus-inner{border:0;padding:0}
.slide-style input{line-height:normal}
.slide-style input[type="checkbox"],.slide-style input[type="radio"]{box-sizing:border-box;padding:0}
.slide-style input[type="number"]::-webkit-inner-spin-button,.slide-style input[type="number"]::-webkit-outer-spin-button{height:auto}
.slide-style input[type="search"]{-webkit-appearance:textfield;box-sizing:content-box}
.slide-style input[type="search"]::-webkit-search-cancel-button,.slide-style input[type="search"]::-webkit-search-decoration{-webkit-appearance:none}
.slide-style fieldset{border:1px solid silver;margin:0 2px;padding:.35em .625em .75em}
.slide-style legend{border:0;padding:0}
.slide-style textarea{overflow:auto}
.slide-style optgroup{font-weight:700}
.slide-style table{border-collapse:collapse;border-spacing:0}
.slide-style td,.slide-style th,.slide-style *{padding:0}
.slide-style *{margin:0}
.slide-style .bespoke-parent{font-size:1.5em;background:#111;color:#ddd;font-family:futura, helvetica, arial, arial, sans-serif;overflow:hidden;text-align:center;-webkit-transition:background 1s ease;transition:background 1s ease;background-position:50% 50%}
/*.slide-style .bespoke-parent,.slide-style .bespoke-scale-parent{position:absolute;top:0;left:0;right:0;bottom:0}*/
.slide-style .bespoke-parent,.slide-style .bespoke-scale-parent{position:relative}
.slide-style .bespoke-scale-parent{pointer-events:none;z-index:1}
.slide-style .bespoke-scale-parent .bespoke-active{pointer-events:auto}
.slide-style .bespoke-slide{-webkit-transition:opacity .5s ease;transition:opacity .5s ease;/*width:940px;height:480px;position:absolute;top:50%;left:50%;margin-left:-470px;margin-top:-240px;*/display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;-webkit-box-pack:center;-webkit-justify-content:center;-ms-flex-pack:center;justify-content:center;-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;z-index:1}
.slide-style .bespoke-active{-webkit-transition-delay:.5s;transition-delay:.5s}
.slide-style .bespoke-active[data-bespoke-backdrop]{-webkit-transition-delay:.75s;transition-delay:.75s}
.slide-style .bespoke-inactive{opacity:0;pointer-events:none}
.slide-style .bespoke-backdrop{-webkit-transition:opacity 1s ease;position:absolute;top:0;left:0;right:0;bottom:0}
.slide-style .bespoke-progress-parent{position:absolute;top:0;left:0;right:0;height:.3vw;z-index:1}
.slide-style .bespoke-progress-bar{background:#ddd;position:absolute;top:0;left:0;height:100%;-webkit-transition:width 1s ease;transition:width 1s ease}
.slide-style .bespoke-bullet{-webkit-transition:opacity .3s ease;transition:opacity .3s ease}
.slide-style .bespoke-bullet-inactive{opacity:0}
.slide-style strong{font-weight:400}
.slide-style hr{width:50%;margin:1rem auto;height:1px;border:0;background:#ddd}
.slide-style h3,.slide-style p,.slide-style li{padding-left:20px;padding-right:20px}
.slide-style h3,.slide-style h4,.slide-style p,.slide-style li,.slide-style pre{font-weight:200}
.slide-style h1{line-height:1.4em;padding:1em;border:1px solid #ddd;border-left-width:0;border-right-width:0;min-width:8em}
.slide-style h1,.slide-style h2{letter-spacing:.3em;text-transform:uppercase;font-weight:400;margin:.17em 0;position:relative}
.slide-style h2{line-height:1.1em;padding:0 0 0 .3em}
.slide-style h3{font-family:didot, times new roman, serif;font-style:italic;font-size:1.2em;line-height:1.6em;margin:.5em 0}
.slide-style h4{text-transform:uppercase;font-size:.8em;line-height:1.8em;letter-spacing:.3em;margin:1em 0}
.slide-style ul,.slide-style ol{padding:0;margin:0;text-align:left}
.slide-style li{list-style:none;margin:.2em;font-style:normal;-webkit-transform:translateX(-6px);-ms-transform:translateX(-6px);transform:translateX(-6px)}
.slide-style li:before{content:'\2014';margin-right:4px}
.slide-style pre{background:none!important}
.slide-style code{font-family:prestige elite std, consolas, courier new, monospace!important;font-style:normal;font-weight:200!important;text-align:left}
.slide-style a{padding-left:.3em;color:currentColor;text-decoration:none;border-bottom:1px solid currentColor}
.slide-style .emphatic{background:rgb(255, 51, 0);}
.slide-style .single-words{word-spacing:9999px;line-height:2.9em;overflow:hidden}
.slide-style .bespoke-backdrop{opacity:0;-webkit-transition:opacity 1s ease,.slide-style -webkit-transform 6s ease;transition:opacity 1s ease,.slide-style transform 6s ease;background-size:cover;background-position:50% 50%;-webkit-transform:translateZ(0)scale(1.3);transform:translateZ(0)scale(1.3)}
.slide-style .bespoke-backdrop-active,.slide-style .bespoke-backdrop-before{-webkit-transform:translateZ(0);transform:translateZ(0)}
.slide-style .bespoke-backdrop-before{-webkit-transition-delay:.2s;transition-delay:.2s}
.slide-style .bespoke-backdrop-active{opacity:.5}
</style>

<style>
.slide-style code[class*="language-"],.slide-style pre[class*="language-"] {
    color: #f8f8f2;
    text-shadow: 0 1px rgba(0,0,0,.3);
    font-family: Consolas,Monaco,'Andale Mono',monospace;
    direction: ltr;
    text-align: left;
    white-space: pre;
    word-spacing: normal;
    word-break: normal;
    line-height: 1.5;
    -moz-tab-size: 4;
    tab-size: 4;
    -webkit-hyphens: none;
    -moz-hyphens: none;
    -ms-hyphens: none;
    hyphens: none
}
.slide-style pre[class*="language-"] {
    padding: 1em;
    margin: .5em 0;
    overflow: auto;
    border-radius: .3em
}

.slide-style :not(pre)>code[class*="language-"],.slide-style pre[class*="language-"] {
    background: #272822
}

.slide-style :not(pre)>code[class*="language-"] {
    padding: .1em;
    border-radius: .3em
}

.slide-style .token.comment,.slide-style .token.prolog,.slide-style .token.doctype,.slide-style .token.cdata {
    color: slategray
}

.slide-style .token.punctuation {
    color: #f8f8f2
}

.slide-style .namespace {
    opacity: .7
}

.slide-style .token.property,.slide-style .token.tag,.slide-style .token.constant,.slide-style .token.symbol,.slide-style .token.deleted {
    color: #f92672
}

.slide-style .token.boolean,.slide-style .token.number {
    color: #ae81ff
}

.slide-style .token.selector,.slide-style .token.attr-name,.slide-style .token.string,.slide-style .token.char,.slide-style .token.builtin,.slide-style .token.inserted {
    color: #a6e22e
}

.slide-style .token.operator,.slide-style .token.entity,.slide-style .token.url,.slide-style .language-css .token.string,.slide-style .style .token.string,.slide-style .token.variable {
    color: #f8f8f2
}

.slide-style .token.atrule,.slide-style .token.attr-value {
    color: #e6db74
}

.slide-style .token.keyword {
    color: #66d9ef
}

.slide-style .token.regex {
    color: #fd971f
}

.slide-style .token.important {
    color: #fd971f;
    font-weight: 700
}

.slide-style .token.entity {
    cursor: help
}

.slide-style .bespoke-parent {
  position: relative;
}

.riker-grin{background-image:url(../images/get-infrastructure-right/riker-grin.jpg);background-position-y:12% !important}
.picard-wtf{background-image:url(../images/get-infrastructure-right/picard-wtf.jpg)}
.riker-grin,.picard-wtf{opacity:.75 !important}
.slide-style .picard-wtf-slide,.slide-style .riker-grin-slide{height:16em;padding:1em}

.slide-style .light-bg {
    background-color: #fff;
}

.slide-style .light-bg,.slide-style .light-bg code[class*="language-"],.slide-style .light-bg pre[class*="language-"] {
    color: #333!important;
}

.slide-style .light-bg code[class*="language-"] .token.operator,.slide-style .light-bg pre[class*="language-"] .token.operator,.slide-style .light-bg code[class*="language-"] .token.punctuation,.slide-style .light-bg pre[class*="language-"] .token.punctuation {
    color: #555!important
}

.slide-style .light-bg.bespoke-backdrop-active {
    opacity: 1;
}

.slide-style .pin {
    position: absolute;
    left: 0;
    right: 0;
}

.slide-style .pin.top {
    top: 10%;
}

.slide-style .pin.bottom {
    bottom: 10%;
}

.slide-style .italic {
    font-style: italic;
    text-transform: none;
    font-family: didot, times new roman, serif
}

.slide-style .tiny-code code[class*="language-"],.slide-style .tiny-code pre[class*="language-"] {
    font-size: .8em;
    line-height: 1
}

.slide-style .bespoke-slide {
  padding: 1em;
  zoom: .9;
  position: relative;
}

.slide-style h1 {font-size:2em}
.slide-style h2 {font-size:1.5em;}
.slide-style h3 {font-size:1.2em;}

.post .slide-style pre {
  border: 0;
}
.post .slide-style pre code {
  border: 0;
  background-color: transparent;
  padding: 0;
}
#slides {
  display: none;
  opacity: 0;
  transition: opacity 1s;
  transition-timing-function: ease-out;
}
#slides.open {
  display: block;
}
#slides.visible {
  opacity: 1;
}
#slides iframe {
  width: 100%;
  height: 350px;
  border: 0;
}
a#open-slides .caret {
  display: inline-block;
  -webkit-transition: -webkit-transform 0.5s;
  transition: transform 0.5s;
  -webkit-transform:rotate(0deg) translateY(0);
  transform:rotate(0deg) translateY(0);
}
a#open-slides.pressed .caret {
  -webkit-transform:rotate(180deg) translateY(-3px);
  transform:rotate(180deg) translateY(-3px);
}
</style>

<div class="brooklynjs-box">
  <div class="brooklynjs-logo-box">
    <div class="brooklynjs-logo">
      Brooklyn
      <span class="j">J</span>
      <span class="s">S</span>
    </div>
  </div>
  <div class="brooklynjs-box-caption">
    <p>This is a write-up of <a href="https://twitter.com/brooklyn_js/status/545755653160308738">a talk</a> <a href="https://twitter.com/RobbieTheGeek/status/545755219154731008">I gave</a> at <a href="http://brooklynjs.com/">BrooklynJS</a> on 12/18/2014,
    <br>titled <a href="http://jimmy.schementi.com/brooklynjs-20141218/">“Build apps, not infrastructure”</a>.</p>
    <p>Follow along with <a id="open-slides" href="javascript:void(0)">the slides <span class="caret">&blacktriangledown;</span></a></p>
  </div>
  <div id="slides">
    <iframe src="http://jimmy.schementi.com/brooklynjs-20141218/"></iframe>
    <p style="margin: 0; font-size: .75em; text-align: center;">Use arrow keys or swipe to control slides | <a href="http://jimmy.schementi.com/brooklynjs-20141218/" target="_blank">Open slides in a new window</a></p>
  </div>
</div>
<script>
  var openSlidesLink = document.querySelector('#open-slides');
  var slides = document.querySelector('#slides');
  openSlidesLink.addEventListener('click', function () {
    slides.classList.toggle('open');
    setTimeout(function () {
      slides.classList.toggle('visible');
    }, 20);
    openSlidesLink.classList.toggle('pressed');
    document.querySelector('#slides iframe').focus();
  }, false);
</script>

While most of us love building apps, we'd also love it if people
used them, and if we're lucky, **lots of people**. Problem is, then we really need
to care about how our app runs and scales, and it's best to get it figured
out before that moment of fame arrives. Let’s look at a few of the tools and
services that you can use to manage your infrastructure, so you can spend more
time building your apps, and less dealing with keeping your app running.

<div class="slide-style">
  <article class="bespoke-parent">
    <section class="bespoke-slide bespoke-active">
      <h3 class="bullet bespoke-bullet bespoke-bullet-active bespoke-bullet-current">Have you ever...</h3>
      <div>
        <h2>Changed code</h2>
        <h3>directly in</h3>
        <h2>production?</h2>
      </div>
      <br>
    </section>
    <div class="emphatic bespoke-backdrop bespoke-backdrop-active"></div>
  </article>
</div>

Yes, we all have changed code directly in production *(and you’re
lying if you say you haven’t)*. We do this **despite** knowning that
it’s horrible:

  - How many times have you found someone changed production directly
    and **forgot to check it in**?
  - Or made *[what you thought was]* a simple code change to fix a specific
    problem, but instead it revealed further problems.
  - Or users seeing intermittent brokenness while you make changes.
  - Or how do you know it works if you haven’t written tests for it?
  - Or! OR!

> Heck, a company even has the person editing code in production [don a
> pink sombrero][cowboy-coding] to bring awareness to “Cowboy Coding”:
>
> ![Cowboy coding][cowboy-coding-sombrero-guy]

Our reasons for making changes directly in production are usually good.
*Sometimes they’re not.* Regardless, we need to do this because our **deployment
processes aren't automated enough to *safely* do this**.

<span class="center">
![Automate all the things][automate-all-the-things]
</span>

Think about it - if we could quickly write a fix in a clone of production, test
it, and push it to production in seconds, wouldn’t we do that instead?

It’s alot of work to fully automate deployments, so most people have a fairly
**manual deployment process**. Which is crazy, considering we’re programmers - **all
we do is automate.** 

<div class="slide-style">
  <article class="bespoke-parent">
    <section class="bespoke-slide bespoke-active">
      <h2 class="bullet bespoke-bullet bespoke-bullet-active"><span>Application</span><span class="bullet italic bespoke-bullet bespoke-bullet-active">&nbsp;(feature)</span></h2>
      <h3>vs.</h3>
      <h2><span>Infrastructure</span><span class="bullet italic bespoke-bullet bespoke-bullet-active bespoke-bullet-current">&nbsp;(chore)</span></h2>
    </section>
  </article>
</div>

This happens mainly because **we prioritize features**, or
enhancements to our applications, **over chores**, which can be enhancements to our
infrastructure. This distinction comes from [Scrum][], where you're rewarded
for completing features, as those "add business value"...

<span class="center">![What if I told you that's bullshit][morpheus-bullshit]</span>

**Complete and utter bullshit...**

<div class="slide-style">
  <article class="bespoke-parent">
    <section class="bespoke-slide bespoke-active">
      <h2>Prioritizing</h2>
      <h2>infrastructure</h2>
      <h3>makes it easier to</h3>
      <h2>ship features</h2>
    </section>
  </article>
</div>

**A better infrastructure makes it easier to ship features.** A shitty/non-existant
infrastructure makes adding features exponentially harder as the system gets more
complicated. Therefore, **infrastructure improvements are really just features as
well** - as they do provide end-user value, *eventually*.

For example, most people would consider “User Signup” to be a feature, as a user interacts with
it directly. Though, at the same time, it's more part of your infrastructure,
as it's not the product itself, but *a necessary evil to use the product*. But,
you’d never make signup be a manual process, [as that would mean no one would
sign up and you’d have no users](http://moven.com "Fuck you!").

<span class="center">![If you manually do anything, you'll have a bad time][bad-time]</span>

Same should go for
deployments - if it’s not automatic, you’ll be **afraid of deploying**, and
favor large deployments, which will **create more bugs**, and a slew of other
anti-patterns will become part of your process. **To build a great product, you
need to have an equally great infrastructure**. Your users will feel the pain when
your infrastructure doesn’t support your ability to enhance your product.

<div class="slide-style">
  <article class="bespoke-parent">
    <section class="bespoke-slide bespoke-active">
      <h3>Think of</h3>
      <h2>infrastructure</h2>
      <h3>as a</h3>
      <h2>product</h2>
      <h3>you provide to</h3>
      <h2>yourself</h2>
      <br>
    </section>
    <div class="emphatic bespoke-backdrop bespoke-backdrop-active"></div>
  </article>
</div>

*Whoa, far out man...*

So, what would we want this infrastructure-as-a-product to do for us?

1. **Runs the [Twelve-Factor App][twelve-factor-app]**

    This methology of building web applications and services leads to more
    maintainable and scalable products. We’ll want our infrastructure to run
    these apps, as these are the apps we’ll write. [Read more about 12-factor
    apps][twelve-factor-app].

2. **Deploy a new app**

    New apps should be able to be deployed to any environment *within minutes*.
    Given that we prefer [micro-services][] over more monolithic architectures,
    this is an important feature - new server provisioning will happen very
    often. Infrastructures which requires significant effort to provision new
    servers tend to avoid this patter, leading to an application which is **harder
    to scale and evolve**.

3. **Automated scaling**

    Every web app or service should be behind its own load-balancer, which you
    can easily add or remove individual servers to. The creation of these
    servers should be fully-automated to allow the load-balancer to create more
    instance for you.

4. **Deploying should not introduce downtime**

    Deploying an existing app or service shouldn’t make it unavailable during
    deployment. This can also allows for rollback, incase a new deployment isn’t
    functioning properly, and versioning, to run multiple versions of the same
    app.

5. **Create and clone environments**

    Environments, a collection of all servers and configuration, should be
    easily created or cloned. This environment can be anywhere - in the cloud,
    or locally to develop against.

6. **Everything is automated**

    Minimal manual processes should be involving in doing any of the above
    features. Any modifications made to a default environment should be
    repeatable.

Sounds awesome, right? Does it already exist? Does it *kind of* already exist?
Let’s see what tools and services already exist that could help us out:

<span class="center">
![Heroku][heroku-logo]
</span>

[Heroku][] is “the” platform-as-a-service. It popularized many of the practices of
the [12-factor app][twelve-factor-app]. It was the first to use `git push` to trigger deployments.
Most importantly, it provides developers with a clean abstraction of an app,
hiding the complexities how to run the app. While [Heroku][]’s featureset is almost
exactly what we want, this abstraction comes at a price - quite literally.
Heroku is fairly expensive ($34.50/month for the low-end 2-server setup). It becomes more
expensive as you use add-ons (for example, $50/month for low-end Postgres).
Also, using Heroku is much more difficult (and expensive) to use for a utility
server, like Jenkins or Graphite, which may have higher CPU requirements
(nothing worse than slow builds).

*That’s not to say if you’re using Heroku you shouldn’t, it’s a great service.
Just be aware of the pros and cons.*

Though, how Heroku deploys applications is very interesting. Heroku has a
concept of a [buildpack][], which contains the logic to detect a specific type of
application and deploy it. [Heroku Buildpacks][buildpack] are all open-source,
meaning you can write your own, allowing Heroku to run almost anything. We can
also use [Heroku Buildpacks][buildpack] to provision our own servers...

<span class="center">
![Docker][docker-logo]
</span>

[Docker][] provides application containers, which provides the applications with an
isolated view of the operating system - their own process ID space, filesystem,
and network interfaces. It also provides contraints on system resources (memory,
CPU, network I/O).

Essentially [Docker][] can be used to provision and deploy applications, as an
alternative to [Heroku Buildpacks][buildpack]. The difference is [Docker][] can
be used to run an identical environment locally as well as when deployed, and
can run other apps like databases.

<span class="center">
![Amazon Web Services][aws-logo]
</span>

[Amazon Web Services (AWS)][aws] is a **massive** collection of services. **37 different
services** to be exact:

![Amazon Web Services Features][aws-features]

At the core is [Elastic Compute Cloud (EC2)][aws-ec2], which allows you to run and manage
arbitrary [virtual machines][vm] in Amazon's data centers. [EC2][aws-ec2] also has sub-services to help route network traffic
to your [VMs][vm], specifically [a TCP and HTTP load-balancer][aws-elb], as well as [Auto Scaling][aws-autoscale],
which helps you launch [instances][aws-ec2-instances] and add them to a load-balancer.

Another useful service is [Simple Storage Service (S3)][aws-s3], which stores
arbitrary data like a file-system. It can also serve those files over HTTP, making it an ideal
static HTTP server, as you don’t have to manage servers or load-balancers.

The *35 other services* do lots of what you want, like various data storage
services, [private networks][aws-vpc], [DNS][aws-route53], app and mobile services, deployment/provisioning stuff, oh my!
It can get very confusing for newcomers and experienced engineer alike,
as some of the services overlap in functionality. For example,
[OpsWorks][aws-opsworks], [CloudFormation][aws-cf], and [Beanstalk][aws-beanstalk]
all can do very similar things. Or complete with existing Open Source offerings, like
[DynamoDB][aws-dynamodb] and [MongoDB][].

[Elastic Beanstalk][aws-beanstalk] is worth noting, because it provides a similar
feature-set to Heroku - it can deploy applications to EC2 instances, and
auto-configures auto scaling and load balancing. However, the pre-configured
environments are awkward to configure, using the special `.elasticbeanstalk`
and `.ebextensions` directories, and creating a
[custom AMI for Elastic Beanstalk][aws-beanstalk-customami] somewhat violates
the “infrastructure as code” tenant. Also, it’s all or nothing - so if
your application isn’t supported by [Elastic Beanstalk][aws-beanstalk], like
[GoLang][], you can’t use it.

> Recently, Amazon improved [Elastic Beanstalk][aws-beanstalk] by adding support
> for [Docker][], which can be used to avoid all the environment weirdnesses,
> standardize provisioning, and support other languages. It also supports
> [rolling updates], meaning there’s no downtime during a deployment.

Amazon has recently added some new services, currently in preview, which are
promising:

  - [CodeDeploy][] manages applications and how to deploy them (some overlap with Beanstalk, but a bit more general)
  - [EC2 Container Service][] supports clustering of Docker containers
  - [Lambda][] - respond to events with code.

<span class="center">
![Digital Ocean][digitalocean-logo]
</span>

For those completely overwelmed by [AWS][], or just looking for something simpler,
[Digital Ocean][docean] is basically the equivalent of [EC2][aws-ec2] and [Route53][aws-route53],
but with an awesome user interface for both the website and the [API][docean-api], making it
much easier to work with.

Because it’s only for running [droplets][docean-droplet] (their word for VMs), any load
balancing needs to be done with another dedicated [droplet][docean-droplet] (eg. [HAProxy][]),
and scaling either manually.

<div class="slide-style">
  <div class="bespoke-parent">
    <section class="bespoke-slide bespoke-active">
      <h3 style="font-size: 1.5em">Feels like something's missing...</h3>
    </section>
    <div class="emphatic bespoke-backdrop bespoke-backdrop-active"></div>
  </div>
</div>

Seems like we can use all this for the major features of our infrastructure, but
nothing integrates it all together and makes it as easy as Heroku.

<div class="slide-style">
  <article class="bespoke-parent riker-grin-slide">
    <section class="bespoke-slide bespoke-active" style="zoom: 0.947872340425532;">
      <div class="pin top">
        <h2>Riker</h2>
        <h3>Heroku-like application deployments for<br>Amazon Web Services.</h3>
      </div>
    </section>
    <div class="riker-grin bespoke-backdrop bespoke-backdrop-active"></div>
  </article>
</div>

Riker gives you Heroku-like application deployments for Amazon Web Services. It
automates all the best-practices of application deployment, so you don’t have to
piece things together.

Riker deploys any application with a [buildpack][] to [AWS][], and
automatically configures load balancing and auto scaling for you, as well as
manages rolling deployments. It also can deploy static websites to S3.

Next I’d like to make the target “cloud” be extensible (most likely [Digital
Ocean][docean] as a first), support [Dockerfiles][dockerfile] as an alternative
to [buildpacks][], and use some of [AWS][]’s new features, like the [EC2
Container Service][], [CodeDeploy][], and [Lambda][].

Check out my [initial post about Riker][riker-blogpost], as it’s the same content
I spoke about in my talk. Here’s some other useful links:

- [Project on GitHub][riker-github]
- [Riker on Python Package Index][riker-pip]
- [Issues list][riker-issues] *(for roadmap as well as report bugs)*
- [Pull requests][riker-pulls] would be much appreciated!

If you want to *(eventually)* spend less time managing your infrastructure, and
more time building products, or are just interested in making infrastructure
management better, give Riker a try and come help me build it!

<div class="slide-style">
  <article class="bespoke-parent picard-wtf-slide">
    <section class="bespoke-slide bespoke-active" style="zoom: 0.947872340425532;">
      <h3 style="padding-left: 40%;padding-top: 5%">You're the captain, make Riker your #1</h3>
    </section>
    <div class="picard-wtf bespoke-backdrop bespoke-backdrop-active"></div>
  </article>
</div>

*Yeah, I’m a Trekky...*

<!--
#### Old blog post

I’d much rather focus on building a system, knowing that deployments and
scaling are already     And if I push that work off until the system is 
bigger or traffic start increasing, it takes even more time. Unless I use 
Heroku; then I spend very little time, but mainly because I control very 
little. 

As the applications we build for the web get more complex, so does deploying
and managing them. Remember when deploying your website was no more complex
than FTP-ing PHP files to your servers, and maybe running some MySQL scripts.
Your servers were either hosted by another company, or your own hardware, and
you just had one or two. You setup Apache and MySQL just once, and didn't
really have to think about your infrastructure much more than that - you spent
all your time focused on building your website.

How the times have changed. Now, we build web applications, and boy are they
more complex. The web server is usually just a forward proxy to your
application's processes, which themselves run a web server, and are written in
various programming languages. These applications do more than just generate
HTML - they also serve data which is consumed by any number of web browser and
native client applications. To accomplish this, your application's depend on
various technologies like key-value stores, message queues, and possibly
different types of relational and object databases. And all this runs on
virtual machines. All this extra complexity means a bunch more ways things can
break, so each component needs to be monitored. All this means more time
managing the infrastructure, and less time building your application.

There are no shortage of tools meant to help manage this infrastructure,
too many to name here. However, the infrastructure still gets in our way -
it's still way to hard to ship features to our users. We need to get back to
the simplicity of just publishing your code, and the "infrastructure" does
what's necessary to deploy it.

One service has set the standard for this - Heroku. With a few commands, you
can get your application deployed to the internet, without needing to deal with
setting up virtual machines. For most applications this is great when they
first start out, but that lack of control starts to become a burdeon as they
grow. Also, while Heroku allows you to manually scale up your applications, the cost of doing so becomes fairly high.

#### &lt;/end&gt; Old blog post
-->


  [cowboy-coding]:              http://www.bnj.com/blog/cowboy-coding-pink-sombrero/
                                "Cowboy Coding"
  [cowboy-coding-sombrero-guy]: /images/get-infrastructure-right/cowboy-coding.jpg "Cowboy Coding"
  [automate-all-the-things]:    /images/get-infrastructure-right/automate-all-the-things.png "Automate All The Things"
  [morpheus-bullshit]:          /images/get-infrastructure-right/bullshit.jpg "What if I told you... that's bullshit"
  [bad-time]:                   /images/get-infrastructure-right/bad-time.jpg "If you manually do anything, you're going to have a bad time."
  [scrum]:                      http://en.wikipedia.org/wiki/Scrum_%28software_development%29
  [twelve-factor-app]:          http://12factor.net
                                "Twelve-Factor App"
  [micro-services]:             http://martinfowler.com/articles/microservices.html
  [buildpack]:                  https://devcenter.heroku.com/articles/buildpacks
  [custom-buildpacks]:          https://devcenter.heroku.com/articles/third-party-buildpacks
  [riker-github]:               https://github.com/jschementi/riker
  [riker-blogpost]:             /riker-heroku-like-app-deploy-for-aws
  [riker-issues]:               https://github.com/jschementi/riker/issues
  [riker-pulls]:                https://github.com/jschementi/riker/pulls
  [boto]:                       http://boto.readthedocs.org/en/latest/
  [riker-pip]:                  https://pypi.python.org/pypi/riker
  [heroku-logo]:                /images/get-infrastructure-right/heroku-logo.jpg "Heroku"
  [heroku]:                     https://www.heroku.com/
  [docker-logo]:                /images/get-infrastructure-right/docker.png "Docker"
  [docker]:                     https://www.docker.com/
  [aws-logo]:                   /images/get-infrastructure-right/aws.png "Amazon Web Services"
  [aws-features]:               /images/get-infrastructure-right/AWS_Management_Console.png "AWS Features"
  [aws]:                        http://aws.amazon.com
  [aws-ec2]:                    http://aws.amazon.com/ec2/ "Amazon EC2"
  [aws-elb]:                    http://aws.amazon.com/elasticloadbalancing/
  [aws-autoscale]:              http://aws.amazon.com/autoscaling/
  [aws-ec2-instances]:          http://aws.amazon.com/ec2/instance-types/
  [aws-s3]:                     http://aws.amazon.com/s3/
  [aws-vpc]:                    http://aws.amazon.com/vpc/
  [aws-route53]:                http://aws.amazon.com/route53/
  [aws-opsworks]:               http://aws.amazon.com/opsworks/
  [aws-cf]:                     http://aws.amazon.com/cloudformation/
  [aws-beanstalk]:              http://aws.amazon.com/elasticbeanstalk/
  [aws-beanstalk-customami]:    http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.customenv.html
  [aws-dynamodb]:               http://aws.amazon.com/dynamodb/
  [mongodb]:                    http://www.mongodb.org/
  [vm]:                         http://en.wikipedia.org/wiki/Virtual_machine
  [digitalocean-logo]:          /images/get-infrastructure-right/docean.svg "Digital Ocean"
  [golang]:                     https://golang.org/
  [rolling updates]:            http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rollingupdates.html
  [codedeploy]:                 http://aws.amazon.com/codedeploy/
  [ec2 container service]:      http://aws.amazon.com/ecs/
  [lambda]:                     http://aws.amazon.com/lambda/
  [docean]:                     https://www.digitalocean.com/
  [docean-api]:                 https://developers.digitalocean.com/
  [docean-droplet]:             https://www.digitalocean.com/community/tutorials/how-to-create-your-first-digitalocean-droplet-virtual-server
  [haproxy]:                    http://www.haproxy.org/
  [dockerfile]:                 https://docs.docker.com/reference/builder/
