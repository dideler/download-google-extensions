# Download Google Extensions

<img width="958" alt="screen shot 2018-02-16 at 16 56 14" src="https://user-images.githubusercontent.com/497458/36321578-2bc024f6-1342-11e8-930d-88ee3a3d2b96.png">

Downloads the source for a bunch of Chrome Extensions by Google for learning purposes.

Gives you a rough idea of how some really good extensions are built.
Note that you won't necessarily get the full picture, as the bundled version of an
extension on the web store can differ from the development version (e.g. minified
source or development libraries not being bundled).

## Installation

Create the CLI tool by running `mix escript.build`

View help for more info

```
↪ ./download_google_extensions -h
Command-line tool for downloading Google's Chrome Extensions.

Usage:

    download_google_extensions [options]

## Options

    -h, --help        # Shows this help and exits
    -v, --version     # Shows the program version and exits
    -p, --parallel    # Downloads extensions in parallel (default behaviour)
    -s, --sequential  # Downloads extensions sequentially
        --serial      # Synonym for --sequential
```
