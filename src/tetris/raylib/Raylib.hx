#if hl
package tetris.raylib;

@:include("raylib.h")
extern class Raylib {
	@:hlNative("InitWindow")
	static function InitWindow(width:Int, height:Int, title:String):Void;
}
#end
