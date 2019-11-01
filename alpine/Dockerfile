# Copyright 2018 Novo Nordisk Foundation Center for Biosustainability, DTU.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM python:3.6-alpine3.8

ENV PYTHONUNBUFFERED=1

RUN apk update

RUN apk add --no-cache openssl ca-certificates

WORKDIR /opt

COPY wsgi-requirements.in ./

# `g++` is required for building `gevent` but all build dependencies are
# later removed again to reduce the layer size.
RUN set -eux \
    && apk add --no-cache --virtual .build-deps g++ \
    && pip install --upgrade pip setuptools wheel pip-tools \
    && pip-compile --generate-hashes \
        --output-file wsgi-requirements.txt wsgi-requirements.in \
    && pip-sync wsgi-requirements.txt \
    && rm -rf /root/.cache \
    && apk del .build-deps
