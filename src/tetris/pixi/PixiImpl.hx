package tetris.pixi;

import pixi.core.text.Text;
import pixi.core.text.DefaultStyle;
import js.html.KeyboardEvent;
import js.html.KeyEvent;
import tetris.game.Tetromino;
import tetris.game.TetrisGame;
import tetris.game.Board;
import tetris.game.TetrisInput;
import tetris.game.IRenderer;
import pixi.core.Application;
import pixi.core.graphics.Graphics;
import js.Browser;

class PixiImpl extends Application implements IRenderer {
	private static final SCREEN_WIDTH:Int = 364;
	private static final SCREEN_HEIGHT:Int = 724;
	private static final BG_COLOR:Int = 0x050505;

	private var _graphics:Graphics;

	private var _game:TetrisGame;
	private var _input:TetrisInput;
	private var _label:Text;

	public function new() {
		_game = new TetrisGame(this);

		var options:ApplicationOptions = {
			width: SCREEN_WIDTH,
			height: SCREEN_HEIGHT,
			backgroundColor: BG_COLOR,
			transparent: false,
			antialias: false
		};

		_graphics = new Graphics();
		_input = new TetrisInput();

		super(options);
		ticker.add(function(deltaTime) {
			// This dt is bullshit need to double check this sometime
			_game.loop(deltaTime / ticker.FPS);
			_input = new TetrisInput();
		});

		stage.addChild(_graphics);
		view.id = "canvas";
		Browser.document.body.appendChild(view);

		Browser.window.addEventListener('keydown', onKeyDown, true);
	}

	public function drawBoard(board:Board) {
		for (x in 0...board.gridWidth) {
			for (y in 0...board.gridHeight) {
				var state = board.getBlockState(x, y);
				drawBlock(x, y, state);
			}
		}
	}

	public function drawTetromino(tetromino:Tetromino) {
		for (block in tetromino.blocks) {
			drawBlock(tetromino.x + block.x, tetromino.y + block.y, tetromino.color);
		}
	}

	private function drawBlock(x:Int, y:Int, state:Int) {
		var outerSize = 36;
		var innerSize = 32;
		var outerX = 2 + x * outerSize;
		var outerY = 2 + y * outerSize;
		var innerX = outerX + outerSize / 2 - innerSize / 2;
		var innerY = outerY + outerSize / 2 - innerSize / 2;
		_graphics.beginFill(state == 0 ? 0x16181A : state, 1);
		_graphics.drawRect(innerX, innerY, innerSize, innerSize);
		_graphics.endFill();
	}

	public function pollEvents():TetrisInput {
		return _input;
	}

	private function onKeyDown(e:KeyboardEvent):Void {
		_input.anyKey = true;

		if (e.keyCode == KeyEvent.DOM_VK_A || e.keyCode == KeyEvent.DOM_VK_LEFT) {
			_input.moveLeft = true;
		}

		if (e.keyCode == KeyEvent.DOM_VK_D || e.keyCode == KeyEvent.DOM_VK_RIGHT) {
			_input.moveRight = true;
		}

		if (e.keyCode == KeyEvent.DOM_VK_S || e.keyCode == KeyEvent.DOM_VK_DOWN) {
			_input.moveDown = true;
		}

		if (e.keyCode == KeyEvent.DOM_VK_X || e.keyCode == KeyEvent.DOM_VK_W) {
			_input.rotateCw = true;
		}

		if (e.keyCode == KeyEvent.DOM_VK_Z) {
			_input.rotateCcw = true;
		}
	}

	public function drawGameOver() {
		if (_label == null) {
			_graphics.clear();
			var style1:DefaultStyle = {};
			style1.fill = 0xFFFFFF;
			style1.fontSize = 36;
			style1.fontFamily = "Courier";
			_label = new Text("GAME OVER", style1);
			_label.position.set(SCREEN_WIDTH / 2 - _label.width / 2, SCREEN_HEIGHT / 2 - _label.height / 2);
			stage.addChild(_label);
		}
	}
}
