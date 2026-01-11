# =========================================================
# Top-level Makefile for PmyOS
# Build inside Docker, Run QEMU on host
# =========================================================

.PHONY: docker-build build run clean shell

build_img:
	docker build -t pmyos_build_img	.

build:
	./scripts/build.sh all

run:
	./scripts/run.sh

clean:
	./scripts/build.sh clean

shell:
	./scripts/shell.sh $@
