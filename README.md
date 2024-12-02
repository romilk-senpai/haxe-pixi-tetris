# Haxe Tetris

Deployed [here](https://romilk-senpai.github.io/haxe-pixi-tetris/)

Tetris recreation with Haxe and PixiJS backend for web target.

## Build.

Requires haxe presintalled e.g.
```shell
sudo add-apt-repository ppa:haxe/releases -y
sudo apt-get update
sudo apt-get install haxe -y
```

* Install dependencies
```shell
make install-deps-js
```

* Build js and host as you like
```shell
make build-js
```
* Or run (requires python3 with http.server)
```shell
make run-js
```
