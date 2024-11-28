package tetris.game;

interface IRenderer {
	public function drawField():Void;
	public function drawShape():Void;
	public function pollEvents():Void;
}
