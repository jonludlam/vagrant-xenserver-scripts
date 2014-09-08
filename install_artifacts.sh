#!/bin/bash

if [ x"$2" == "x" ]; then
  build=lastSuccessfulBuild
else
  build=$2
fi

echo "Install artifacts from xen-git job name $1 build $build"

dir=`mktemp -d`
pushd $dir
wget xen-git.uk.xensource.com:8080/job/$1/$build/artifact/\*zip\*/archive.zip
unzip archive.zip
sudo find . -name "*.rpm" -exec rpm -Uvh --force --nodeps {} +
popd

#rm -rf $dir


