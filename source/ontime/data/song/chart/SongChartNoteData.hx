package ontime.data.song.chart;

#if !macro
import flixel.math.FlxMath;

class SongChartNoteData
{
	public var step:Int;
	public var beat:Int;

	public var note:Int;

	public function toString()
	{
		return "SongChartNoteData(step: " + this.step + ", beat: " + this.beat + ", note: " + this.note + ")";
	}
}
#end
