set -eux
cookiecutter --no-input https://github.com/DD-DeCaF/cookiecutter-flask-microservice
pushd name-of-the-project
make pip-compile
# The generated requirements file is initially owned by root, so update ownership.
sudo chown -R travis .
make setup build qa
popd