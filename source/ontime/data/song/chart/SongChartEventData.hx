package ontime.data.song.chart;

import haxe.Json;

class SongChartEventData
{
	public var step:Int;
	public var beat:Int;

	@:jcustomparse(funkin.data.DataParse.dynamicValue)
	@:jcustomwrite(dynamicValue)
	public var data:Dynamic;

	public function toString()
	{
		return "SongChartEventData(step: " + this.step + ", beat: " + this.beat + ", data: " + this.data + ")";
	}

	function dynamicValue(data:Dynamic):String
	{
		return Json.stringify(data);
	}
}
