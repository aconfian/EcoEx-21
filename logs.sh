#!/bin/bash
tail -n 0 -f /var/log/kern.log | cut -d ":" -f 4-
