#! /bin/bash -ue

docker run \
    --name wkspace-ml -it --rm --mount type=bind,src=$PWD,dst=/workspace \
    -p 8888:8888 --runtime nvidia learning-ml \
    /bin/bash --login -ic 'pipenv run jupyter notebook password && pipenv run jupyter lab --ip 0.0.0.0 --allow-root'