package ontime.data.song;

class SongData
{
	public var version:String;

	@:default("Unknown")
	public var name:String;
	@:default([])
	public var credits:Array<String>;

	public var gameSettings:GameSettingsData;
}
