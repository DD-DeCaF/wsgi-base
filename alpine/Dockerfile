# Copyright 2018-2020 Novo Nordisk Foundation Center for Biosustainability, DTU.
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

FROM python:3.6-alpine3.10

ARG BUILD_COMMIT
ARG BUILD_TIMESTAMP

LABEL dk.dtu.biosustain.wsgi-base.alpine.vendor="Novo Nordisk Foundation Center for \
Biosustainability, Technical University of Denmark" \
    dk.dtu.biosustain.wsgi-base.alpine.commit="${BUILD_COMMIT}" \
    dk.dtu.biosustain.wsgi-base.alpine.timestamp="${BUILD_TIMESTAMP}"

ENV PYTHONUNBUFFERED=1

ENV APP_USER=giraffe

ARG UID=1000
ARG GID=1000

# Create a user for running applications if desired.
RUN set -eux \
    && addgroup -g "${GID}" -S "${APP_USER}" \
    && adduser -u "${UID}" -G "${APP_USER}" -S "${APP_USER}"

# Work in the /opt directory to persist the pip-compiled requirement list for
# child images to use.
WORKDIR /opt

# Update OpenSSL and certificates
RUN apk add --no-cache openssl ca-certificates

COPY base-requirements.in ./

RUN set -eux \
    # Install build dependencies to make sure we can build packages that don't
    # provide pre-built wheels from source.
    && apk add --no-cache --virtual .build-deps build-base libffi-dev \
    # Make sure to use the latest python build tools.
    && pip install --upgrade pip setuptools wheel pip-tools \
    # Fetch the latest versions of all requirements. It is OK if this fails the
    # build; child images may use the previous version of the wsgi-base image
    # and will continue to work.
    && pip-compile --generate-hashes --verbose \
        --output-file base-requirements.txt base-requirements.in \
    # Pre-install the compiled requirements to save some build time for child
    # images.
    && pip-sync base-requirements.txt \
    # Remove build dependencies and pip cache to reduce layer size.
    && apk del .build-deps \
    && rm -rf /root/.cache
