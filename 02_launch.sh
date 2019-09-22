#! /bin/bash -ue

docker run \
    --name wkspace-ml -it --rm --mount type=bind,src=$PWD,dst=/workspace \
    -p 8888:8888 --runtime nvidia learning-ml