package tetris.game;

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

		if (input.rotateCw) {
			_current.rotateCw(_board);
		}

		if (input.rotateCcw) {
			_current.rotateCcw(_board);
		}

		var movement = 0;

		if (input.moveLeft) {
			movement--;
		}

		if (input.moveRight) {
			movement++;
		}

		if (movement != 0) {
			_current.x += movement;
			for (block in _current.blocks) {
				if (!_board.checkPosition(_current.x + block.x, _current.y + block.y)) {
					_current.x -= movement;
					break;
				}
			}
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
		var blocks = _current.blocks;
		for (i in 0...blocks.length) {
			if (_current.y + blocks[i].y == _board.gridHeight - 1) {
				onReachedBottom();
				return true;
			}

			if (_current.y < _board.gridHeight - 1 && !_board.checkPosition(_current.x + blocks[i].x, _current.y + blocks[i].y + 1)) {
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
			if (!_board.checkPosition(_current.x + block.x, _current.y + block.y)) {
				_gameOver = true;
				return;
			}
		}
	}
}
