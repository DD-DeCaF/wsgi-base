# WSGI-Base

![master Branch](https://img.shields.io/badge/branch-master-blue.svg)
[![master Build Status](https://travis-ci.org/DD-DeCaF/wsgi-base.svg?branch=master)](https://travis-ci.org/DD-DeCaF/wsgi-base)

Base Docker image(s) for WSGI microservices in the DD-DeCaF organization.

Since we have decided to rely on gunicorn with gevent workers (and Flask) for
our synchronous microservices, this image allows us to consolidate the costly
compilation of gevent (or rather greenlet). As an added bonus openssl and
certificates are always updated by the cron job building this base image.

## Images

Three images are built:

* `dddecaf/wsgi-base:alpine` as a base image for most of our services.
* `dddecaf/wsgi-base:alpine-compiler` for those child images depending on
    `dddecaf/wsgi-base:alpine`, this image contains all the build tools in order to
    `pip-compile` dependencies.
* `dddecaf/wsgi-base:debian` as a base image for those services that absolutely need
    a Debian environment (avoiding libc hassles and workarounds).

These image tags correspond to the `latest` tag. Additionally, a cron job on
Travis CI builds these images with a date and short git commit tag, for example,
`dddecaf/wsgi-base:alpine_2020-04-28_72664d7`. **When compiling dependencies
child images should rely on those explicitly.**

All images include labels that detail the full commit hash and timestamp of
their build time. This information is available via [docker image
inspect](https://docs.docker.com/engine/reference/commandline/image_inspect/).

## Copyright

* Copyright (c) 2018-2020, Novo Nordisk Foundation Center for Biosustainability,
  Technical University of Denmark.
* This work is licensed under the [Apache License, Version 2.0](LICENSE)
