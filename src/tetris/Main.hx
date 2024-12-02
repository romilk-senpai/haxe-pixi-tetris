package tetris;

#if js
import tetris.pixi.PixiImpl;
#else
import tetris.raylib.Raylib;
import tetris.raylib.RaylibImpl;
#end
import tetris.game.TetrisGame;

class Main {
	static function main() {
		#if js
		new PixiImpl();
		#else
		// var raylib = new RaylibImpl();
		// new TetrisGame(raylib);
		Raylib.InitWindow(800, 600, "Raylib");
		#end
	}
}
