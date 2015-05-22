#!/bin/bash

set -o errexit -o nounset

addToDrat(){
  cd ..; mkdir drat; cd drat

  ## Set up Repo parameters
  git init
  git config user.name "Colin Gillespie"
  git config user.email "csgillespie@gmail.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GH_TOKEN@github.com/rcourses/drat.git"
  git fetch upstream
  git checkout gh-pages

  Rscript -e "drat::insertPackage(devtools::build('../nclRpredictive'), \
    repodir = '.', \
    commit='Travis update: build $TRAVIS_BUILD_NUMBER')"
  git push

}

addToDrat
