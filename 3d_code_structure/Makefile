# Special targets
.PHONY: all, clean, mrproper, gitignore

SCAD=$(wildcard *.scad)
TARG_DIR=stl_files
STL=$(addprefix $(TARG_DIR)/, $(SCAD:.scad=.stl))

all: $(STL)

$(TARG_DIR)/%.stl: %.scad
	mkdir -p $(TARG_DIR)
	openscad $^ -o $@

# Cleaning
clean:

mrproper: clean
	rm -f $(STL)
	rmdir --ignore-fail-on-non-empty $(TARG_DIR)

# ".gitignore" file ; warning if it already exists!
gitignore:
	echo "$(STL)" | tr " " "\n" > .gitignore
	echo "/.gitignore" >> .gitignore
