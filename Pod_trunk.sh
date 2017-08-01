#!/usr/bin/env bash

echo "Hardik"
source ~/.rvm/scripts/rvm
rvm use default
pod trunk push HKKit.podspec --verbose
