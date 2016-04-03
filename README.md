# itunes-cleanup

DISCLAIMER: This script is pretty ROUGH. Please read code carefully before use.

Most important part of this script may be XPath to extract URIs of files in iTunes Library.

## Problem I want to solve

iTunes seems to (or seemed to) have a bug that:

When you change artist, album or compilation flag with "Organize Files" checked, both file with updated tags (in right directory) and file with old tags (in old, past directory) remains on disk.

`itunes-cleanup.rb` scans `iTunes Library.xml` and deletes files in `iTunes Media` directory if it does not organized by iTunes.

## Requirements

- OS X (is the only platform I tested)
- Ruby
- Bundler (to install dependencies)
