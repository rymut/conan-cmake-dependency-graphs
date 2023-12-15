# Conan CMake dependency graphs

This repository aims to show how to generate better dependency graphs for projects using cmake & conan.

## Problem

Using `conan graph info` generates only 

## To do 

- [x] Generate conan lock file
- [x] Generate conan graph
- [ ] Filter cmake graphviz nodes
  - [x] Basic filtering with `process.sh` script working with conan<2 
- [ ] Generate json compatible library
  - [ ] Check VivaGraph
  - [ ] Check Vis.js
- [ ] Presentation page
  - [ ] Draw graph generated from graphvis & conan graph

## Required software

- Conan 2.0
- Cmake
- Graphviz

## Demo project

Enter repository directory.

Generate project with graph with cmake

`cmake -S . -B build --graphviz=demo.dot -DCMAKE_BUILD_TYPE=Release -DCMAKE_CONFIGURATION_TYPES=Release`

Generate library graph with conan

`conan graph info --lockfile build/conan.lock . --format json > demo.json`

Execute 'process.sh'