package com.lassie.player.geom
{
	import flash.geom.ColorTransform;

	public class RGB
	{
		// private
		private var _r:int;
		private var _g:int;
		private var _b:int;

		/**
		* Creates an RGB object with a default color of black (0, 0, 0).
		*/
		public function RGB($r:int=0, $g:int=0, $b:int=0):void
		{
			red = $r;
			green = $g;
			blue = $b;
		}

		/**
		* Creates an RGB object from a hex string, formatted as: "#123456" or "0x123456".
		*/
		static public function parseHex($value:String):RGB
		{
			var $hex:String = $value.replace("#", "0x");
			if ($hex.indexOf("0x") != 0) $hex = "0x" + $hex;
			var $num:Number = parseInt($hex, 16);

			if(!isNaN($num))
			{
				var $r:Number = ($num >> 16);
				var $g:Number = ($num >> 8 ^ $r << 8);
				var $b:Number = ($num ^ ($r << 16 | $g << 8));
				return new RGB($r, $g, $b);
			}
			else
			{
				trace('The RGB hex "'+ $value +'" is malformed.');
			}
			return null;
		}

		/**
		* Creates an RGB object from a number between 0 and 16777215 (0xFFFFFF).
		*/
		static public function parseNumber($num:Number):RGB
		{
			if(!isNaN($num) && $num >= 0 && $num <= 0xFFFFFF)
			{
				var $rgb:RGB = new RGB();
				$rgb.red = $num >> 16 & 0xFF;
				$rgb.green = $num >> 8 & 0xFF;
				$rgb.blue = $num & 0xFF;
				return $rgb;
			}
			else
			{
				trace("The value "+ $num +" falls outside of valid RGB range (0 - 0xFFFFFF).");
			}
			return null;
		}

		/**
		* Creates a duplicate of the RGB object.
		*/
		public function clone():RGB {
			return new RGB(red, green, blue);
		}

		/**
		* Tests if two RGB objects have the same color value.
		*/
		public function equals($compare:RGB):Boolean {
			return number == $compare.number;
		}

		/**
		* Specifies the red color component.
		*/
		public function get red():int {
			return _r;
		}
		public function set red($val:int):void {
			_r = Math.max(0, Math.min($val, 255));
		}

		/**
		* Specifies the green color component.
		*/
		public function get green():int {
			return _g;
		}
		public function set green($val:int):void {
			_g = Math.max(0, Math.min($val, 255));
		}

		/**
		* Specifies the blue color component.
		*/
		public function get blue():int {
			return _b;
		}
		public function set blue($val:int):void {
			_b = Math.max(0, Math.min($val, 255));
		}

		/**
		* Returns the RGB value as a number.
		*/
		public function get number():Number {
			return (_r << 16 | _g << 8 | _b);
		}

		/**
		* Returns the RGB value as a hexidecimal value.
		*/
		public function get hexValue():String {
			var $r:String = red.toString(16);
			var $g:String = green.toString(16);
			var $b:String = blue.toString(16);
			$r = ($r.length == 1) ? '0' + $r : $r;
			$g = ($g.length == 1) ? '0' + $g : $g;
			$b = ($b.length == 1) ? '0' + $b : $b;
			return ($r + $g + $b).toUpperCase();
		}

		/**
		* Returns the RGB value as a standard hex string.
		*/
		public function get hex():String {
			return "#"+hexValue;
		}

		/**
		* Returns the RGB value as a Flash-native hex string.
		*/
		public function get flashHex():String {
			return "0x"+hexValue;
		}

		/**
		* Returns a ColorTransform of the RGB value, tinted to the specified percentage.
		*/
		public function getTransform($perc:Number=1):ColorTransform {
			return new ColorTransform(1-$perc, 1-$perc, 1-$perc, 1, _r * $perc, _g * $perc, _b * $perc, 0);
		}
	}
}
