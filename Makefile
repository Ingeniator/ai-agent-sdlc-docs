# AI Agent SDLC Documentation Build
# Requires: pandoc (brew install pandoc)

SOURCES := README.md 01-traditional-sdlc.md 02-ai-agent-sdlc.md 03-comparison.md 04-tools-landscape.md
HTML := $(SOURCES:.md=.html)
BUILD_DIR := build

PANDOC_OPTS := --standalone \
	--toc \
	--toc-depth=2 \
	--metadata title="AI Agent SDLC" \
	--css=style.css \
	--highlight-style=github

.PHONY: all clean serve check-deps

all: check-deps $(BUILD_DIR) $(addprefix $(BUILD_DIR)/,$(HTML)) $(BUILD_DIR)/style.css $(BUILD_DIR)/index.html

check-deps:
	@command -v pandoc >/dev/null 2>&1 || { echo "Error: pandoc not found. Install with: brew install pandoc"; exit 1; }

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.html: %.md
	pandoc $(PANDOC_OPTS) -o $@ $<

$(BUILD_DIR)/index.html: README.md
	pandoc $(PANDOC_OPTS) --metadata title="AI Agent SDLC - Overview" -o $@ $<

$(BUILD_DIR)/style.css:
	@echo '/* AI Agent SDLC Documentation Styles */' > $@
	@echo 'body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; max-width: 900px; margin: 0 auto; padding: 2rem; line-height: 1.6; color: #333; }' >> $@
	@echo 'h1, h2, h3 { color: #1a1a1a; margin-top: 2rem; }' >> $@
	@echo 'h1 { border-bottom: 2px solid #e1e1e1; padding-bottom: 0.5rem; }' >> $@
	@echo 'h2 { border-bottom: 1px solid #e1e1e1; padding-bottom: 0.3rem; }' >> $@
	@echo 'code { background: #f4f4f4; padding: 0.2rem 0.4rem; border-radius: 3px; font-size: 0.9em; }' >> $@
	@echo 'pre { background: #f4f4f4; padding: 1rem; border-radius: 5px; overflow-x: auto; }' >> $@
	@echo 'pre code { background: none; padding: 0; }' >> $@
	@echo 'table { border-collapse: collapse; width: 100%; margin: 1rem 0; }' >> $@
	@echo 'th, td { border: 1px solid #ddd; padding: 0.75rem; text-align: left; }' >> $@
	@echo 'th { background: #f8f8f8; font-weight: 600; }' >> $@
	@echo 'tr:nth-child(even) { background: #fafafa; }' >> $@
	@echo 'blockquote { border-left: 4px solid #ddd; margin: 1rem 0; padding-left: 1rem; color: #666; }' >> $@
	@echo 'a { color: #0066cc; text-decoration: none; }' >> $@
	@echo 'a:hover { text-decoration: underline; }' >> $@
	@echo 'nav#TOC { background: #f8f8f8; padding: 1rem; border-radius: 5px; margin-bottom: 2rem; }' >> $@
	@echo 'nav#TOC ul { margin: 0; padding-left: 1.5rem; }' >> $@
	@echo 'nav#TOC li { margin: 0.3rem 0; }' >> $@
	@echo '.mermaid { background: #fff; text-align: center; }' >> $@

serve: all
	@echo "Serving at http://localhost:8000"
	@cd $(BUILD_DIR) && python3 -m http.server 8000

clean:
	rm -rf $(BUILD_DIR)

# Individual targets
readme: $(BUILD_DIR) $(BUILD_DIR)/README.html $(BUILD_DIR)/style.css
traditional: $(BUILD_DIR) $(BUILD_DIR)/01-traditional-sdlc.html $(BUILD_DIR)/style.css
ai-agent: $(BUILD_DIR) $(BUILD_DIR)/02-ai-agent-sdlc.html $(BUILD_DIR)/style.css
comparison: $(BUILD_DIR) $(BUILD_DIR)/03-comparison.html $(BUILD_DIR)/style.css
tools: $(BUILD_DIR) $(BUILD_DIR)/04-tools-landscape.html $(BUILD_DIR)/style.css

help:
	@echo "Available targets:"
	@echo "  all        - Build all HTML files (default)"
	@echo "  serve      - Build and serve locally at http://localhost:8000"
	@echo "  clean      - Remove build directory"
	@echo "  readme     - Build README.html only"
	@echo "  traditional- Build 01-traditional-sdlc.html only"
	@echo "  ai-agent   - Build 02-ai-agent-sdlc.html only"
	@echo "  comparison - Build 03-comparison.html only"
	@echo "  tools      - Build 04-tools-landscape.html only"
	@echo ""
	@echo "Requirements: pandoc (brew install pandoc)"
