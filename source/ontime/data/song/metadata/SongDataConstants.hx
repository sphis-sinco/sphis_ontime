package ontime.data.song.metadata;

import ontime.music.Conductor;

class SongDataConstants
{
	public static var SONG_DATA_VERSION(default, never):Int = 3;

	public static var GAME_SETTINGS_DEFAULT_BPM_CHANGE_MAP(default, never):Array<BPMChangeEvent> = [
		{
			stepTime: 0,
			songTime: 0,
			bpm: 150
		}
	];
	public static var GAME_SETTINGS_DEFAULT_SPEED(default, never):Float = 1.0;
}
