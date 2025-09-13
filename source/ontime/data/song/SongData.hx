package ontime.data.song;

import json2object.JsonParser;

class SongData
{
	@:jignored
	public var id:String;

	public var version:Int;

	@:optional
	@:default("Unknown")
	public var name:String;

	@:optional
	@:default([])
	public var credits:Array<String>;

	@:default(null)
	public var gameSettings:SongGameSettingsData;

	public function new(songId:String)
	{
		var parser = new JsonParser<SongData>();
		var json = parser.fromJson(Paths.getSongFile(songId, songId + "-metadata.json"));

		if (json == null)
		{
			throw "Could not parse metadata for song ID: " + songId;
		}

		this.version = json.version;
		this.version ??= SongDataConstants.SONG_DATA_VERSION;

		this.name = json.name;
		this.credits = json.credits;

		this.gameSettings = json.gameSettings;
		this.gameSettings.bpm ??= SongDataConstants.GAME_SETTINGS_DEFAULT_BPM;
		this.gameSettings.speed ??= SongDataConstants.GAME_SETTINGS_DEFAULT_SPEED;
	}

	public function toString():String
	{
		return "SongData(id: "
			+ this.id
			+ ", name: "
			+ this.name
			+ ", version: "
			+ this.version
			+ ", gameSettings: "
			+ this.gameSettings
			+ ")";
	}
}
