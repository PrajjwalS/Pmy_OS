#!/bin/bash
docker run --rm \
  -u $(id -u):$(id -g) \
  -v "$(pwd)/src":/workspace \
  pmyos_build_img make -C /workspace "$@"
