package ontime.data.song;

class SongGameSettingsData
{
	public var bpm:Null<Float>;
	public var speed:Null<Float>;

	public function toString():String
	{
		return "SongGameSettingsData(bpm: " + this.bpm + ", speed: " + this.speed + ")";
	}
}
