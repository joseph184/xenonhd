#!/bin/bash

git config --global user.name 'Joseph Morant Navarro'
git config --global user.email 'joseph.morantnavarro@gmail.com'
git config --global color.ui true

export USE_CCACHE=1 &&
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m" &&

if [ -z $(which repo) ]; then
    mkdir -p $HOME/bin &&
    curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > $HOME/bin/repo &&
    chmod a+x $HOME/bin/repo &&
    export PATH=$PATH:$HOME/bin;
fi &&

if [ -z $USER ]; then export USER=$(whoami); fi

mkdir -p $HOME/xenon &&
cp -r --parents .repo $HOME/xenon &&

cd $HOME/xenon &&
repo init -u https://github.com/joseph184/platform_manifest.git -b n &&
repo sync -c -n -j 4 && repo sync -c -l -j 8 &&
. build/envsetup.sh && breakfast hydrogen && brunch hydrogen
