#!/usr/bin/env python3
import argparse
from PIL import Image

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("input_path")
    parser.add_argument("output_path")
    parser.add_argument("delta_y", type=int)
    args = parser.parse_args()

    img = Image.open(args.input_path)
    assert img.size[0] % 264 == 0
    assert img.size[1] == 310
    if img.mode == "P":
        empty = 0
    else:
        empty = (0, 0, 0, 0)
    for subfigure in range(img.size[0] // 264):
        for y in range(64):
            for x in range(256):
                if (y - args.delta_y) * 2 + min(x, 255 - x) < 128:
                    img.putpixel((x, 310 - 1 - y), empty)
    img.save(args.output_path)

if __name__ == "__main__":
    main()
