package ontime.data.song.metadata;

import ontime.music.Conductor;

class SongGameSettingsData
{
	@:optional
	@:isVar
	public var bpm(get, default):Null<Float>;

	function get_bpm():Null<Float>
	{
		if (bpmChangeMap != null)
			return bpmChangeMap[0].bpm;

		return bpm;
	}

	public var bpmChangeMap:Array<BPMChangeEvent>;
	public var speed:Null<Float>;

	public function toString():String
	{
		return "SongGameSettingsData(bpm: "
			+ this.bpm
			+ ", speed: "
			+ this.speed
			+ ", bpmChangeMap.length:"
			+ bpmChangeMap.length
			+ ")";
	}
}
