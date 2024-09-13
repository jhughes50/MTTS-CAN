#!/bin/bash
#

xhost + 
docker run --rm -it --gpus all \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -v "/tmp/.X11-unix:/tmp/.X11-unix" \
    -v "/home/jason/dtc-dev/MTTS-CAN:/home/jason/MTTS-CAN" \
    -v "/home/jason/ROS/bags/data_colect_sept13:/home/jason/data" \
    dtc-mtts \
    bash
