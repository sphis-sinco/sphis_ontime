package ontime.data.song;

class SongGameSettingsData
{
	@:default(SongDataConstants.GAME_SETTINGS_DEFAULT_BPM)
	public var bpm:Float;

	@:default(SongDataConstants.GAME_SETTINGS_DEFAULT_SPEED)
	public var speed:Float;
}
