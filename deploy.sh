#!/bin/bash
git clone https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
