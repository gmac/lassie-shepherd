/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	import flash.geom.Point;
	import com.lassie.utils.XmlUtil;

	final public class Node extends Point
	{
		// private
		private var _id:String = "";
		private var _name:String = "";
		private var _neighbors:Array;
		private var _trapping:Boolean = false;
		private var _script:XML = <script/>;
		private var _filter:FilterPole;

		public function Node($id:String, $x:int=0, $y:int=0, $name:String=""):void
		{
			super($x, $y);
			_id = $id;
			_name = $name;
			_neighbors = new Array();
			_filter = new FilterPole();
		}

		/**
		* [static] parses an XML structure into a new Node object.
		*/
		static public function parseXML($xml:XML):Node
		{
			var $node:Node = new Node($xml.@id, $xml.@x, $xml.@y, $xml.@name);
			$node.parseNeighbors($xml.@join);
			$node.parse($xml);
			return $node;
		}

		/**
		* Parses configuration onto the Node from an XML structure or from another Node object.
		*/
		internal function parse($src:Object):void
		{
			if ($src is XML)
			{
				// Source is an XML structure
				var $xml:XML = $src as XML;

				// set filter settings.
				_filter = new FilterPole(x, y, $xml);
				_trapping = XmlUtil.parseBoolean($xml.@trap, false);

				// set script XML.
				if ($xml.script != undefined) {
					_script = XML($xml.script);
				}
			}
			else if ($src is Node)
			{
				// Source is a Node object
				var $node:Node = $src as Node;
				_trapping = $node.trapping;
				_script = $node.script;
				_filter = $node.filter.copy();
			}
		}

		/**
		* Returns all current data as a new Node object.
		*/
		public function copy($id:String=""):Node
		{
			if ($id == "") $id = id;
			var $node:Node = new Node($id, x, y, name);
			$node.parseNeighbors(_neighbors.join(","));
			$node.parse(this);
			return $node;
		}

		/**
		* Gets the node's unique identifier.
		*/
		public function get id():String {
			return _id;
		}

		/**
		* Gets the node's reference name.
		*/
		public function get name():String {
			return _name;
		}

		/**
		* Clears the list of existing node neighbors.
		*/
		public function clearNeighbors():void {
			_neighbors = new Array();
		}

		/**
		* Parses a list of comma-seperated node id's into the array of neighbors.
		*/
		public function parseNeighbors($csv:String):void {
			for each (var $j:String in $csv.split(",")) addNeighbor($j);
		}

		/**
		* Adds a new neighbor Id.
		*/
		public function addNeighbor($id:String):void {
			if (!containsNeighbor($id) && $id != "") _neighbors.push($id);
		}

		/**
		* Gets a neightbor Id by numeric index.
		*/
		public function getNeighbor($index:int):String {
			if ($index >= 0 && $index < _neighbors.length) return _neighbors[$index];
			return null;
		}

		/**
		* Gets the number of neighbors assigned to this node.
		*/
		public function get numNeighbors():int {
			return _neighbors.length;
		}

		/**
		* Tests if the specified node id is among this node's neighbors.
		*/
		public function containsNeighbor($id:String):Boolean {
			return _neighbors.indexOf($id) > -1;
		}

		/**
		* Appends an additional namespace key onto all Node references. Avoids conflicts during Grid unions.
		*/
		public function expandNamespace($key:String):void {
			_id += $key;
			for each (var $j:String in _neighbors) $j += $key;
		}

		/**
		* Specifies if the node traps background clicks like a grid box.
		*/
		public function get trapping():Boolean {
			return _trapping;
		}

		/**
		* Gets the color value assigned to the node.
		*/
		public function get filter():FilterPole {
			return _filter;
		}

		/**
		* Gets a copy of the script assigned to the node.
		*/
		public function get script():XML {
			return _script.copy();
		}

		/**
		* Trace object to string.
		*/
		override public function toString():String {
			return "[Node] id:"+ id +", x:" + x + ", y:" + y + ", neighbors:[" + _neighbors + "]";
		}
	}
}
