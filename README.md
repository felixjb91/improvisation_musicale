# Improvisation Musicale aka Musical Improvisation

An academic project written in OCaml to help understand the concepts of functional programming.

## Compiling and Testing

### Ubuntu

The application can be compiled and run using the bash script, run.sh, in the project root directory.

```
sh run.sh
```

### Other Platforms

The application has multiple dependencies as listed below.

* OCaml 4.05.0
* Opam
* Gtk+ 2.0 with libcanberra
* Expat
* SDL1.2, SDL_Mixer1.2
* OCaml Modules - dune, graphics, lablgtk, ocamlsdl, conf-sdl-mixer, mm, alcotest

Once the dependencies are installed, the project can be built using dune. 

```
dune build
```

Dune, by default, creates the executable under "_build/install/default/bin/".