package com.lassie.shepherd.data.room
{
	import flash.display.BlendMode;
	
	public class BlendModes
	{
		public static function get list():Array
		{
			return [
				BlendMode.NORMAL,
				BlendMode.ADD,
				BlendMode.ALPHA,
				BlendMode.DARKEN,
				BlendMode.DIFFERENCE,
				BlendMode.ERASE,
				BlendMode.HARDLIGHT,
				BlendMode.INVERT,
				BlendMode.LAYER,
				BlendMode.LIGHTEN,
				BlendMode.MULTIPLY,
				BlendMode.OVERLAY,
				BlendMode.SCREEN,
				BlendMode.SUBTRACT
			];
		}
		
		public static function get menu():Array
		{
			var modes:Array = list;
			var menu:Array = new Array();
			
			for (var j:int = 0; j < modes.length; j++)
			{
				menu.push({label:modes[j], data:modes[j]});
			}
			
			return menu;
		}
	}
}