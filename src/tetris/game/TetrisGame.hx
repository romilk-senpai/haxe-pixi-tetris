package tetris.game;

import js.html.Console;

class TetrisGame {
	private var _board:Board;
	private var _renderer:IRenderer;

	private var _totalTime:Float;
	private var _lastMoveTime:Float;
	private var _moveGap:Float;

	private var _current:Tetromino;

	public function new(renderer:IRenderer) {
		_renderer = renderer;
		_board = new Board(10, 20);
		_totalTime = 0;
		_lastMoveTime = 0;
		_moveGap = 0.5;

		_current = Tetromino.NewO();
		_current.x = Math.round(_board.gridWidth / 2);
	}

	public function loop(deltaTime:Float) {
		var input = _renderer.pollEvents();
		_totalTime += deltaTime;
		if (_totalTime >= _lastMoveTime + _moveGap) {
			_lastMoveTime += _moveGap;
			_current.y++;
			for (i in 0..._current.blocks.length) {
				if (i < _current.blocks.length - 1 && _current.blocks[i + 1].y > _current.blocks[i].y) {
					continue;
				}
				if (checkPosition(_current.x + _current.blocks[i].x, _current.y + _current.blocks[i].y)) {
					onReachedBottom();
					break;
				}
			}
		}
		_renderer.drawBoard(_board);
		_renderer.drawTetromino(_current);
	}

	private function onReachedBottom() {
		_board.applyTetromino(_current);
		_current = Tetromino.NewO();
		_current.x = Math.round(_board.gridWidth / 2);
	}

	private function checkPosition(x:Int, y:Int):Bool {
		if (y == _board.gridHeight - 1) {
			return true;
		}

		return _board.getBlockState(x, y + 1) > 0;
	}
}
