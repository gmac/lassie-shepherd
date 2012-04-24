package com.lassie.shepherd.data.room
{
	import flash.geom.Rectangle;
	import com.lassie.utils.ObjectUtil;
	
	public final class GridCompiler
	{
		public static function compile(dat:WalkareaData):WalkareaData
		{
			// clone walkarea grid
			var grid:WalkareaData = RoomDataParser.toWalkareaData(ObjectUtil.clone(dat));
			
			// loop through all boxes
			for (var j:int = 0; j < grid.boxes.length; j++)
			{
				var box:BoxData = BoxData(grid.boxes[j]);
				box.children = new Array();
				var rect:Rectangle = new Rectangle(box.x, box.y, box.width, box.height);
				
				// loop through all nodes
				for (var k:int = 0; k < grid.nodes.length; k++)
				{
					var node:NodeData = NodeData(grid.nodes[k]);
					
					// find nodes that fall within the box
					if (rect.contains(node.x, node.y))
					{
						box.children.push(node.id);
					}
				}
				
				// loop through all nodes again
				for (k = 0; k < grid.nodes.length; k++)
				{
					node = NodeData(grid.nodes[k]);
					
					// add box children as neighbors of node
					if (box.children.indexOf(node.id) > -1)
					{
						addNodeChildren(node, box.children);
					}
				}
			}
			
			return grid;
		}
		
		private static function addNodeChildren(node:NodeData, merge:Array):void
		{
			for (var j:int = 0; j < merge.length; j++)
			{
				// if node does not already contain neighbor reference
				if (node.id != merge[j] && node.neighbors.indexOf(merge[j]) < 0)
				{
					// add neighbor
					node.neighbors.push(merge[j]);
				}
			}
		}
		
	}
}