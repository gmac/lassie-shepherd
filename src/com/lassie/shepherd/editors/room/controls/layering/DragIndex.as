package com.lassie.shepherd.editors.room.controls.layering
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.MouseEvent;

	internal final class DragIndex extends Sprite
	{
		private var _index:int=0;
		private var _increment:int;
		private var _startIndex:int;
		private var _rows:int;
		private var _scope:Sprite;
		private var _dragItem:Sprite;
		
		public function DragIndex(scope:Sprite, drag:Sprite):void
		{
			super();
			_scope = scope;
			_dragItem = drag;
		}
		
		public function enable(w:int, inc:int, startIndex:int, rows:int):void
		{
			_increment = inc;
			_startIndex = startIndex;
			_rows = rows;
			
			// clear all graphics
			graphics.clear();
			
			// draw top and bottom border
			graphics.beginFill(0x009DFF, 1);
			graphics.drawRect(0, -1, w, 1);
			graphics.drawRect(0, 1, w, 1);
			graphics.endFill();
			
			// draw center hairline
			graphics.beginFill(0x9CD8FE, 1);
			graphics.drawRect(0, 0, w, 1);
			graphics.endFill();
	
			_scope.addChildAt(this, _scope.numChildren-1);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, this.handleEndDrag);
			_dragItem.addEventListener(MouseEvent.MOUSE_MOVE, this.handleUpdate);
			updateIndex();
		}
		
		private function updateIndex():void
		{
			_index = Math.floor(_dragItem.y / _increment);
			y = _increment * _index;
		}
		
		private function handleUpdate(evt:MouseEvent):void
		{
			updateIndex();
		}
		
		private function handleEndDrag(evt:MouseEvent):void
		{
			// remove listeners
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleEndDrag);
			_dragItem.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleUpdate);
			
			var setTo:int = _rows-_index;
			if (setTo < _startIndex)
			{
				setTo += 1;
			}
			
			// update index
			parent.dispatchEvent(new LayersListEvent(LayersListEvent.SHIFT_INDEX, setTo));
			
			// remove index display
			parent.removeChild(this);
		}
	}
}