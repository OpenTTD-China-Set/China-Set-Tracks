import glob
import sys
import json
import os  # handle file path

# check argv length
if len(sys.argv) not in (3, 4):
    print(
        "Usage: python get_render_file.py <render_list.json> <filename> [manifest]",
        file=sys.stderr,
    )
    sys.exit(1)

# load json render list file
with open(sys.argv[1], "r") as f:
    render_list = json.load(f)

default = render_list["default"]

# get filename from argv, check if it's a manifest file
filename = os.path.abspath(os.path.normpath(sys.argv[2]))
is_manifest = True if len(sys.argv) == 4 else False

# search for filename in render list
for key, item in render_list.items():
    if filename in [
        os.path.abspath(os.path.normpath(p)) for p in glob.glob(key, recursive=True)
    ]:
        if is_manifest:
            if "manifest" in item:
                print(item["manifest"])
            else:
                print(default["manifest"])
        else:
            if "palette" in item:
                print(item["palette"])
            else:
                print(default["palette"])
        sys.exit(0)


# filename not found
# print the default manifest and palette

print(default["manifest"] if is_manifest else default["palette"])
