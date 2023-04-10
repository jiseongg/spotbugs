#!/usr/bin/env bash

SPOTBUGS_HOME=$(cd $(dirname $0); pwd)

if [[ -z $SHELL_CONFIG ]]; then
  SHELL_CONFIG=${HOME}/.zshrc
fi

(
  cd $SPOTBUGS_HOME/spotbugs
  gradle clean assemble -x test
)

TAR_ARCHIVE=$(find "${SPOTBUGS_HOME}/spotbugs/build/distributions/" -name "*.tgz")
DISTRIBUTIONS_HOME=$(dirname $TAR_ARCHIVE)
(
  cd $DISTRIBUTIONS_HOME
  tar zxvf $TAR_ARCHIVE
)

TAR_DIR=$(echo $TAR_ARCHIVE | rev | cut -d'.' -f2- | rev)
_SPOTBUGS_JAR="${TAR_DIR}/lib/spotbugs.jar"

if [[ ! $SPOTBUGS_JAR =~ $_SPOTBUGS_JAR ]]; then
  echo "export SPOTBUGS_JAR=$_SPOTBUGS_JAR" >> $SHELL_CONFIG
fi

