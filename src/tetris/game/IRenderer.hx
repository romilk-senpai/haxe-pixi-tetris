package tetris.game;

import tetris.game.TetrisInput;

interface IRenderer {
	public function drawBoard(board:Board):Void;
	public function drawTetromino(tetromino:Tetromino):Void;
	public function pollEvents():TetrisInput;
	public function drawGameOver():Void;
}
