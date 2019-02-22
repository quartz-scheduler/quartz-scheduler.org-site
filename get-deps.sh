#!/bin/bash -e

#########################################################
# Checks out site content dependencies needed to generate the full site
#########################################################

# Check out the events repo as a direct subdir
#git clone --depth=1 https://github.com/Terracotta-OSS/terracotta.org-site-events.git events

# Check out a single copy of quartz to use below:
git clone https://github.com/quartz-scheduler/quartz.git __reference
pushd __reference

# Copy latest version of quartz docs to a subdir:
git checkout master
cp -rf docs ../documentation/2.4.0-SNAPSHOT

# Copy 2.3.x version of quartz docs to a subdir:
git checkout quartz-2.3.x
cp -rf docs ../documentation/2.3.1-SNAPSHOT

# clean up
popd
rm -rf __reference
