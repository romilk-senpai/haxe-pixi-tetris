package tetris.game;

class Board {
	public var gridWidth:Int;
	public var gridHeight:Int;

	private var _grid:Array<Int>;

	public function new(width:Int, height:Int) {
		gridWidth = width;
		gridHeight = height;
		_grid = new Array();
	}

	public function applyTetromino(tetromino:Tetromino) {
		for (block in tetromino.blocks) {
			var x = tetromino.x + block.x;
			var y = tetromino.y + block.y;
			_grid[y * gridHeight + x] = tetromino.color;
		}

		var checkedRow = -1;
		for (block in tetromino.blocks) {
			var y = tetromino.y + block.y;
			if (y > checkedRow) {
				var collapse = true;
				for (x in 0...gridWidth) {
					if (getBlockState(x, y) == 0) {
						collapse = false;
						break;
					}
				}
				if (collapse) {
					this.collapseRow(y);
				}
			}
			checkedRow = y;
		}
	}

	private function collapseRow(rowY:Int) {
		for (x in 0...gridWidth) {
			_grid[rowY * gridHeight + x] = 0;
		}

		for (x in 0...gridWidth) {
			for (y in 0...rowY - 1) {
				_grid[(rowY - y) * gridHeight + x] = _grid[(rowY - y - 1) * gridHeight + x];
				_grid[(rowY - y - 1) * gridHeight + x] = 0;
			}
		}
	}

	public function getBlockState(x:Int, y:Int):Int {
		var state = _grid[y * gridHeight + x];
		return state != null ? state : 0;
	}
}
