/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	final internal class GridDraw
	{
		/**
		* Renders an image of the grid into the specified display scope.
		*/
		static public function render($grid:Grid, $scope:Sprite):void
		{
			var $gridImage:Sprite = new Sprite();
			var $nodeImage:Sprite = new Sprite();
			
			_drawBoxes($grid, $gridImage);
			_drawBeams($grid, $gridImage.graphics);
			_drawNodes($grid, $nodeImage.graphics);
			
			// disable mouse and add drawing to scope
			$gridImage.mouseEnabled = false;
			$gridImage.addChild($nodeImage);
			$scope.addChild($gridImage);
		}
		
		/**
		* Draws grid boxes.
		*/
		static private function _drawBoxes($grid:Grid, $scope:Sprite):void
		{
			for (var $j:int=0; $j < $grid.numBoxes; $j++) {
				var $box:Box = $grid.getBoxAt($j);
				var $canvas:Shape = new Shape();
				$canvas.graphics.beginFill(0x000000, 0.5);
				$canvas.x = $box.x;
				$canvas.y = $box.y;
				$canvas.graphics.drawRect(0, 0, $box.width, $box.height);
				$canvas.graphics.endFill();
				$scope.addChild($canvas);
			}
		}
		
		/**
		* Draws grid beams.
		*/
		static private function _drawBeams($grid:Grid, $canvas:Graphics):void
		{
			var $drawn:Array = new Array();
			$canvas.lineStyle(2, 0x000000);
			
			// loop through all grid nodes
			for (var $j:int=0; $j < $grid.numNodes; $j++)
			{
				var $node:Node = $grid.getNodeAt($j);
				
				// loop through all neighbors of each child.
				for (var $k:int=0; $k < $node.numNeighbors; $k++)
				{
					var $neighbor:Node = $grid.getNodeById( $node.getNeighbor($k) );
					
					// check if a beam has been drawn yet
					if ($drawn.indexOf($neighbor.id+"-"+$node.id) < 0)
					{
						$canvas.moveTo($node.x, $node.y);
						$canvas.lineTo($neighbor.x, $neighbor.y);
						$drawn.push($node.id+"-"+$neighbor.id);
					}
				}
			}
		}
		
		/**
		* Draws grid nodes.
		*/
		static private function _drawNodes($grid:Grid, $canvas:Graphics):void
		{
			$canvas.beginFill(0xFF0000, 1);
			for (var $j:int=0; $j < $grid.numNodes; $j++) {
				var $node:Node = $grid.getNodeAt($j);
				$canvas.drawCircle($node.x, $node.y, 4);
			}
			$canvas.endFill();
		}
	}
}