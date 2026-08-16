#!/usr/bin/env python3
"""
Download Google Fonts TTF files for Nudge launcher.
Fetches from Google Fonts API and saves to assets/fonts/.
Run from the project root: python3 scripts/download_fonts.py
"""

import urllib.request
import json
import os
import sys

FONTS = {
    "inter": {
        "api_name": "Inter",
        "dir": "assets/fonts/inter",
        "weights": [100, 200, 300, 400, 500, 600, 700, 800, 900],
    },
    "manrope": {
        "api_name": "Manrope",
        "dir": "assets/fonts/manrope",
        "weights": [200, 300, 400, 500, 600, 700, 800],
    },
    "plus_jakarta_sans": {
        "api_name": "Plus Jakarta Sans",
        "dir": "assets/fonts/plus_jakarta_sans",
        "weights": [200, 300, 400, 500, 600, 700, 800],
    },
    "space_grotesk": {
        "api_name": "Space Grotesk",
        "dir": "assets/fonts/space_grotesk",
        "weights": [300, 400, 500, 600, 700],
    },
    "ibm_plex_sans": {
        "api_name": "IBM Plex Sans",
        "dir": "assets/fonts/ibm_plex_sans",
        "weights": [100, 200, 300, 400, 500, 600, 700],
    },
    "ibm_plex_mono": {
        "api_name": "IBM Plex Mono",
        "dir": "assets/fonts/ibm_plex_mono",
        "weights": [100, 200, 300, 400, 500, 600, 700],
    },
    "jetbrains_mono": {
        "api_name": "JetBrains Mono",
        "dir": "assets/fonts/jetbrains_mono",
        "weights": [100, 200, 300, 400, 500, 600, 700, 800],
    },
}

WEIGHT_NAMES = {
    100: "Thin",
    200: "ExtraLight",
    300: "Light",
    400: "Regular",
    500: "Medium",
    600: "SemiBold",
    700: "Bold",
    800: "ExtraBold",
    900: "Black",
}

def download_font(url, dest_path):
    """Download a file from url to dest_path."""
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
    if os.path.exists(dest_path):
        print(f"  [skip] {os.path.basename(dest_path)} already exists")
        return True
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=30) as resp:
            data = resp.read()
        with open(dest_path, "wb") as f:
            f.write(data)
        print(f"  [ok]   {os.path.basename(dest_path)} ({len(data)//1024}KB)")
        return True
    except Exception as e:
        print(f"  [err]  {os.path.basename(dest_path)}: {e}")
        return False

def get_font_urls_via_api(family):
    """Use Google Fonts CSS API to get font file URLs."""
    weights_str = ";".join(str(w) for w in [100,200,300,400,500,600,700,800,900])
    css_url = (
        f"https://fonts.googleapis.com/css2?family={family.replace(' ', '+')}:"
        f"wght@{weights_str}&display=swap"
    )
    req = urllib.request.Request(css_url, headers={
        "User-Agent": (
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
            "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        )
    })
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            css = resp.read().decode("utf-8")
        import re
        urls = re.findall(r"url\((https://fonts\.gstatic\.com/[^\)]+)\)", css)
        weights_found = re.findall(r"font-weight:\s*(\d+)", css)
        return list(zip(weights_found, urls))
    except Exception as e:
        print(f"  [err] CSS fetch failed for {family}: {e}")
        return []

def main():
    print("Nudge font downloader\n" + "="*40)
    for key, info in FONTS.items():
        print(f"\n→ {info['api_name']}")
        pairs = get_font_urls_via_api(info["api_name"])
        if not pairs:
            print("  [warn] No URLs found, skipping")
            continue
        # Keep only the weights we want
        wanted = set(str(w) for w in info["weights"])
        seen_weights = set()
        for weight_str, url in pairs:
            if weight_str not in wanted:
                continue
            if weight_str in seen_weights:
                continue
            seen_weights.add(weight_str)
            weight_name = WEIGHT_NAMES.get(int(weight_str), weight_str)
            stem = info["api_name"].replace(" ", "")
            filename = f"{stem}-{weight_name}.ttf"
            dest = os.path.join(info["dir"], filename)
            download_font(url, dest)

    print("\n✓ Font download complete.")

if __name__ == "__main__":
    main()
