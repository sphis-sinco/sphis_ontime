package ontime.data.song;

import json2object.JsonParser;

class SongData
{
	/**
		This is the song data version,
				
		If this field isn't found it'll
		be default to the latest version.
	**/
	public var version:Int;

	/**
		This is the song name
		that will be displayed
		in the pause menu
		or song select
	**/
	@:optional
	@:default("Unknown")
	public var name:String;

	/**
		This is a list of credits
		that will be cycled through
		and displayed via
		the pause menu
	**/
	@:optional
	@:default([])
	public var credits:Array<String>;

	/**
		This is the main thing the gameplay will look for and use.
		If it isn't found or is null then the game will not run the song. 
	**/
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
}
