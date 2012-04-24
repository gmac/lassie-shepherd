package com.lassie.shepherd.data.room
{
	public final class LayerHitShapes
	{
		public static var RECT:String = "rect";
		
		public static var ROUND:String = "round";
		
		public static function get list():Array
		{
			return new Array(RECT, ROUND);
		}
		
		public static function get menu():Array
		{
			var opts:Array = new Array();
			opts.push({label:"Rectangle", data:RECT});
			opts.push({label:"Ellipse", data:ROUND});
			return opts;
		}
	}
}