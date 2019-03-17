#!/bin/bash

set -e

DIRS="-Is src"
TARGET="src/miniml src/tests "
FLAGS="-cflag -g -lflag -g -libs str $DIRS"
OCAMLBUILD=ocamlbuild

ocb()
{
    $OCAMLBUILD -use-ocamlfind $FLAGS $*
}

if [ $# -eq 0 ]; then
    action=native
else
    action=$1;
    shift
fi

case $action in
    clean)  ocb -clean;;
    native) ocb ${TARGET//" "/".native "} ;;
    byte)   ocb ${TARGET//" "/".byte "} ;;
    all)    ocb ${TARGET//" "/".native "} ${TARGET//" "/".byte "} ;;
    prof)   ocb ${TARGET//" "/".p.native "} ;;
    *)      echo "Unknown action $action";;
esac;

