#if hl
package tetris.raylib;

import haxe.rtti.CType;

@:include("raylib.h")
extern class Raylib {
	@:native("InitWindow") public static function InitWindow(width:Int, height:Int, title:String):Void;
	@:native("WindowShouldClose") public static function WindowShouldClose():Bool;
	@:native("CloseWindow") public static function CloseWindow():Void;
}
#end
