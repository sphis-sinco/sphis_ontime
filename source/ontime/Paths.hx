package ontime;

import lime.utils.Assets;
#if sys
import sys.io.File;
#end

class Paths
{
	public static function getGamePath(path:String)
	{
		var return_path_prefix:String = "";

		if (!StringTools.startsWith(path, "game/"))
		{
			return_path_prefix = "game/";
		}

		return return_path_prefix + path;
	}

	public static function getSongPath(song:String, ?file:String)
	{
		return getGamePath("songs/" + song + (file != null ? "/" + file : ""));
	}

	public static function getSongFile(song:String, file:String)
	{
		return getSongPath(song, file);
	}

	public static function getText(path:String):String
	{
		#if sys
		return File.getContent(path);
		#end

		return Assets.getText(path);
	}
}
