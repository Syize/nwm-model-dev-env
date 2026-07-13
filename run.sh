#!/bin/bash

sudo docker compose up -d --force-recreate

echo "================================"
echo "Container status:"
sudo docker compose ps
echo "================================"
echo "Container logs:"
sudo docker compose logs