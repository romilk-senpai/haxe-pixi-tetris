package tetris.game;

class Board {
	private var _gridWidth:Int;
	private var _gridHeight:Int;
	private var _grid:Array<Int>;

	public function new(width:Int, height:Int) {
		_gridWidth = width;
		_gridHeight = height;
		_grid = new Array();
	}
}
