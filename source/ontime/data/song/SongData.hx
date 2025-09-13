package ontime.data.song;

class SongData
{
	/**
		This is the song data version,
				
		If this field isn't found it'll
		be default to the latest version.
	**/
	@:default(SongDataConstants.VERSION)
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
	public var gameSettings:GameSettingsData;
}
