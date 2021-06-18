# Heroku Hosting Guideline

## Intro

Heroku is the PaaS platform of choice for Rootstrap, even as, in order to support larger projects and offer greater value by reducing our customer's infrastructure costs we are driven to adopt larger cloud providers, primarily AWS in its multiple offerings: plain IaaS (EC2), PaaS (Elastic Beanstalk), or container-based platforms (ECS/EKS).
This guide establishes a criteria for choosing Heroku as hosting platform for new projects and overall best practices around it.

### Table of Contents 

  - [Intro](#intro)
    - [Pros](#pros)
    - [Cons](#cons)
  - [Heroku vs AWS](#heroku-vs-aws)
    - [When to use Heroku](#when-to-use-heroku)
    - [When to move to AWS](#when-to-move-to-aws)
    - [Comparison Tools](#estimation-and-comparison-tools)
  - [Best Practices](#best-practices)


### Pros
* Very easy to get started 
* Free tier extends including most AddOns supports cheap PoC and MVP environments
* Quick fixes based on customer feedback are deployed immediately
* Setup can be implemented End2End without Linux Admin or DevOps expertise

### Cons
* Cost rise quickly after basic usage tiers
* No automated scalability out of the box (Addon solutions are also expensive)
* Not really feasible for very compute-intensive projects
* Deployments can be slow for larger apps
* Not all tech stacks supported


## Heroku vs AWS

### When to use Heroku

In order to deploy a new project into Heroku, most of these conditions should be met:

* Initial scope of the project is just an MVP
* Project will have low resource requirements (RAM, CPU) even in Production short/medium-term
* The project is built on a well-known and fully supported stack, eg.
    * Language:
        * Python: Django/Flask
        * Ruby: Rails 4+
        * Node.js 12+
    * Database:
        * PostgreSQL 11+
    * In-memory data store:
        * Redis 5
    * Email:
        * Sendgrid
        * Mailgun
    * Logging:
        * Papertrail
* There are no DevOps hours allocated to the project
* There is no available [Reference Architecture](https://www.notion.so/rootstrap/AWS-Architecture-5e8083e3968a45de9e240885a31921be) for AWS that fits the needs of the project

### When to move to AWS 

As a rule of thumb, when total ownership costs for the project in Heroku exceeds or are expected to exceed $350/month, it is worthwhile to invest in migrating to AWS.
This is the estimated cost for an application including:
* A Production environment with:
    * 4 (2 web, 2 workers) `Standard 2X` instances (1GB RAM, 2x CPU share) 
    * 1 `Standard 0` PostgreSQL instance (4GB RAM, 64 GB storage, 120-connection limit)
    * 1 `Premium 1` Redis instance (100MB memory, 80-connection limit)
    * 1 `Tough Tiger` RabbitMQ instance (10 million messages/month)
    * 1 `Fixa` Papertrail instance (65MB/day, 7-day indexing, 365-day archiving)
    * 1 `Bronze` Sendgrid instance (40k emails/momth)
    * Small dev team (up to 5 collaborators)
    * Standard Heroku Support plan
* A Staging environment with Hobby-level instances ($7/month) and free-tier data addons, with occasional upscaling (demo sessions, workshops, load testing)

This budget is just above a comparable setup in AWS, using dedicated (prod) and shared (staging) EC2 and RDS instances with on-demand purchasing + SES for email, including network traffic costs, EBS-backed storage, CloudWatch basic monitoring, with Developer-tier AWS support plan.

In addition, implementing recommended Reference Architectures in AWS should allow to reduce these costs, eg. by sharing larger instances and by combining reserved purchasing + spot purchasing for burst or async workloads

Scaling to further capacity, high-availability setups or greater storage needs quickly expands the cost difference between platforms.

### Estimation and comparison tools
Basic instance pricing: https://www.heroku.com/pricing

Add-ons: https://elements.heroku.com/addons 

Amazon cost calculator tool: https://calculator.s3.amazonaws.com/index.html

Amazon EC2/RDS instance comparison chart: https://www.ec2instances.info/

## Best Practices

Most configuration principles that apply to any cloud platform are valid here and should be elaborated further on the DevOps Hub. Some items which are particularly relevant for Heroku are worth mentioning here.

#### Concurrent web servers
Web applications that process concurrent requests make more efficient use of dyno resources than those that only process one request at a time. 

Official recommendations from Heroku are:
* Ruby: [Puma](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server)
* Python: [Gunicorn](https://devcenter.heroku.com/articles/python-gunicorn)

#### Officially supported buildpacks and tools
Heroku has official buildpacks, among other languages, for:
* [Ruby](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-ruby)
    * Rails 4.x and higher
    * Use Bundler for dependency management
* [Python](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-python)
    * supported runtimes: 3.6, 3.7, 2.7(not recommended)
    * Django or Flask framwork
    * Celery for async tasks
    * Any other pip-installable packages are supported, except some with C dependencies  
* [Node](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-nodejs) 
    * supported runtimes: 13.x, 12.x, 10.x(not recommended)
    * dependencies installed from package.json using Yarn or npm

#### Separate environments
When maintaining more than one environment on Heroku (eg. Development, Test, Demo, Staging, Production), each should be configured as a separate app.

If there are multiple repos that belong to the same project, each component should be deployed as an independent app with their own environment-specific deploys.

[Pipelines](https://devcenter.heroku.com/articles/pipelines) can be used to promote the same build between environments, **except** if the application has a stateful build, ie compiles configuration variables into the deployed artifact (which regardled of the platform or deployment method must be avoided if at all possible).

#### Continuous deployment from GitHub 
Configure GitHub integration for Heroku apps to enable automatic deploy upon specified branches: https://devcenter.heroku.com/articles/github-integration

Integrations should be configured in a manner consistent with the [Git Workflow guide](../git/README.md), eg.
* Every PR merged into `develop` should automatically be deployed to Development env
* Deploy demo branches to specific environment for this purpose (Staging or Demo)
* Deploy Releases (from either `develop` or `master`) automatically to Staging environment 
* Trigger deploys to Production manually and from release tags in `master` branch or by promoting the latest release on Staging using a pipeline.

#### S3 for static files

Application dynos have ephemeral filesystems, meaning a solution is required for hosting static durable files (eg React frontend apps).

Amazon S3 is the preferred platform for serving static files  due to its very low price, high availability and durability, and caching capabilities (using CloudFront).

All supported languages in Heroku can use the S3 API for handling file uploads: https://devcenter.heroku.com/articles/s3
