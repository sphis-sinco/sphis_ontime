package ontime.play;

import flixel.FlxState;
import ontime.data.song.SongData;

class PlayState extends FlxState
{
	public var beatTest:SongData;

	override public function create()
	{
		super.create();

		beatTest = new SongData('beatTest');

		trace(beatTest);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
