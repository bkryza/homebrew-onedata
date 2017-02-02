# Onedata Homebrew tap

This repository contains [Brew](http://brew.sh/) formulas for [Onedata](https://onedata.org) OSX utilities.

The releases are only built from 'releases' branch, where a new release
should be merged from master and the hash i 'bottle do' block should be removed.

After that a tag should be created based on the oneclient naming pattern, e.g.:

3.0.0-rc11-78-g8a770a72

After the tag is pushed to the repository, the build starts and produces the
built hash on the output which should be updated in the oneclient.rb on the
master branch.
