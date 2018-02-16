# Download Google Extensions

Downloads a bunch of Chrome Extensions by Google for learning purposes.

Gives you a rough idea of how some really good extensions are built.
Note that you won't get the full picture, as the bundled version of an
extension on the web store can be very different than the development
version.

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
