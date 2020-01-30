BASH Utilities
==============

A highly opinionated way of configuring your BASH environment.

Requirements
------------

- BASH 4 or greater

Installation
------------

1. Clone the repository.
2. Edit your `.bashrc` script.
    1. Define `BASH_UTILS` as the path to the repository.
    2. Add: `. "$BASH_UTILS/bootstrap.sh" "$(tty)"`

Usage
-----

### Enabled Features

To list which features have been enabled, run

```sh
echo "$BASH_UTILS_FEATURES"
```
