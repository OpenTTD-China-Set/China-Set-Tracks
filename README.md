# China Set: Tracks

Chinese track set.

## Building

Requirements:

* Make
* NML
* gcc
* python
* gorender (renderobject)
* sh (Comes with Git on Windows)

**Just** is encouraged but not required. You can execute the commands listed in `Justfile` separately.

To compile, simply run

```bash
just
```

or

```bash
make -j 8 ;
gcc -E -x c tracks.pnml > tracks.nml ;
nmlc tracks.nml --grf=china-set-tracks.grf
```

in your terminal. The graphics should be automatically compiled.

## Contributors

### Graphics

* NACHN

### Code

* WenSim
