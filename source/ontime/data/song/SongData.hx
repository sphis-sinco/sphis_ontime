package ontime.data.song;

import json2object.JsonParser;

class SongData
{
	@:jignored
	public var id:String;

	public var version:Null<Int>;

	@:optional
	@:default("Unknown")
	public var name:String;

	@:optional
	@:default([])
	public var credits:Array<String>;

	@:default(null)
	public var gameSettings:SongGameSettingsData;

	public function new(songId:String):Void
	{
		var parser = new JsonParser<SongData>();
		final jsonPath = Paths.getSongFile(songId, songId + "-metadata.json");
		var json = parser.fromJson(Paths.getText(jsonPath), songId + "-metadata.json");

		for (e in parser.errors)
		{
			switch (e)
			{
				case IncorrectType(variable, expected, pos):
					trace("SongData incorrect-type parsing error (variable: " + variable + ", expected: " + expected + ", pos: " + pos + ")");
				case UninitializedVariable(variable, pos):
					trace("SongData uninitalized-variable parsing error (variable: " + variable + ", pos: " + pos + ")");
				case UnknownVariable(variable, pos):
					trace("SongData unknown-variable parsing error (variable: " + variable + ", pos: " + pos + ")");
				default:
					trace("SongData unknown parsing error: " + e);
			}
		}

		if (json == null)
		{
			throw "Could not parse metadata for song ID: " + songId + " (path: " + jsonPath + ")";
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
