install-deps:
	haxelib newrepo
	haxelib install pixijs 5.1.2

build:
	haxe build.hxml
	cp -r html/* bin/js/
	cp -r .haxelib/pixijs/5,1,2/libs bin/js

run:
	make build
	python3 -m http.server --directory bin/js

