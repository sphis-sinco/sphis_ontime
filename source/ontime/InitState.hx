package ontime;

import flixel.FlxG;
import flixel.FlxState;
import haxe.macro.Compiler;
import ontime.play.PlayState;

class InitState extends FlxState
{
	override public function create()
	{
		super.create();

		if (Compiler.getDefine('goToPlayState') == "1")
		{
			FlxG.switchState(() -> new PlayState());
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
