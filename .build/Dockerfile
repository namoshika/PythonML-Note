FROM nvidia/cuda:10.0-cudnn7-runtime
SHELL [ "/bin/bash", "-c" ]

# install apt package
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils language-pack-ja language-pack-ja-base 2>&1 \
    && apt-get install -y git procps lsb-release make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8

# set locale
ENV LANGUAGE=ja_JP:ja
ENV LANG=ja_JP.UTF-8
ENV LC_TIME=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8

# install pyenv
ENV PATH=/root/.pyenv/bin:$PATH
COPY .build/init.sh .build/start.sh /root/
RUN curl https://pyenv.run | bash && cat /root/init.sh >> ~/.bashrc && chmod a+x /root/start.sh

# install python
ENV PY_VER=3.7.3
RUN . /root/init.sh \
    && pyenv update \
    && pyenv install $PY_VER \
    && pyenv global $PY_VER

# install package
RUN . /root/init.sh \
    && pip3 install -U pip setuptools certifi \
    && pip3 install jupyterlab matplotlib numpy scipy pandas tensorflow-gpu==2.0.0rc1 scikit-learn pillow mglearn pydotplus graphviz

# setup dev environment
WORKDIR /workspace
COPY .build/jupyter_notebook_config.py  /root/.jupyter/
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
CMD [ "/bin/bash", "-ic", "/root/start.sh" ]