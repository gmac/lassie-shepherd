/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	final public class Path
	{
		// public
		public var length:int = -1;
		public var bestCase:int = -1;

		// private
		private var _path:Array;
		private var _nodes:Array;

		public function Path($length:Number=-1, $bestCase:Number=-1, $path:Array=null):void
		{
			length = $length;
			bestCase = $bestCase;
			_path = ($path != null) ? $path : new Array();
			_nodes = new Array();
		}

		public function destroy():void {
			_path = null;
			_nodes = null;
		}

		/**
		* Returns an array of the path's Node objects after path has been compiled.
		*/
		public function get nodes():Array {
			return _nodes;
		}

		/**
		* Returns all current data as a new Path object.
		*/
		public function copy():Path {
			return new Path(length, bestCase, _path.slice());
		}

		/**
		* Tests if path has been initialized with actual pathing data.
		*/
		public function get hasLength():Boolean {
			return (length + bestCase) >= 0;
		}

		/**
		* Returns the last node id contained within the path.
		*/
		public function get lastElement():String {
			return _path.slice(-1)[0];
		}

		/**
		* Tests if this path contains a node Id.
		*/
		public function containsNode($id:String):Boolean {
			return _path.indexOf($id) > -1;
		}

		/**
		* Adds a node to the path if not already present.
		*/
		public function addNode($id:String):void {
			if (!containsNode($id)) _path.push($id);
		}

		/**
		* compiles path into actual Node objects.
		*/
		internal function compile($grid:Grid):void
		{
			for each (var $nodeId:String in _path) {
				_nodes.push($grid.getNodeById($nodeId));
			}
		}

		/**
		* Trace object to string.
		*/
		public function toString():String {
			return "[Path] length:" + length + ", bestCase:" + bestCase + ", nodes:[" + _path + "]";
		}
	}
}
