#!/bin/bash
./lacp.sh -i private  -m 0c:42:a1:a7:31:e6 ens33f0 ens33f1 ens43f0 ens43f1
ip addr add 10.0.0.1/24 dev private
