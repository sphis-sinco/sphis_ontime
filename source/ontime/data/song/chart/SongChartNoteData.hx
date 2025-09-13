package ontime.data.song.chart;

class SongChartNoteData
{
	var step:Int;
	var beat:Int;

	var side:Int;

	public function toString()
	{
		return "SongChartNoteData(step: " + this.step + ", beat: " + this.beat + ", side: " + this.side + ")";
	}
}
