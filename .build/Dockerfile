FROM nvidia/cuda:10.0-cudnn7-runtime
SHELL [ "/bin/bash", "-c" ]

# install apt package
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils 2>&1 \
    && apt-get install -y git procps lsb-release make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# install pyenv
ENV PATH=/root/.pyenv/bin:$PATH
COPY .build/init.sh /root/
RUN curl https://pyenv.run | bash && cat /root/init.sh >> ~/.bashrc

# install python
ENV PY_VER=3.7.3
RUN . /root/init.sh \
    && pyenv update \
    && pyenv install $PY_VER \
    && pyenv global $PY_VER \
    && pip3 install -U pip \
    && pip3 install pipenv

# setup dev environment
WORKDIR /workspace
COPY .build/jupyter_notebook_config.py  /root/.jupyter/
COPY Pipfile /workspace/
RUN . /root/init.sh && pipenv install --python $PY_VER
