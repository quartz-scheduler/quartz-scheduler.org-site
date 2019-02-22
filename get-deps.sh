#!/bin/bash -e

LATEST_QUARTZ_BRANCH=master
LATEST_QUARTZ_VERSION=2.4.0-SNAPSHOT

#########################################################
# Checks out site content dependencies needed to generate the full site
#########################################################

# Check out the events repo as a direct subdir
#git clone --depth=1 https://github.com/Terracotta-OSS/terracotta.org-site-events.git events

# Check out a single copy of quartz to use below:
git clone -b $LATEST_QUARTZ_BRANCH https://github.com/quartz-scheduler/quartz.git __reference

# Copy a version of quartz docs to a subdir:
mkdir -p documentation
cp -rf __reference/docs documentation/$LATEST_QUARTZ_VERSION

# clean up
rm -rf __reference
