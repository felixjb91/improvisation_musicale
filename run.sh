#! /usr/bin/env bash

echo "Improvisation Musicale"

if [ $(dpkg-query -W -f='${Status}' ocaml 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "ocaml not found. Please install ocaml and try again"
  sudo apt-get install ocaml
fi

echo "Installing dependencies..."
echo "Requires sudo permissions..."

sudo apt-get install opam libcanberra-gtk-module libcanberra-gtk3-module

echo "Installing required libraries..."

opam install dune graphics lablgtk2

echo "Building the project..."

dune build

echo "Launching the app..."

cd _build/install/default/bin/

./improvisation_musicale