# Just isn't required to build the GRF
# You can always excute the commands listed here separately

# default target
def: sprites code

# make all sprites
sprites:
    make -j 8

# generate code
code:
    gcc -E -x c tracks.pnml > tracks.nml
    nmlc tracks.nml --grf=china-set-tracks.grf --md5=china-set-tracks.md5 --nml=china-set-tracks_parsed.nml
    @echo
    @echo "GRF file generated, MD5 hash:"
    @echo "Date: $(date "+%Y-%m-%d %H:%M:%S"), \
           GRF Hash: $(cat china-set-tracks.md5), \
           Git Hash: $(git rev-parse HEAD)" | tee -a hashes.log
    @echo

# copy to designated folder
copy:
    cp china-set-tracks.grf /d/data/documents/openttd/newgrf/

# clean all
clean_all: clean_grf clean_png

# clean GRF files
clean_grf:
    find . -name '*.grf' -delete

# clean PNG files
clean_png:
    find ./vox/ -name '*.png' -delete

# install dependecies, assuming on Windows
deps:
    scoop bucket add openttd-bucket https://github.com/wensimehrp/openttd-bucket
    scoop install openttd-bucket/gorender
    scoop install openttd-bucket/nml

clean_png_dir dir:
    find ./vox/{{dir}} -name '*.png' -delete
