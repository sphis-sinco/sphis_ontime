package ontime.play;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import ontime.data.song.SongData;
import ontime.music.Conductor;
import ontime.music.MusicState;

class PlayState extends MusicState
{
	public var SONG_JSON:SongData;

	public var SONG_STARTED:Bool = false;
	public var SONG_ENDED:Bool = false;

	public var SONG_POSITION_DEBUG_TEXT:FlxText;

	override public function new()
	{
		SONG_JSON = new SongData("beatTest");

		Conductor.mapBPMChanges(SONG_JSON);

		FlxG.sound.playMusic(Paths.getSongFile(SONG_JSON.id, SONG_JSON.id + ".wav"), 1.0, false);
		FlxG.sound.music.onComplete = endSong;
		FlxG.sound.pause();

		Conductor.songPosition = 0; // -5000 for a countdown

		SONG_POSITION_DEBUG_TEXT = new FlxText(0, 0, 0, "Hello", 16);
		super();
	}

	override public function create():Void
	{
		add(SONG_POSITION_DEBUG_TEXT);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		songProgress(elapsed);

		super.update(elapsed);
	}

	public function songProgress(elapsed:Float):Void
	{
		if (!SONG_ENDED)
			Conductor.songPosition += elapsed * 1000;

		if (Conductor.songPosition > 0 && !SONG_STARTED)
		{
			SONG_STARTED = true;
			FlxG.sound.music.resume();
		}

		var MUSIC_LENGTH_SECONDS:Float = FlxG.sound.music.length / 1000;
		var TIME_LEFT_SECONDS:Float = FlxMath.roundDecimal(MUSIC_LENGTH_SECONDS - Conductor.songPosition / 1000, 0);

		if (TIME_LEFT_SECONDS > MUSIC_LENGTH_SECONDS)
			TIME_LEFT_SECONDS = MUSIC_LENGTH_SECONDS; // countdown time doesnt add to the length

		SONG_POSITION_DEBUG_TEXT.text = "Song Pos: " + TIME_LEFT_SECONDS;
	}

	public function endSong():Void
	{
		SONG_ENDED = true;
	}

	override public function stepHit():Void
	{
		super.stepHit();
	}

	override public function beatHit():Void
	{
		super.beatHit();
	}
}
