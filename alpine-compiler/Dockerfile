FROM dddecaf/wsgi-base:alpine

RUN set -eux \
    # Install build tools. These can be required for the `pip-compile` step in
    # child images that require to build packages from source.
    && apk add --no-cache build-base \
    # Re-run pip-compile in order to pre-populate the pip cache.
    && pip-compile --generate-hashes --verbose --output-file /dev/null \
      /opt/base-requirements.txt
    # Create the directory for service requirements placement.
    && mkdir -p /opt/requirements
