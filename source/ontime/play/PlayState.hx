package ontime.play;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import ontime.data.song.chart.SongChartData;
import ontime.data.song.chart.SongChartEventData;
import ontime.data.song.chart.SongChartNoteData;
import ontime.data.song.metadata.SongMetadata;
import ontime.music.Conductor;
import ontime.music.MusicState;

class PlayState extends MusicState
{
	public var SongMetadata:SongMetadata;
	public var SongChartData:SongChartData;

	public var SongStarted:Bool = false;
	public var SongEnded:Bool = false;

	public var SongPaused:Bool = false;
	public var SongCanUnpause:Bool = false;

	public var SongPositionDebugText:FlxText;

	override public function new(?songID:String)
	{
		SongMetadata = new SongMetadata(songID ?? "beatTest");
		SongChartData = new SongChartData(SongMetadata.id);

		FlxG.watch.addQuick("SongMetadata", SongMetadata);
		FlxG.watch.addQuick("SongChartData", SongChartData);

		Conductor.mapBPMChanges(SongMetadata);

		FlxG.sound.playMusic(Paths.getSongFile(SongMetadata.id, SongMetadata.id + ".wav"), 1.0, false);
		FlxG.sound.music.onComplete = endSong;
		FlxG.sound.pause();

		Conductor.songPosition = 0; // -5000 for a countdown

		SongPositionDebugText = new FlxText(0, 0, 0, "Hello", 16);
		super();
	}

	override public function create():Void
	{
		add(SongPositionDebugText);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		songProgress(elapsed);

		super.update(elapsed);
	}

	public function songProgress(elapsed:Float):Void
	{
		if (SongPaused && (FlxG.sound.music?.playing ?? false))
		{
			FlxG.sound.music.pause();
		}

		resyncSong();

		if (!(SongEnded || SongPaused))
			Conductor.songPosition += elapsed * 1000;

		if ((Conductor.songPosition > 0 && !SongStarted) || (SongPaused && SongCanUnpause))
		{
			if (Conductor.songPosition > 0 && !SongStarted)
				SongStarted = true;
			if (SongPaused && SongCanUnpause)
			{
				SongPaused = false;
				SongCanUnpause = false;
			}
			FlxG.sound.music.resume();
		}

		var MUSIC_LENGTH_SECONDS:Float = FlxG.sound.music.length / 1000;
		var MUSIC_LENGTH_MINUTES:Float = MUSIC_LENGTH_SECONDS / 60;
		var TIME_LEFT_SECONDS:Float = FlxMath.roundDecimal(MUSIC_LENGTH_SECONDS - Conductor.songPosition / 1000, 0);
		var TIME_LEFT_MINUTES:Float = FlxMath.roundDecimal(MUSIC_LENGTH_MINUTES - ((Conductor.songPosition / 1000) / 60), 0);

		if (TIME_LEFT_SECONDS > MUSIC_LENGTH_SECONDS)
			TIME_LEFT_SECONDS = MUSIC_LENGTH_SECONDS; // countdown time doesnt add to the length
		if (TIME_LEFT_MINUTES > MUSIC_LENGTH_MINUTES)
			TIME_LEFT_MINUTES = MUSIC_LENGTH_MINUTES;

		SongPositionDebugText.text = "Song Pos (" + TIME_LEFT_MINUTES + ":" + (TIME_LEFT_SECONDS < 10 ? "0" : "") + TIME_LEFT_SECONDS + ")";
	}

	public var RESYNC_THRESHOLD(get, never):Float;

	function get_RESYNC_THRESHOLD():Float
	{
		return 40.0;
	}

	function resyncSong()
	{
		var correctSync:Float = Math.min(FlxG.sound.music.length, Math.max(0, Conductor.songPosition - Conductor.combinedOffset));

		if (!(!(Conductor.songPosition > 0 && !SongStarted)
			&& (Math.abs(FlxG.sound.music.time - correctSync) > RESYNC_THRESHOLD)
			&& !(SongEnded)))
			return;
		else
			trace("Track requires resync (curTime: " + FlxG.sound.music.time + ", correctSync: " + correctSync + ")");

		// Skip this if the music is paused
		if (!(FlxG.sound.music?.playing ?? false))
			return;

		var timeToPlayAt:Float = Math.min(FlxG.sound.music.length,
			Math.max(Math.min(Conductor.combinedOffset, 0), Conductor.songPosition) - Conductor.combinedOffset);
		trace("Resyncing track to " + timeToPlayAt);

		FlxG.sound.music.pause();

		FlxG.sound.music.time = timeToPlayAt;
		FlxG.sound.music.play(false, timeToPlayAt);
	}

	override function onFocusLost()
	{
		super.onFocusLost();

		SongPaused = true;
	}

	override function onFocus()
	{
		super.onFocus();

		if (SongPaused)
		{
			SongCanUnpause = true;
		}
	}

	function endSong():Void
	{
		SongEnded = true;

		trace("Song completed (curBeat:" + this.curBeat + ", curStep:" + this.curStep + ")");
	}

	override public function stepHit():Void
	{
		super.stepHit();

		checkNotes();
		checkEvents();
	}

	override public function beatHit():Void
	{
		super.beatHit();

		checkNotes();
		checkEvents();
	}

	public function checkNotes()
		for (note in this.SongChartData.chart)
			if (curBeat == note.beat && curStep == note.step)
				processNote(note);

	public function checkEvents()
		for (event in this.SongChartData.event)
			if (curBeat == event.beat && curStep == event.step)
				processEvent(event);

	public function processNote(note:SongChartNoteData) {}

	public function processEvent(note:SongChartEventData) {}
}
