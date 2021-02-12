/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	import flash.geom.Point;
	import flash.geom.ColorTransform;

	final public class FilterPole extends Point
	{
		public var scale:Number = 1;
		public var rate:Number = 1;
		public var blur:Number = 0;
		public var color:ColorTransform;
		public var scaleEnabled:Boolean = false;
		public var rateEnabled:Boolean = false;
		public var blurEnabled:Boolean = false;
		public var colorEnabled:Boolean = false;

		public function FilterPole($x:int=0, $y:int=0, $xml:XML=null):void
		{
			super($x, $y);
			color = new ColorTransform();
			if ($xml != null) parse($xml);
		}

		/**
		* Traces a FilterPole object to string.
		*/
		override public function toString():String {
			return "[FilterPole] x: "+ x +", y: "+ y;
		}

		/**
		* Parses an XML structure or another FilterPole's configuration into the object.
		*/
		internal function parse($xml:XML):void
		{
			//if ($xml.@x != undefined) x = $xml.@x;
			//if ($xml.@y != undefined) y = $xml.@y;

			// scale
			if ($xml.@scale != undefined) {
				scale = $xml.@scale;
				scaleEnabled = true;
			}

			// rate
			if ($xml.@rate != undefined) {
				rate = $xml.@rate;
				rateEnabled = true;
			}

			// blur
			if ($xml.@blur != undefined) {
				blur = $xml.@blur;
				blurEnabled = true;
			}

			// color
			if ($xml.@color != undefined) {
				var $t:Number = $xml.@tint;
				var $m:Number = 1 - $t;
				var $rgb:RGB = RGB.parseNumber($xml.@color);
				color = new ColorTransform($m, $m, $m, 1, $rgb.red * $t, $rgb.green * $t, $rgb.blue * $t, 0);
				colorEnabled = true;
			}
		}

		/**
		* Copies the FilterPole instance as a new object
		*/
		public function copy():FilterPole
		{
			var $pole:FilterPole = new FilterPole(x, y);
			$pole.scale = this.scale;
			$pole.rate = this.rate;
			$pole.blur = this.blur;
			$pole.color = GeomUtil.copyColorTransform(this.color);
			$pole.scaleEnabled = this.scaleEnabled;
			$pole.rateEnabled = this.rateEnabled;
			$pole.blurEnabled = this.blurEnabled;
			$pole.colorEnabled = this.colorEnabled;
			return $pole;
		}
	}
}
