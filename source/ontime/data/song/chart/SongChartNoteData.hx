package ontime.data.song.chart;

class SongChartNoteData
{
	public var step:Int;
	public var beat:Int;

	public var side:Int;

	public function toString()
	{
		return "SongChartNoteData(step: " + this.step + ", beat: " + this.beat + ", side: " + this.side + ")";
	}
}
