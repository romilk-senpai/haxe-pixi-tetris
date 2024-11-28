import pixi.core.Application;
import pixi.core.graphics.Graphics;
import pixi.core.textures.Texture;
import pixi.core.sprites.Sprite;
import js.Browser;

class Main extends Application {
	private static final SCREEN_WIDTH:Int = 800;
	private static final SCREEN_HEIGHT:Int = 600;
	private static final BG_COLOR:Int = 0x14182E;

	private var _graphics:Graphics;

	public function new() {
		var options:ApplicationOptions = {
			width: SCREEN_WIDTH,
			height: SCREEN_HEIGHT,
			backgroundColor: BG_COLOR,
			transparent: true,
			antialias: false,
		};

		super(options);
		ticker.add(function(delta) {
			gameLoop(delta);
		});

		// _bunny = new Sprite(Texture.from("assets/bunny.png"));
		// _bunny.anchor.set(0.5);
		// _bunny.position.set(400, 300);

		_graphics = new Graphics();
		_graphics.beginFill(BG_COLOR, 1);
		_graphics.drawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		_graphics.endFill();

		stage.addChild(_graphics);
		view.id = "canvas";
		Browser.document.body.appendChild(view);
	}

	function gameLoop(delta:Float) {}

	static function main() {
		new Main();
	}
}
