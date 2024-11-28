package tetris;

import tetris.game.TetrisGame;
import tetris.game.Board;
import tetris.game.TetrisInput;
import tetris.game.IRenderer;
import pixi.core.Application;
import pixi.core.graphics.Graphics;
import js.Browser;

class PixiImpl extends Application implements IRenderer {
	private static final SCREEN_WIDTH:Int = 400;
	private static final SCREEN_HEIGHT:Int = 800;
	private static final BG_COLOR:Int = 0x14182E;

	private var _graphics:Graphics;

	private var _game:TetrisGame;

	public function new() {
		_game = new TetrisGame(this);

		var options:ApplicationOptions = {
			width: SCREEN_WIDTH,
			height: SCREEN_HEIGHT,
			backgroundColor: BG_COLOR,
			transparent: true,
			antialias: false,
		};

		_graphics = new Graphics();

		super(options);
		ticker.add(function(deltaTime) {
			_game.loop(deltaTime);
		});

		stage.addChild(_graphics);
		view.id = "canvas";
		Browser.document.body.appendChild(view);
	}

	public function drawBoard(board:Board) {
		var outerSize = 36;
		var innerSize = 32;
		for (x in 0...board.gridWidth) {
			for (y in 0...board.gridHeight) {
				var state = board.getBlockState(x, y);
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
		}
	}

	public function drawShape() {}

	public function pollEvents():TetrisInput {
		return new TetrisInput();
	}
}
