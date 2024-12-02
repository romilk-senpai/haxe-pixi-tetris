#if hl
package tetris.raylib;

import tetris.game.Board;
import tetris.game.Tetromino;
import tetris.game.TetrisInput;
import tetris.game.IRenderer;

class RaylibImpl implements IRenderer {
	public function new() {
	}

	public function drawBoard(board:Board) {}

	public function drawTetromino(tetromino:Tetromino) {}

	public function pollEvents():TetrisInput {
		return new TetrisInput();
	}

	public function drawGameOver() {}

	public function updateScore(score:Int, level:Int) {}

	public function drawGhostTetromino(tetromino:Tetromino, posY:Int) {}
}
#end
