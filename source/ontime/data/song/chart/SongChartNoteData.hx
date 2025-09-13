package ontime.data.song.chart;

import flixel.math.FlxMath;

class SongChartNoteData
{
	public var step:Int;
	public var beat:Int;

	public var side(get, default):Int;

	function get_side():Int
	{
		if (side < -1)
			side = -1;
		if (side > 1)
			side = 1;

		return side;
	}

	public function toString()
	{
		return "SongChartNoteData(step: " + this.step + ", beat: " + this.beat + ", side: " + this.side + ")";
	}
}
