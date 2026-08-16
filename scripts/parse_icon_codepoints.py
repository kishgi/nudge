import urllib.request
import re

REM_CSS_URL = "https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"
TAB_CSS_URL = "https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.css"

TOKENS = {
    "home": ["home", "home-2", "home-line"],
    "search": ["search", "search-line"],
    "settings": ["settings", "settings-line", "gear"],
    "close": ["x", "close", "close-line"],
    "add": ["plus", "add", "add-line"],
    "check": ["check", "check-line"],
    "warning": ["alert-triangle", "warning", "error-warning-line", "alert-line"],
    "error": ["alert-circle", "error", "close-circle-line", "spam-line"],
    "info": ["info-circle", "info", "information-line"],
    "success": ["circle-check", "success", "checkbox-circle-line"],
    "arrowBack": ["arrow-left", "arrow-left-line", "back"],
    "arrowForward": ["arrow-right", "arrow-right-line", "forward"],
    "chevronDown": ["chevron-down", "arrow-down-s-line"],
    "chevronRight": ["chevron-right", "arrow-right-s-line"],
    "apps": ["apps", "layout-grid", "grid-fill", "grid-line"],
    "grid": ["grid", "layout-grid", "grid-line"],
    "list": ["list", "list-check", "list-unordered"],
    "focus": ["focus", "eye", "target", "focus-line"],
    "usage": ["chart-bar", "bar-chart", "bar-chart-line"],
    "notification": ["bell", "notification-line"],
    "edit": ["pencil", "edit", "edit-line"],
    "delete": ["trash", "delete", "delete-bin-line"],
    "more": ["dots", "more", "more-line", "more-2-line"],
    "share": ["share", "external-link", "share-line"],
    "favorite": ["star", "heart", "star-line"],
    "clock": ["clock", "time", "time-line"],
    "calendar": ["calendar", "calendar-line"],
    "theme": ["palette", "paint-brush", "palette-line"],
    "palette": ["palette", "palette-line"],
    "font": ["typography", "text", "font-size"],
    "lock": ["lock", "lock-line"],
    "unlock": ["lock-open", "lock-unlock", "unlock", "lock-unlock-line"],
    "eye": ["eye", "eye-line"],
    "eyeOff": ["eye-off", "eye-close-line"],
    "moon": ["moon", "moon-line"],
    "sun": ["sun", "sun-line"],
    "device": ["device-mobile", "phone", "smartphone-line"],
    "developer": ["code", "code-line", "terminal-box-line"],
}

def fetch_css(url):
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req) as resp:
        return resp.read().decode("utf-8")

def parse_css(css, prefix):
    # Regex to match class name and content hex
    # e.g., .ti-home:before { content: "\ec8f"; }
    # e.g., .ri-home-line:before { content: "\ee22"; }
    pattern = rf"\.{prefix}-([a-zA-Z0-9-]+):before\s*\{{\s*content:\s*\"\\([a-fA-F0-9]+)\""
    matches = re.findall(pattern, css)
    mapping = {}
    for name, hex_val in matches:
        mapping[name] = hex_val
    return mapping

def generate_resolver_code(pack_name, prefix, mapping):
    lines = []
    lines.append(f"// {pack_name} Codepoints")
    for token, aliases in TOKENS.items():
        found = False
        for alias in aliases:
            # check both exact and prefixed/suffixed aliases
            if alias in mapping:
                hex_val = mapping[alias]
                lines.append(f"        NudgeIconToken.{token} => const IconData(0x{hex_val}, fontFamily: '{pack_name}'),")
                found = True
                break
        if not found:
            # Fallback search inside keys
            for alias in aliases:
                matched_key = None
                for k in mapping.keys():
                    if alias in k:
                        matched_key = k
                        break
                if matched_key:
                    hex_val = mapping[matched_key]
                    lines.append(f"        NudgeIconToken.{token} => const IconData(0x{hex_val}, fontFamily: '{pack_name}'), // matched {matched_key}")
                    found = True
                    break
        if not found:
            lines.append(f"        NudgeIconToken.{token} => const IconData(0xe000, fontFamily: '{pack_name}'), // WARNING: fallback")
    return "\n".join(lines)

def main():
    print("Fetching Remix Icon CSS...")
    rem_css = fetch_css(REM_CSS_URL)
    rem_mapping = parse_css(rem_css, "ri")
    print(f"Parsed {len(rem_mapping)} Remix Icon styles.")

    print("Fetching Tabler Icons CSS...")
    tab_css = fetch_css(TAB_CSS_URL)
    tab_mapping = parse_css(tab_css, "ti")
    print(f"Parsed {len(tab_mapping)} Tabler Icon styles.")

    print("\n--- REMIX ICON RESOLVER MAPPING ---")
    print(generate_resolver_code("RemixIcon", "ri", rem_mapping))

    print("\n--- TABLER ICON RESOLVER MAPPING ---")
    print(generate_resolver_code("TablerIcons", "ti", tab_mapping))

if __name__ == "__main__":
    main()
