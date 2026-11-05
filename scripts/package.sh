#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_NAME="narrative-depth"
SRC="$ROOT/skills/$SKILL_NAME"
OUT="$ROOT/dist"
ZIP="$OUT/$SKILL_NAME.zip"

if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "Missing $SRC/SKILL.md" >&2
  exit 1
fi

python3 - "$SRC/SKILL.md" <<'PY'
import re, sys
text = open(sys.argv[1], encoding="utf-8").read()
if not text.startswith("---"):
    raise SystemExit("SKILL.md must start with YAML frontmatter ---")
end = text.find("\n---", 3)
if end < 0:
    raise SystemExit("SKILL.md frontmatter not closed")
fm = text[3:end]
for key in ("name:", "description:"):
    if key not in fm:
        raise SystemExit(f"frontmatter missing {key}")
name = re.search(r"^name:\s*(.+)$", fm, re.M).group(1).strip()
if name != "narrative-depth":
    raise SystemExit(f"expected name narrative-depth, got {name!r}")
desc = re.search(r"^description:\s*(.+)$", fm, re.M).group(1).strip()
if len(desc) < 20 or len(desc) > 1024:
    raise SystemExit(f"description length out of bounds: {len(desc)}")
print(f"frontmatter OK name={name} description_len={len(desc)}")
PY

mkdir -p "$OUT"
rm -f "$ZIP"
# Prefer zip(1); fall back to Python zipfile
if command -v zip >/dev/null 2>&1; then
  (cd "$ROOT/skills" && zip -r "$ZIP" "$SKILL_NAME" -x "*/.DS_Store")
else
  python3 - "$SRC" "$ZIP" "$SKILL_NAME" <<'PY'
import sys, zipfile
from pathlib import Path
src, zip_path, skill_name = Path(sys.argv[1]), Path(sys.argv[2]), sys.argv[3]
with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
    for path in sorted(src.rglob("*")):
        if path.is_file() and path.name != ".DS_Store":
            zf.write(path, arcname=f"{skill_name}/{path.relative_to(src).as_posix()}")
print("zipped via python")
PY
fi

echo "Wrote $ZIP"
python3 - "$ZIP" <<'PY'
import zipfile, sys
z = zipfile.ZipFile(sys.argv[1])
names = z.namelist()
for n in names:
    print(n)
assert any(n.endswith("SKILL.md") for n in names)
print("verify OK", len(names), "files")
PY
