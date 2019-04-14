#!/bin/sh

docker run --rm -v $(pwd)/user:/opt/build/src asciidoc-template
