/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	import flash.geom.Point;
	import flash.display.Sprite;

	final public class Grid extends Object
	{
		// static
		static private var _cloneNamespace:int = 0;
		static private var _joinNamespace:int = 0;

		// private
		private var _id:String = "";
		private var _nodes:Object;
		private var _nodesIndex:Array;
		private var _nodeTraps:Array;
		private var _boxes:Array;

		public function Grid($id:String):void
		{
			super();
			_id = $id;

			_nodes = new Object();
			_nodesIndex = new Array();
			_nodeTraps = new Array();
			_boxes = new Array();
		}

		public function destroy():void
		{
			_nodes = null;
			_nodesIndex = null;
			_nodeTraps = null;
			_boxes = null;
		}

		/**
		* Trace Grid to string.
		*/
		public function toString():String {
			return "[Grid] id:" + id + ", boxes:" + numBoxes + ", nodes:" + numNodes;
		}

		/**
		* [static] parses an XML structure into a new Grid object.
		*/
		static public function parseXML($xml:XML):Grid
		{
			var $grid:Grid = new Grid($xml.@id);

			// boxes
			for each (var $box:XML in $xml.boxes.box) {
				$grid.addBox( Box.parseXML($box) );
			}

			// nodes
			for each (var $node:XML in $xml.nodes.node) {
				$grid.addNode( Node.parseXML($node) );
			}
			return $grid;
		}

	//-------------------------------------------------
	// Grid methods
	//-------------------------------------------------

		/**
		* Gets the Grid's Id name.
		*/
		public function get id():String {
			return _id;
		}

		/**
		* Returns all current data as a new Grid object.
		*/
		public function copy():Grid
		{
			// create new grid with incremented name
			var $grid:Grid = new Grid(id + (_cloneNamespace += 1));

			// clone all nodes
			for (var $nodeId:String in _nodes) {
				$grid.addNode( getNodeById($nodeId).copy() );
			}
			// clone all boxes
			for each (var $box:Box in _boxes) {
				$grid.addBox($box.copy());
			}
			return $grid;
		}

		/**
		* Returns a copy of the current Grid joined with another.
		*/
		public function join($join:Grid):Grid
		{
			var $key:String = "_" + (_joinNamespace += 1);
			var $base:Grid = this.copy();

			// merge all boxes with base grid
			// IMPORTANT: add boxes BEFORE adding nodes,
			// that way new nodes will connect into the completed box grid.
			for (var j:int=0; j < $join.numBoxes; j++) {
				$base.connectNewBox( $join.getBoxAt(j).copy() );
			}

			// merge all nodes with base grid
			for (j=0; j < $join.numNodes; j++)
			{
				var $node:Node = $join.getNodeAt(j).copy();
				$node.expandNamespace($key);
				$base.connectNewNode($node, true, false);
			}
			return $base;
		}

		/**
		* Draws an image of the grid within the specified scope.
		*/
		public function draw($scope:Sprite):void {
			GridDraw.render(this, $scope);
		}

	//-------------------------------------------------
	// Box methods
	//-------------------------------------------------

		/**
		* Adds a box to the grid.
		*/
		public function addBox($box:Box):void {
			_boxes.push($box);
		}

		/**
		* Gets the number of boxes in the grid.
		*/
		public function get numBoxes():int {
			return _boxes.length;
		}

		/**
		* Gets a box by numeric index from the array of boxes.
		*/
		public function getBoxAt($index:int):Box {
			if ($index >= 0 && $index < _boxes.length) return _boxes[$index] as Box;
			return null;
		}

	//-------------------------------------------------
	// Node methods
	//-------------------------------------------------

		/**
		* Adds a Node object.
		*/
		public function addNode($node:Node):void {
			_nodes[$node.id] = $node;
			_nodesIndex.push($node.id);
			if ($node.trapping) _nodeTraps.push($node);
		}

		/**
		* Gets the number of nodes in the grid.
		*/
		public function get numNodes():int {
			return _nodesIndex.length;
		}

		/**
		* Gets a Node object by numeric index.
		*/
		public function getNodeAt($index:int):Node
		{
			if ($index >= 0 && $index < _nodesIndex.length) {
				return getNodeById(_nodesIndex[$index]);
			}
			return null;
		}

		/**
		* Gets a Node object by Id.
		*/
		public function getNodeById($id:String):Node {
			return !containsNode($id) ? null : _nodes[$id] as Node;
		}

		/**
		* Checks in the grid contains the specified node.
		*/
		public function containsNode($id:String):Boolean {
			return _nodes.hasOwnProperty($id);
		}

	//-------------------------------------------------
	// Grid expansion methods
	//-------------------------------------------------

		/**
		* Connects a new box into the grid structure.
		*/
		public function connectNewBox($box:Box):void
		{
			// add all nodes contained within the box as children of the box.
			for (var $nodeId:String in _nodes) {
				if ($box.containsPoint( getNodeById($nodeId) )) $box.addChildNode($nodeId);
			}
			addBox($box);
		}

		/**
		* Connects a new node into the grid structure.
		* @param $node: Node object to connect into grid.
		* @param $confineToWalkarea: forces the Node's position to fall within the walk-safe areas.
		* @param $forceConnect: forces the Node to connect with the nearest grid node if the Node acquired no other neighbors.
		* @return The ID of the resolved Node target.
		*/
		public function connectNewNode($target:Node, $confineToWalkarea:Boolean=false, $forceConnect:Boolean=true):String
		{
			// first attempt to find the target node coordinates within the grid.
			var $node:Node = _seekExistingNode($target);

			if ($node == null) {
				// NO EXISTING NODE WAS FOUND
				// configure working node as a copy of the target instead.
				$node = $target.copy();

				if ($confineToWalkarea) {
					// Confine target to within the walkable area:
					// - first plot node's position within box areas,
					// - then test for a closer trapping grid point.
					$node = _trapWithBoxes($node);
					$node = _trapWithNodes($target, $node);
				}

				if ($node.numNeighbors < 1) {
					// Add node to grid if it still has no neighbors.
					// - first attempt to connect by plotting within common boxes.
					// - if box connection did not produce neighbors, connect through nearest grid node.
					$node = _connectUsingBoxes($node);
					if ($node.numNeighbors < 1 && $forceConnect) _connectUsingNodes($node);
					addNode($node);
				}
			}
			return $node.id;
		}

		/**
		* Searches the grid for an existing node with matching coordinates.
		* @param $target: A Node with the target coordinates to search for.
		* @return An existing grid Node, if found.
		*/
		private function _seekExistingNode($target:Node):Node
		{
			for (var $nodeId:String in _nodes) {
				var $node:Node = getNodeById($nodeId);
				if ($node.equals($target)) return $node;
			}
			return null;
		}

		/**
		* Modifies a node's coordinates (if necessary) to fall within the nearest Box area.
		* @param $node: Node object to confine within box areas.
		* @return Node: the original Node object input with modified coordinates.
		*/
		private function _trapWithBoxes($node:Node):Node
		{
			var $bestX:int = -1;
			var $bestY:int = -1;
			var $bestRadius:Number;

			for (var $j:int = 0; $j < numBoxes; $j++)
			{
				var $box:Box = getBoxAt($j);

				if (!$box.containsPoint($node))
				{
					// box does not contain node.

					var $xpos:int = Math.max($box.left+1, Math.min($node.x , $box.right-1));
					var $ypos:int = Math.max($box.top+1, Math.min($node.y , $box.bottom-1));
					var $best:Point = new Point($xpos, $ypos);
					var $radius:Number = Point.distance($node, $best);

					// log point if closer to target than the current best-case scenario.
					if (isNaN($bestRadius) || $radius < $bestRadius)
					{
						$bestX = $xpos;
						$bestY = $ypos;
						$bestRadius = $radius;
					}
				}
				else
				{
					// box contains node.
					return $node;
				}
			}

			// update the node's coordinates if a better position was found.
			if ($bestX + $bestY >= 0)
			{
				$node.x = $bestX;
				$node.y = $bestY;
			}
			return $node;
		}

		/**
		* Searches for the closest trapping node to the target position.
		* @param target The actual target point attempting to be reached.
		* @param nearest The current closest safe point selected by box method.
		* @return The original "nearest" Node object with updated coordinates.
		*/
		private function _trapWithNodes($target:Node, $node:Node):Node
		{
			// Evaluate the baseline best-distance from target to beat.
			// - if there were boxes to trap with, honor the distance to the provided node as the distance to beat.
			// - otherwise, use a stupidly large number as the distance to beat to force a trap selection.
			var $bestOffset:Number = (numBoxes > 0) ? Point.distance($target, $node) : 99999;
			var $bestTrap:Node;

			// abort process if an exact match has already been found.
			if ($bestOffset == 0) return $node;

			// loop through all trapping nodes and test for a closer match.
			for each (var $trap:Node in _nodeTraps)
			{
				// get offset between target point and trapping point.
				var $offset:Number = Point.distance($target, $trap);

				// retain a reference to the trap if its offset beats out the current best.
				if ($offset < $bestOffset) {
					$bestOffset = $offset;
					$bestTrap = $trap;
				}
			}
			return (!!$bestTrap) ? $bestTrap : $node;
		}

		/**
		* Attempts to merge a node into the grid by connecting it with any nodes that fall within a common box.
		* @param $node: Node object to connect into the grid.
		* @return Boolean: true if the node has aqcuired connections.
		*/
		private function _connectUsingBoxes($node:Node):Node
		{
			// loop through all boxes.
			for (var $j:int = 0; $j < numBoxes; $j++)
			{
				var $box:Box = getBoxAt($j);

				if ($box.containsPoint($node))
				{
					// if box contains the new node,
					// join all of the box's children with the new node.
					for (var $k:int=0; $k < $box.numChildNodes; $k++)
					{
						var $childId:String = $box.getChildNode($k);
						$node.addNeighbor($childId);
						getNodeById($childId).addNeighbor($node.id);
					}

					// add node as a child of the box.
					$box.addChildNode($node.id);
				}
			}
			return $node;
		}

		/**
		* Attempts to merge a node into the grid by connecting it with the closest existing node.
		* @param $node: Node object to connect into the grid.
		* @return Boolean: true if the node has aqcuired connections.
		*/
		private function _connectUsingNodes($node:Node):Node
		{
			var $nearestId:String = "";
			var $shortest:Number;

			// loop through all nodes, looking for the nearest.
			for (var $nodeId:String in _nodes)
			{
				var $distance:Number = Point.distance($node, getNodeById($nodeId));

				if (isNaN($shortest) || $distance < $shortest)
				{
					$nearestId = $nodeId;
					$shortest = $distance;
				}
			}

			// connect node with nearest node if another node was found.
			if ($nearestId != "")
			{
				$node.addNeighbor($nearestId);
				getNodeById($nearestId).addNeighbor($node.id);
			}
			return $node;
		}

	//-------------------------------------------------
	// Pathfinding
	//-------------------------------------------------

		/**
		* Gets a path between two points within the grid.
		* @param start Start point coordinates.
		* @param goal Goal point coordinates.
		* @param confineToWalkarea Specifies if the serch should restrict the goal point to fall within designated walk-safe areas.
		* @return Returns a Path object containing Node list and length information.
		*/
		public function getPath($start:Point, $goal:Point, $confineToWalkarea:Boolean=false):Path
		{
			var $grid:Grid = this.copy();
			var $startId:String = $grid.connectNewNode(new Node("start", $start.x, $start.y), $confineToWalkarea);
			var $goalId:String = $grid.connectNewNode(new Node("goal", $goal.x, $goal.y), $confineToWalkarea);

			try {
				// Try to find a path.
				// this process may error if user-defined grids are malformed.
				var $path:Path = $grid.findPath($startId, $goalId);
				$grid.destroy();
				return $path;
			}
			catch($error:Error) {
				// do nothing.
				trace("Error finding path.");
			}
			return null;
		}

		/**
		* Searches grid for the best path between two nodes.
		*/
		internal function findPath($startId:String, $goalId:String):Path
		{
			// queue of paths to search
			var $stack:Array = new Array(new Path(0, 0, [$startId]));
			// best path to goal
			var $best:Path = new Path();
			// shortest distance to each node reached thus far
			var $reachedNodes:Object = new Object();
			// cycle counter (for debug and optimization)
			var $cyc:int = 0;

			// UNTIL ALL SEARCH PATHS HAVE BEEN ELIMINATED
			while ($stack.length > 0)
			{
				// pull the first path out from the search stack
				var $searchPath:Path = $stack.shift() as Path;

				// pull the last node from the search path
				var $searchNode:Node = getNodeById($searchPath.lastElement);

				// EXTEND PATH ONE STEP TO ALL NEIGHBORS
				// creating X new paths
				for (var $j:int=0; $j < $searchNode.numNeighbors; $j++)
				{
					// Branch: duplicate current search path as a new branch
					var $branch:Path = $searchPath.copy();

					// Pull and expand upon each of searchNode's neighbor Id's.
					var $expandNode:String = $searchNode.getNeighbor($j);

					// REJECT PATHS WITH LOOPS
					// if branch does NOT already contain next search node
					if (!$branch.containsNode($expandNode))
					{
						// get coordinates of previous, current, and goal nodes
						var $prevCoord:Node = getNodeById($branch.lastElement);
						var $currentCoord:Node = getNodeById($expandNode);
						var $goalCoord:Node = getNodeById($goalId);

						// extend branch after having referenced last end-point.
						$branch.addNode($expandNode);

						// UPDATE BRANCH LENGTH AND UNDERESTIMATE
						$branch.length += Point.distance($prevCoord, $currentCoord);
						$branch.bestCase = $branch.length + Point.distance($currentCoord, $goalCoord);

						// TRACK SHORTEST DISTANCE TO EACH NODE REACHED
						// attempt to pull a distance-to-node from the register of reached nodes.
						// if node has not yet been reached, register it with the current branch length.
						var $shortest:Number = $reachedNodes[$expandNode];
						if (isNaN($shortest)) $shortest = $branch.length;

						// TEST IF PATH IS WORTH KEEPING (keep if:)
						// - if branch is as short or shorter than the best distance to the current expansion node
						// - and if a best-path has not been found yet, OR if this branch's best case scenario is still shorter than the best path.
						if ($branch.length <= $shortest && (!$best.hasLength || $branch.bestCase < $best.length))
						{
							// log as best path to current search node
							$reachedNodes[$expandNode] = $branch.length;

							// If the expansion node is the goal, save branch as the parth to beat.
							// Otherwise, add the branch back into the search stack.
							if ($expandNode == $goalId) $best = $branch;
							else $stack.push($branch);
						}
					}
				}

				// PRIORITIZE SEARCH PATHS
				// sort paths by best-case scenario so that most likely paths are searched first.
				var $priority:Function = function($a:Path, $b:Path):int
				{
					if ($a.bestCase < $b.bestCase) return -1;
					else if ($a.bestCase > $b.bestCase) return 1;
					else return 0;
				}
				$stack.sort($priority);
				$cyc++;
			}
			//trace("cycles: "+ $cyc);
			$best.compile(this);
			return $best;
		}
	}
}
