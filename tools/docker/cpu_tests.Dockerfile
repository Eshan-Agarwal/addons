FROM python:3.5

COPY tools/install_deps/tensorflow-cpu.txt ./
RUN pip install -r tensorflow-cpu.txt

RUN apt-get update && apt-get install -y sudo rsync
COPY tools/install_deps/bazel_linux.sh ./
RUN bash bazel_linux.sh

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY tools/install_deps/finish_bazel_install.sh ./
RUN bash finish_bazel_install.sh

COPY ./ /addons
WORKDIR addons
RUN bash tools/testing/addons_cpu.sh --no-deps

RUN bazel build --enable_runfiles build_pip_pkg
RUN bazel-bin/build_pip_pkg artifacts


FROM python:3.5

COPY tools/install_deps/tensorflow-cpu.txt ./
RUN pip install -r tensorflow-cpu.txt

COPY --from=0 /addons/artifacts /artifacts

RUN pip install /artifacts/tensorflow_addons-*.whl

# check that we didnd't forget to add a py file to
# The corresponding BUILD file.
# Also test that the wheel works in a fresh environment
RUN python -c "import tensorflow_addons"
