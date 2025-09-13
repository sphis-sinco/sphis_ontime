package ontime.data.song.chart;

class SongChartEventData
{
	var step:Int;
	var beat:Int;

	var data:Dynamic;

	public function toString()
	{
		return "SongChartEventData(step: " + this.step + ", beat: " + this.beat + ", data: " + this.data + ")";
	}
}
