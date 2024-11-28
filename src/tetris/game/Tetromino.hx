package tetris.game;

class Tetromino {
	public var blocks:Array<Block>;
	public var x:Int;
	public var y:Int;
	public var color:Int;

	public function new(blocks:Array<Block>, color:Int) {
		this.blocks = blocks;
		this.color = color;
		x = 0;
		y = 0;
	}

	public static function NewO():Tetromino {
		return new Tetromino([new Block(0, 0), new Block(0, 1), new Block(1, 0), new Block(1, 1)], 0xFFFFFF);
	}
}
