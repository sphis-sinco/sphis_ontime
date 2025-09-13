package ontime.data.song.metadata;

import json2object.JsonParser;

class SongMetadata
{
	@:jignored
	public var id:String;

	@:optional
	@:default("Unknown")
	public var name:String;

	@:optional
	@:default([])
	public var credits:Array<String>;

	@:default(null)
	public var gameSettings:SongGameSettingsMetadata;

	public function new(songId:String):Void
	{
		var parser = new JsonParser<SongMetadata>();
		final jsonPath = Paths.getSongFile(songId, songId + "-metadata.json");
		var json = parser.fromJson(Paths.getText(jsonPath), songId + "-metadata.json");

		for (e in parser.errors)
		{
			switch (e)
			{
				case IncorrectType(variable, expected, pos):
					trace("IncorrectType(variable: " + variable + ", expected: " + expected + ", pos: " + pos + ")");
				case UninitializedVariable(variable, pos):
					trace("UninitializedVariable(variable: " + variable + ", pos: " + pos + ")");
				case UnknownVariable(variable, pos):
					trace("UnknownVariable(variable: " + variable + ", pos: " + pos + ")");
				default:
					trace("SongMetadata unknown parsing error: " + e);
			}
		}

		if (json == null)
		{
			throw "Could not parse metadata for song ID: " + songId + " (path: " + jsonPath + ")";
		}

		this.id = songId;

		this.name = json.name;
		this.credits = json.credits;

		this.gameSettings = json.gameSettings;
		this.gameSettings.bpmChangeMap ??= SongMetadataConstants.GAME_SETTINGS_DEFAULT_BPM_CHANGE_MAP;
		this.gameSettings.bpm ??= this.gameSettings.bpmChangeMap[0].bpm ?? SongMetadataConstants.GAME_SETTINGS_DEFAULT_BPM;
		this.gameSettings.speed ??= SongMetadataConstants.GAME_SETTINGS_DEFAULT_SPEED;
	}

	public function toString():String
	{
		return "SongMetadata(id: " + this.id + ", name: " + this.name + ", gameSettings: " + this.gameSettings + ")";
	}
}
