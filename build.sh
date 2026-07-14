#!/bin/bash

sudo docker buildx build --network=host -t numerical-model-dev .
