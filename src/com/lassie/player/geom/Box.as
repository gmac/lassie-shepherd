/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	import flash.geom.Rectangle;

	final public class Box extends Rectangle
	{
		private var _childNodes:Array;

		public function Box(x:int=0, y:int=0, w:int=100, h:int=100):void
		{
			super(x, y, w, h);
			_childNodes = new Array();
		}

		/**
		* [static] parses an XML structure into a new Box object.
		*/
		static public function parseXML($xml:XML):Box
		{
			var $box:Box = new Box($xml.@x, $xml.@y, $xml.@w, $xml.@h);
			$box.parseChildNodes($xml.@nodes);
			return $box;
		}

		/**
		* Returns all current data as a new Box object.
		*/
		public function copy():Box
		{
			var box:Box = new Box(x, y, width, height);
			box.parseChildNodes(_childNodes.join(","));
			return box;
		}

		/**
		* Parses a list of comma-seperated node id's into the array of child nodes.
		*/
		public function parseChildNodes($csv:String):void
		{
			for each (var $j:String in $csv.split(",")) addChildNode($j);
		}

		/**
		* Adds a new child node Id.
		*/
		public function addChildNode($id:String):void
		{
			if (!containsChildNode($id) && $id != "") _childNodes.push($id);
		}

		/**
		* Gets a child node Id by numeric index.
		*/
		public function getChildNode($index:int):String
		{
			if ($index >= 0 && $index < _childNodes.length) return _childNodes[$index];
			return null;
		}

		/**
		* Gets the number of child nodes contained within this box.
		*/
		public function get numChildNodes():int
		{
			return _childNodes.length;
		}

		/**
		* Tests if the specified node id is among the box's children.
		*/
		public function containsChildNode($id:String):Boolean
		{
			return _childNodes.indexOf($id) > -1;
		}

		/**
		* Trace object to string.
		*/
		override public function toString():String
		{
			return "[Box] x:" + x + ", y:" + y + ", w:" + width + ", h:" + height;
		}
	}
}
