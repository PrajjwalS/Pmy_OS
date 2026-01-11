#!/bin/bash
docker run -it --rm \
  -u $(id -u):$(id -g) \
  -v "$(pwd)/src":/workspace \
  pmyos_build_img bash
