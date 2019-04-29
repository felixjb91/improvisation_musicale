#! /usr/bin/env bash

echo "Improvisation Musicale"

if [ $(dpkg-query -W -f='${Status}' ocaml 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "ocaml not installed"
  echo "Installing OCaml - requires sudo permissions"
  sudo brew install ocaml
fi

if [ $(dpkg-query -W -f='${Status}' libsdl1.2-dev 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "SDL libraries not installed"
  echo "Installing libsdl1.2-dev - requires sudo permissions"
  sudo brew install libsdl1.2-dev libsdl-mixer1.2-dev -y
fi

if [ $(dpkg-query -W -f='${Status}' libgtk2.0-dev 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "GTK2 libraries not installed"
  echo "Installing libgtk2.0-dev - requires sudo permissions"
  sudo apt-get install libexpat1-dev libgtk2.0-dev -y
fi

echo "Installing required libraries..."

opam install dune graphics lablgtk ocamlsdl conf-sdl-mixer mm -y

echo "Building the project..."

dune build

echo "Launching the app..."

cd _build/install/default/bin/

./improvisation_musicale