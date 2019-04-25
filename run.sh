#! /usr/bin/env bash

echo "Improvisation Musicale"

if [ $(dpkg-query -W -f='${Status}' ocaml 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "ocaml not found. Please install ocaml and try again"
  exit 1
fi

echo "Installing required libraries..."

opam install dune graphics

echo "Building the project..."

dune build

echo "Launching the app..."

cd _build/install/default/bin/

./improvisation_musicale