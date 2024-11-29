package tetris.pixi;

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
	private static final SCREEN_WIDTH:Int = 1280;
	private static final SCREEN_HEIGHT:Int = 720;
	private static final BG_COLOR:Int = 0x14182E;

	private var _graphics:Graphics;

	private var _game:TetrisGame;
	private var _input:TetrisInput;

	public function new() {
		_game = new TetrisGame(this);

		var options:ApplicationOptions = {
			width: SCREEN_WIDTH,
			height: SCREEN_HEIGHT,
			backgroundColor: BG_COLOR,
			transparent: true,
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
		_graphics.beginFill(0x827A63, 1);
		var outerX = x * outerSize;
		var outerY = y * outerSize;
		_graphics.drawRect(outerX, outerY, outerSize, outerSize);
		_graphics.endFill();
		_graphics.beginFill(state, 1);
		var innerX = outerX + outerSize / 2 - innerSize / 2;
		var innerY = outerY + outerSize / 2 - innerSize / 2;
		_graphics.drawRect(innerX, innerY, innerSize, innerSize);
		_graphics.endFill();
	}

	public function pollEvents():TetrisInput {
		return _input;
	}

	private function onKeyDown(e:KeyboardEvent):Void {
		if (e.keyCode == KeyEvent.DOM_VK_A || e.keyCode == KeyEvent.DOM_VK_LEFT) {
			_input.moveLeft = true;
		}

		if (e.keyCode == KeyEvent.DOM_VK_D || e.keyCode == KeyEvent.DOM_VK_RIGHT) {
			_input.moveRight = true;
		}
	}
}
