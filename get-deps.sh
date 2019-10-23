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
VER=2.4.0-SNAPSHOT
git checkout master
cp -rf docs ../documentation/${VER}
#mvn package -Pdist -DskipTests
#cp -r distribution/target/quartz-${VER}-distribution.tar.gz ../downloads/files
#mkdir -p ../api/${VER}
#cp -r distribution/target/quartz-${VER}/javadoc/* ../api/${VER}

# Copy 2.3.x version of quartz docs to a subdir:
VER=2.3.3-SNAPSHOT
git checkout quartz-2.3.x
cp -rf docs ../documentation/${VER}
#mvn package -Pdist -DskipTests
#cp -r distribution/target/quartz-${VER}-distribution.tar.gz ../downloads/files
#mkdir -p ../api/${VER}
#cp -r distribution/target/quartz-${VER}/javadoc/* ../api/${VER}

# clean up
popd
rm -rf __reference
