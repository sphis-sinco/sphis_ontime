package ontime.data.song.chart;

#if !macro
class SongChartEventData
{
	public var step:Int;
	public var beat:Int;

	@:jcustomparse(ontime.utils.DynamicJsonUtil.dynamicValueParse)
	@:jcustomwrite(ontime.utils.DynamicJsonUtil.dynamicValueWrite)
	public var data:Dynamic;

	public function toString()
	{
		return "SongChartEventData(step: " + this.step + ", beat: " + this.beat + ", data: " + this.data + ")";
	}
}
#end
