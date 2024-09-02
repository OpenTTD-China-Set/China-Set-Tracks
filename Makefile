# This makefile is only used to render voxel graphics

# render command
CMD_RENDER := renderobject

# vox files
VOX := $(shell find gfx -name "*.vox")

# corresponding png files
PNG_8BPP  := $(VOX:.vox=_8bpp.png)
PNG_MASK  := $(VOX:.vox=_mask.png)
PNG_32BPP := $(VOX:.vox=_32bpp.png)

PNG := $(PNG_8BPP) $(PNG_MASK) $(PNG_32BPP)

# convert vox to png
%_8bpp.png %_mask.png %_32bpp.png: %.vox
	@echo "Rendering $<"
	$(CMD_RENDER)

# default target, renders all voxel models in this repo
render: $(PNG)
