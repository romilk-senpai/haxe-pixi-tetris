package tetris.game;

class TetrominoColors {
	public static var Aqua = 0x00FFFF;
	public static var Yellow = 0xFFFF00;
	public static var Purple = 0x800080;
	public static var Green = 0x00FF00;
	public static var Red = 0xFF0000;
	public static var Blue = 0x0000FF;
	public static var Orange = 0xFF7F00;
	public static var Grey = 0x7F7F7F;
}

class Tetromino {
	public var blocks:Array<Block>;
	public var x:Int;
	public var y:Int;
	public var color:Int;
	public var matrixSize:Int;

	public function new(startX:Int, startY:Int, blocks:Array<Block>, color:Int, matrixSize:Int = 3) {
		this.blocks = blocks;
		this.color = color;
		x = startX;
		y = startY;
		this.matrixSize = matrixSize;
	}

	public function rotateCw() {
		for (block in blocks) {
			var newX = matrixSize - 1 - block.y;
			var newY = block.x;
			block.x = newX;
			block.y = newY;
		}
	}

	public function rotateCcw() {
		for (block in blocks) {
			var newX = block.y;
			var newY = matrixSize - 1 - block.x;
			block.x = newX;
			block.y = newY;
		}
	}

	public static function newRandom(boardWidth:Int = 10):Tetromino {
		var randomNumber = Math.floor(Math.random() * 7) + 1;
		switch (randomNumber) {
			case 1:
				return newO(boardWidth);
			case 2:
				return newI(boardWidth);
			case 3:
				return newS(boardWidth);
			case 4:
				return newZ(boardWidth);
			case 5:
				return newL(boardWidth);
			case 6:
				return newJ(boardWidth);
			case 7:
				return newT(boardWidth);
			default:
				return null;
		}
	}

	public static function newO(boardWidth:Int = 10):Tetromino {
		var startX = Math.round(boardWidth / 2) - 1;
		var blocks = [new Block(0, 0), new Block(0, 1), new Block(1, 0), new Block(1, 1)];
		return new Tetromino(startX, -1, blocks, TetrominoColors.Yellow, 2);
	}

	public static function newI(boardWidth:Int = 10):Tetromino {
		var startX = Math.round(boardWidth / 2 - 1);
		var blocks = [new Block(1, 0), new Block(1, 1), new Block(1, 2), new Block(1, 3)];
		return new Tetromino(startX, -3, blocks, TetrominoColors.Aqua, 4);
	}

	public static function newS(boardWidth:Int = 10):Tetromino {
		var startX = Math.round(boardWidth / 2 - 1);
		var blocks = [new Block(0, 1), new Block(1, 0), new Block(1, 1), new Block(2, 0)];
		return new Tetromino(startX, -1, blocks, TetrominoColors.Red);
	}

	public static function newZ(boardWidth:Int = 10):Tetromino {
		var startX = Math.round(boardWidth / 2 - 1);
		var blocks = [new Block(0, 0), new Block(1, 0), new Block(1, 1), new Block(2, 1)];
		return new Tetromino(startX, -1, blocks, TetrominoColors.Green);
	}

	public static function newL(boardWidth:Int = 10):Tetromino {
		var startX = Math.round(boardWidth / 2 - 1);
		var blocks = [new Block(0, 0), new Block(0, 1), new Block(0, 2), new Block(1, 2)];
		return new Tetromino(startX, -2, blocks, TetrominoColors.Orange);
	}

	public static function newJ(boardWidth:Int = 10):Tetromino {
		var startX = Math.round(boardWidth / 2 - 1);
		var blocks = [new Block(0, 2), new Block(1, 0), new Block(1, 1), new Block(1, 2)];
		return new Tetromino(startX, -2, blocks, TetrominoColors.Blue);
	}

	public static function newT(boardWidth:Int = 10):Tetromino {
		var startX = Math.round(boardWidth / 2 - 1);
		var blocks = [new Block(0, 1), new Block(1, 1), new Block(1, 2), new Block(2, 1)];
		return new Tetromino(startX, -2, blocks, TetrominoColors.Purple);
	}
}
