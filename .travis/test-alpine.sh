set -eux

# Test the image (alpine packages + python dependencies) by creating a service
# on top of the base image that was just built, and run the QA suite.
# Note that we're using the master branch of the cookiecutter repo, which has
# already passed QA. Hence, we're not testing the state of the cookiecutter
# here - just that it works with the new dependencies installed in the base
# image.

cookiecutter --no-input https://github.com/DD-DeCaF/cookiecutter-flask-microservice
pushd name-of-the-project
make pip-compile
# The generated requirements file is initially owned by root, so update ownership.
sudo chown -R travis .
make setup build qa
popd
