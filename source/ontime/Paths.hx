package ontime;

class Paths
{
	public function getGamePath(path:String)
	{
		var return_path_prefix:String = "";

		if (!StringTools.startsWith(path, "game/"))
		{
			return_path_prefix = "game/";
		}

		return return_path_prefix + path;
	}

	public function getSongPath(song:String, ?file:String)
	{
		return getGamePath("songs/" + song + (file != null ? "/" + file : ""));
	}

	public function getSongFile(song:String, file:String)
	{
		return getSongPath(song, file);
	}
}
