package funkin.data;

import hxjsonast.Json;
import hxjsonast.Tools;

/**
 * `json2object` has an annotation `@:jcustomparse` which allows for mutation of parsed values.
 *
 * It also allows for validation, since throwing an error in this function will cause the issue to be properly caught.
 * Parsing will fail and `parser.errors` will contain the thrown exception.
 *
 * Functions must be of the signature `(hxjsonast.Json, String) -> T`, where the String is the property name and `T` is the type of the property.
 */
@:nullSafety
class DataParse
{
	/**
	 * Parser which outputs a Dynamic value, either a object or something else.
	 * @param json
	 * @param name
	 * @return The value of the property.
	 */
	public static function dynamicValue(json:Json, name:String):Dynamic
	{
		return Tools.getValue(json);
	}
}
