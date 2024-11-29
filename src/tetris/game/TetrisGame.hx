package tetris.game;

import js.html.Console;

class TetrisGame {
	private var _board:Board;
	private var _renderer:IRenderer;

	private var _totalTime:Float;
	private var _lastMoveTime:Float;
	private var _moveGap:Float;

	private var _current:Tetromino;

	private var _gameOver:Bool;

	public function new(renderer:IRenderer) {
		_renderer = renderer;
		_board = new Board(10, 20);
		_totalTime = 0;
		_lastMoveTime = 0;
		_moveGap = 5.0;
		_gameOver = false;

		_current = Tetromino.newRandom(_board.gridWidth);
	}

	public function loop(deltaTime:Float) {
		_totalTime += deltaTime;

		var input = _renderer.pollEvents();

		if (_gameOver) {
			_renderer.drawGameOver();
			return;
		}

		if (input.moveLeft && _current.x > 0) {
			_current.x--;
		}

		if (input.moveRight && _current.x + _current.blocks[_current.blocks.length - 1].x < _board.gridWidth - 1) {
			_current.x++;
		}

		if (input.moveDown) {
			_lastMoveTime = _totalTime;
			if (!move()) {
				_current.y++;
			}
		} else {
			if (_totalTime >= _lastMoveTime + _moveGap) {
				if (!move()) {
					_current.y++;
				}
				_lastMoveTime += _moveGap;
			}
		}

		_renderer.drawBoard(_board);
		_renderer.drawTetromino(_current);
	}

	private function move():Bool {
		for (i in 0..._current.blocks.length) {
			if (i < _current.blocks.length - 1 && _current.blocks[i + 1].y > _current.blocks[i].y) {
				continue;
			}

			if (_current.y + _current.blocks[i].y == _board.gridHeight - 1) {
				onReachedBottom();
				return true;
			}

			if (_current.y < _board.gridHeight - 1
				&& checkPosition(_current.x + _current.blocks[i].x, _current.y + _current.blocks[i].y + 1)) {
				onReachedBottom();
				return true;
			}
		}
		return false;
	}

	private function onReachedBottom() {
		_board.applyTetromino(_current);
		_current = Tetromino.newRandom(_board.gridWidth);
		for (block in _current.blocks) {
			if (checkPosition(_current.x + block.x, _current.y + block.y)) {
				_gameOver = true;
				return;
			}
		}
	}

	private function checkPosition(x:Int, y:Int):Bool {
		return _board.getBlockState(x, y) > 0;
	}
}
