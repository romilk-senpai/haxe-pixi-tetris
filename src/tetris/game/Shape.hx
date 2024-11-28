package tetris.game;

import haxe.ds.ReadOnlyArray;

class Shape {
	public var blocks:ReadOnlyArray<Int>;

	public function new(blocks:Array<Int>) {
		this.blocks = blocks;
	}
}
