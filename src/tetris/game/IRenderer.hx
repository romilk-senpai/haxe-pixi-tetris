package tetris.game;

import tetris.game.TetrisInput;

interface IRenderer {
	public function drawBoard(board:Board):Void;
	public function drawShape():Void;
	public function pollEvents():TetrisInput;
}
