# Node.JS Style Guide

## Table of Contents

1. [Project Scaffolding & Structure](#1-project-structure-practices)
2. [Error Handling](#2-error-handling-practices)
3. [Code Style Practices](#3-code-style-practices)
4. [Security Practices](#4-security-best-practices)
5. [Performance Practices](#5-draft-performance-best-practices)
6. [Express Specifics](#6-express-specifics-best-practices)
7. [Code Quality and Complexity Management](#8-quality-complexity)

<br/><br/>

# `4. Security Best Practices`

## ![✔] 4.1. Use Helmet

It protects your app from some well-known web vulnerabilities by setting HTTP headers appropriately.
Helmet is actually just a collection of smaller middleware functions that set security-related HTTP response headers, like:

- CSP (Content-Security-Policy) header to prevent cross-site scripting attacks.
- hidePoweredBy removes the X-Powered-By header.
- ieNoOpen sets X-Download-Options for IE8+.

**Otherwise:** Your app will be vulnerable to some well known attacks.

🔗 **READ MORE:** https://expressjs.com/en/advanced/best-practice-security.html#use-helmet

## ![✔] 4.2. How to decide which Node.js version?

Don’t use deprecated or vulnerable versions of the framework you are using.
A good way to go is to always use the last stable version.

**Otherwise:** You could have security issues and no support working on them

🔗 **READ MORE (Express.js specific):** https://expressjs.com/en/advanced/best-practice-security.html#dont-use-deprecated-or-vulnerable-versions-of-express

# `5. Performance Best Practices`

## ![✔] 5.1. Use gzip compression

Gzip compressing can greatly decrease the size of the response body and hence increase the speed of a web app.

**Otherwise:** You could face long waiting times in large paylods/high-traffic web apps.

**GTK:** For a high-traffic website in production, the best way to put compression in place is to implement it at a reverse proxy level (see Use a reverse proxy). In that case, you do not need to use compression middleware.

## ![✔] 5.2. Do not use console.log

Not for the obvious reasons, but because console.log are synchronous when the destination is a terminal or a file, so they are not suitable for production, unless you pipe the output to another program.

**GTK:** Use a more mature logger like Winston or Bunyan

🔗 **READ MORE:** https://strongloop.com/strongblog/compare-node-js-logging-winston-bunyan/

## ![✔] 5.3. Set NODE_ENV='production' for Production Environment (Express.js specific)

Setting NODE_ENV to “production” makes Express:

- Cache view templates.
- Cache CSS files generated from CSS extensions.
- Generate less verbose error messages.

🔗 **READ MORE:** https://www.dynatrace.com/news/blog/the-drastic-effects-of-omitting-node-env-in-your-express-js-applications/
