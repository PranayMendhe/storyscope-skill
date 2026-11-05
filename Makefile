SKILL_NAME := narrative-depth
SKILL_DIR  := skills/$(SKILL_NAME)
DIST_DIR   := dist
ZIP        := $(DIST_DIR)/$(SKILL_NAME).zip

.PHONY: zip clean verify

zip: $(ZIP)

$(ZIP): $(SKILL_DIR)/SKILL.md $(SKILL_DIR)/reference/narrative-tells.md $(SKILL_DIR)/reference/revision-moves.md scripts/package.sh
	./scripts/package.sh

verify: $(ZIP)
	@unzip -l $(ZIP)
	@python3 -c "import zipfile; z=zipfile.ZipFile('$(ZIP)'); names=z.namelist(); assert any(n.endswith('SKILL.md') for n in names), names; print('OK:', '$(ZIP)', 'files=', len(names))"

clean:
	rm -rf $(DIST_DIR)
