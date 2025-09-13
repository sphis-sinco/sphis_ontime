package ontime.data.song.chart;

class SongChartEventData
{
	public var step:Int;
	public var beat:Int;

	public var data:Dynamic;

	public function toString()
	{
		return "SongChartEventData(step: " + this.step + ", beat: " + this.beat + ", data: " + this.data + ")";
	}
}
