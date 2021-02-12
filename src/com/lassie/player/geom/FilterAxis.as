/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	final public class FilterAxis
	{
		static public const X:String = "x";
		static public const Y:String = "y";
		static public const RADIAL:String = "r";

		static public function validate($value:String):Boolean {
			return ($value == X || $value == Y || $value == RADIAL);
		}
	}
}
