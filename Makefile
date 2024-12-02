install-deps-js:
	haxelib newrepo
	haxelib install pixijs 5.1.2

install-hashlink:
	haxelib git hashlink https://github.com/HaxeFoundation/hashlink.git master other/haxelib/
	sudo apt-get install libpng-dev libturbojpeg-dev libvorbis-dev libopenal-dev libsdl2-dev libglu1-mesa-dev libmbedtls-dev libuv1-dev libsqlite3-dev
	make -C .haxelib/hashlink/git

build-js:
	haxe build-js.hxml
	cp -r html/* bin/js/

build-c:
	haxe build-c.hxml
	gcc -O3 -o bin/c/haxe-tetris -I bin/c/src -I .haxelib/hashlink/git/src bin/c/src/main.c -lhl -L .haxelib/hashlink/git/

run-js:
	make build-js
	python3 -m http.server --directory bin/js

