#!/usr/bin/env bash

awk -F " "  '{print $2}' sample.log | uniq -c | sort -r