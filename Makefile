# THIS MAKEFILE REQUIRES SH TO RUN, and is only used for rendering voxel models

# render commands
RENDER_LIST_FILE   := render_list.json
DEFAULT_MANIFEST   := $(shell jq -r '.default_manifest' $(RENDER_LIST_FILE))
DEFAULT_PALETTE    := $(shell jq -r '.default_palette' $(RENDER_LIST_FILE))
RENDER_EXE         := renderobject
CMD_RENDER         := $(RENDER_EXE) -overwrite

# vox files
VOX := $(shell find vox -name "*.vox")

# corresponding png files
PNG_8BPP  := $(VOX:.vox=_8bpp.png)
PNG_MASK  := $(VOX:.vox=_mask.png)
PNG_32BPP := $(VOX:.vox=_32bpp.png)

PNG := $(PNG_8BPP) $(PNG_MASK) $(PNG_32BPP)

# convert vox to png
%_8bpp.png %_mask.png %_32bpp.png: %.vox
	@export MANIFEST=$(shell jq -r --arg key "$<" --arg default "$(DEFAULT_MANIFEST)" \
						  'if .[$$key] and .[$$key].manifest then .[$$key].manifest else $$default end' $(RENDER_LIST_FILE)); \
	export PALETTE=$(shell jq -r --arg key "$<" --arg default "$(DEFAULT_PALETTE)" \
						  'if .[$$key] and .[$$key].palette then .[$$key].palette else $$default end' $(RENDER_LIST_FILE)); \
	echo "Rendering $<, using manifest $$MANIFEST" and palette $$PALETTE; \
	$(CMD_RENDER) -manifest $$MANIFEST -palette $$PALETTE -input $<

.PHONY: render

# default target, renders all voxel models in this repo
render: $(PNG)
	@echo "========== Rendering complete =========="
