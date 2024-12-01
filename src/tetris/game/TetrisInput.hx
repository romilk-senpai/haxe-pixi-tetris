package tetris.game;

class TetrisInput {
	public var anyKey:Bool;
	public var moveRight:Bool;
	public var moveLeft:Bool;
	public var moveDown:Bool;
	public var rotateCw:Bool;
	public var rotateCcw:Bool;
	public var instantPlace:Bool;

	public function new() {
		anyKey = false;
		moveRight = false;
		moveLeft = false;
		moveDown = false;
		rotateCw = false;
		rotateCcw = false;
	}
}
