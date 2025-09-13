package ontime.data.song.metadata;

import ontime.music.Conductor;

class SongDataConstants
{
	public static var GAME_SETTINGS_DEFAULT_BPM(default, never):Int = 150;

	public static var GAME_SETTINGS_DEFAULT_BPM_CHANGE_MAP(default, never):Array<BPMChangeEvent> = [
		{
			stepTime: 0,
			songTime: 0,
			bpm: GAME_SETTINGS_DEFAULT_BPM
		}
	];
	public static var GAME_SETTINGS_DEFAULT_SPEED(default, never):Float = 1.0;
}
