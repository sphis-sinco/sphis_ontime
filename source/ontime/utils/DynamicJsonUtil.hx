package ontime.utils;

class DynamicJsonUtil
{
	public static function dynamicValueParse(json:hxjsonast.Json, name:String):Dynamic
	{
		return hxjsonast.Tools.getValue(json);
	}

	public static function dynamicValueWrite(data:Dynamic):String
	{
		return haxe.Json.stringify(data);
	}
}
