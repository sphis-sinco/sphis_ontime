package ontime.data.song.chart;

import json2object.JsonParser;

class SongChartData
{
	@:optional
	@:default([])
	public var events:Array<SongChartEventData>;

	@:default([])
	public var chart:Array<SongChartNoteData>;

	@:jignored
	public var id:String;

	public function new(songId:String):Void
	{
		var parser = new JsonParser<SongChartData>();
		final jsonPath = Paths.getSongFile(songId, songId + "-metadata.json");
		var json = parser.fromJson(Paths.getText(jsonPath), songId + "-metadata.json");

		for (e in parser.errors)
		{
			switch (e)
			{
				case IncorrectType(variable, expected, pos):
					trace("SongChartData incorrect-type parsing error (variable: " + variable + ", expected: " + expected + ", pos: " + pos + ")");
				case UninitializedVariable(variable, pos):
					trace("SongChartData uninitalized-variable parsing error (variable: " + variable + ", pos: " + pos + ")");
				case UnknownVariable(variable, pos):
					trace("SongChartData unknown-variable parsing error (variable: " + variable + ", pos: " + pos + ")");
				default:
					trace("SongChartData unknown parsing error: " + e);
			}
		}

		if (json == null)
		{
			throw "Could not parse chart for song ID: " + songId + " (path: " + jsonPath + ")";
		}

		this.id = songId;

		this.events = json.events;
		this.chart = json.chart;
	}

	public function toString():String
	{
		return "SongChartData(id: " + this.id + ", chart.length: " + this.chart.length + ", events.length" + this.events.length + ")";
	}
}
