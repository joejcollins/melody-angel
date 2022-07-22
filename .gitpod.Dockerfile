FROM gitpod/workspace-full

USER gitpod

RUN sudo apt-get -q update \
 && sudo apt-get install -yq libpython3.6 rustc

ENV RUST_LLDB=/usr/bin/lldb-8
