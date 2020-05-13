#!/bin/bash -eux

shellcheck $(/usr/local/bin/shfmt -f .)
