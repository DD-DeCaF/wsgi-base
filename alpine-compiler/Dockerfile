# Copyright 2019-2020 Novo Nordisk Foundation Center for Biosustainability, DTU.
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

ARG BASE_TAG=alpine

FROM dddecaf/wsgi-base:${BASE_TAG}

ARG BUILD_COMMIT

LABEL dk.dtu.biosustain.wsgi-base.alpine-compiler.vendor="Novo Nordisk Foundation Center for \
Biosustainability, Technical University of Denmark"
LABEL maintainer="niso@biosustain.dtu.dk"
LABEL dk.dtu.biosustain.wsgi-base.alpine-compiler.build.commit="${BUILD_COMMIT}"

RUN set -eux \
    # Install build tools. These can be required for the `pip-compile` step in
    # child images that require to build packages from source.
    && apk add --no-cache build-base libffi-dev \
    # Re-run pip-compile in order to pre-populate the pip cache.
    && pip-compile --allow-unsafe --generate-hashes --verbose \
        --output-file /dev/null /opt/base-requirements.txt \
    # Create the directory for service requirements placement.
    && mkdir -p /opt/requirements
