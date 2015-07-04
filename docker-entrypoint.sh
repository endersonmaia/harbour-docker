#!/bin/bash
set -e

if [ "$1" = 'harbour' ]; then

  shift

	exec "harbour" "$@"
  
fi

exec "$@"
