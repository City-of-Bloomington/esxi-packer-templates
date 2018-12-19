#!/bin/sh

PACKER_KEY_INTERVAL=10ms packer build -var-file=secret.json -var-file=env.json ubuntu/ubuntu.json