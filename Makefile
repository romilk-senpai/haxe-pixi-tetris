build:
	haxe build.hxml

run:
	make build
	cp -r html/* bin/js/
	cp -r .haxelib/pixijs/5,1,2/libs bin/js
	cp -r assets bin/js
	python3 -m http.server --directory bin/js

