# The program Just isn't required to build the GRF
# You can always excute the commands listed here separately

# default target
def: sprites code

# make all sprites
sprites:
    make

# generate code
code:
    gcc -E -x c tracks.pnml > tracks.nml
    nmlc tracks.nml --grf=china-set-tracks.grf

# install dependecies, assuming on Windows
deps:
    scoop bucket add openttd-bucket https://github.com/wensimehrp/openttd-bucket
    scoop install openttd-bucket/gorender
    scoop install openttd-bucket/nml
    scoop install mingw
