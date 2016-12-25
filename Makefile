all: ksolve_def_parser.jison puzzles/puzzles.js

ksolve_def_parser.jison:
	jison ksolve_def_parser.jison -o ksolve_def_parser.js

PUZZLES_DEPS = puzzles/serialize.js $(shell find puzzles -iname "*.svg") $(shell find puzzles -iname "*.def")
puzzles/puzzles.js: ${PUZZLES_DEPS}
	node puzzles/serialize.js

test:
	node ksolve_def_parser.js puzzles/222.def

.PHONY: deploy-f2lfast
deploy-f2lfast:
	rsync -avz \
		--exclude .DS_Store \
		--exclude .git \
		--exclude .gitignore \
		--exclude .gitmodules \
		./ \
		cubing.net:~/cubing.net/f2lfast/
	echo "\nDone deploying. Go to https://www.cubing.net/f2lfast/\n"
