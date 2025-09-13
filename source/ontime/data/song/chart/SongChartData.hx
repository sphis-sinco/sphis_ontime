package ontime.data.song.chart;

class SongChartData
{
	@:optional
	public var events:SongChartEventData;
	public var chart:SongChartNoteData;

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
					trace("SongMetadata incorrect-type parsing error (variable: " + variable + ", expected: " + expected + ", pos: " + pos + ")");
				case UninitializedVariable(variable, pos):
					trace("SongMetadata uninitalized-variable parsing error (variable: " + variable + ", pos: " + pos + ")");
				case UnknownVariable(variable, pos):
					trace("SongMetadata unknown-variable parsing error (variable: " + variable + ", pos: " + pos + ")");
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
		return "SongChartData(id: " + this.id + ", name: " + this.name + ", gameSettings: " + this.gameSettings + ")";
	}
}
