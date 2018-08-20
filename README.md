# WSGI-Base

![master Branch](https://img.shields.io/badge/branch-master-blue.svg)
[![master Build Status](https://travis-ci.org/DD-DeCaF/wsgi-base.svg?branch=master)](https://travis-ci.org/DD-DeCaF/wsgi-base)

Base Docker image(s) for WSGI microservices in the DD-DeCaF organization.

Since we have decided to rely on gunicorn with gevent workers (and Flask) for
our synchronous microservices, this image allows us to consolidate the costly 
compilation of gevent (or rather greenlet). As an added bonus openssl and
certificates are always updated by the cron job building this base image.

## Copyright

* Copyright (c) 2018, Novo Nordisk Foundation Center for Biosustainability,
  Technical University of Denmark.
* This work is licensed under the [Apache License, Version 2.0](LICENSE)
