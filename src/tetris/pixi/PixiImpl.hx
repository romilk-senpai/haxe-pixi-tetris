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
	private static final SCREEN_HEIGHT:Int = 750;
	private static final BG_COLOR:Int = 0x050505;

	private var _graphics:Graphics;

	private var _game:TetrisGame;
	private var _input:TetrisInput;
	private var _scoreLabel:Text;
	private var _gameOverLabel:Text;
	private var _levelLabel:Text;

	private var _score:Int;
	private var _level:Int;

	private var _inGame:Bool;

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

		_inGame = false;

		var style1:DefaultStyle = {};
		style1.fill = 0xFFFFFF;
		style1.fontSize = 18;
		style1.align = 'left';
		style1.fontWeight = "400";
		_scoreLabel = new Text("", style1);
		_levelLabel = new Text("", style1);

		var style2:DefaultStyle = {};
		style2.fill = 0xFFFFFF;
		style2.fontSize = 32;
		style2.align = 'center';
		_gameOverLabel = new Text('GAME OVER\nSCORE:$_score\nPRESS ANY KEY\nTO RESTART', style2);
		_gameOverLabel.position.set(SCREEN_WIDTH / 2 - _gameOverLabel.width / 2, SCREEN_HEIGHT / 2 - _gameOverLabel.height / 2);

		var lastTime = Browser.window.performance.now();
		super(options);
		ticker.add((badDeltaTime) -> {
			var time = Browser.window.performance.now();
			var goodDeltaTime = (time - lastTime) / 1000;
			_game.loop(goodDeltaTime);
			lastTime = time;
			_input = new TetrisInput();
		});

		stage.addChild(_graphics);
		view.id = "canvas";
		Browser.document.body.appendChild(view);

		Browser.window.addEventListener('keydown', onKeyDown, true);
	}

	public function drawBoard(board:Board) {
		_graphics.clear();
		if (!_inGame) {
			stage.removeChild(_gameOverLabel);
			stage.addChild(_scoreLabel);
			stage.addChild(_levelLabel);
			_inGame = true;
		}

		for (x in 0...board.gridWidth) {
			for (y in 0...board.gridHeight) {
				var state = board.getBlockState(x, y);
				drawBlock(x, y, state);
			}
		}

		_scoreLabel.text = 'SCORE: $_score';
		_levelLabel.text = 'LEVEL: $_level';

		var headerHeight = 24;
		_scoreLabel.position.set(4, 2 + headerHeight / 2.0 - _scoreLabel.height / 2.0);
		_levelLabel.position.set(SCREEN_WIDTH - _levelLabel.width - 4, 2 + headerHeight / 2.0 - _scoreLabel.height / 2.0);
	}

	public function drawTetromino(tetromino:Tetromino) {
		for (block in tetromino.blocks) {
			drawBlock(tetromino.x + block.x, tetromino.y + block.y, tetromino.color);
		}

		_graphics.beginFill(0x27292B, 1);
		_graphics.drawRect(0, 0, SCREEN_WIDTH, 26);
		_graphics.endFill();
	}

	private function drawBlock(x:Int, y:Int, state:Int) {
		var outerSize = 36;
		var innerSize = 32;
		var outerX = 2 + x * outerSize;
		var outerY = 24 + 4 + y * outerSize;
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
		if (_inGame) {
			_graphics.clear();
			stage.removeChild(_scoreLabel);
			stage.removeChild(_levelLabel);
			stage.addChild(_gameOverLabel);
			_inGame = false;
		}
	}

	public function updateScore(score:Int, level:Int) {
		_score = score;
		_level = level;
	}
}
