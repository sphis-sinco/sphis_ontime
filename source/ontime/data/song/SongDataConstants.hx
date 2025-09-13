package ontime.data.song;

class SongDataConstants
{
	/**
		This is the current/latest SongData version

		This will be used for song version checks
	**/
	public static var SONG_DATA_VERSION(default, never):Int = 2;

	/**
		This is the default BPM value
		for SongData `gameSettings`
	**/
	public static var GAME_SETTINGS_DEFAULT_BPM(default, never):Float = 150;

	/**
		This is the default Speed value
		for SongData `gameSettings`
	**/
	public static var GAME_SETTINGS_DEFAULT_SPEED(default, never):Float = 1.0;
}
