package com.lassie.shepherd.editors.room.controls.layering
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	public final class LayersList extends Sprite
	{
	// --------------------------------------------------
	//  Private members
	// --------------------------------------------------
	
		private var _selectedIndex:int=0;
		private var _display:Sprite;
		private var _index:DragIndex;
		private var _drag:DragItem;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function LayersList():void
		{
			super();
			
			_display = new Sprite();
			addChild(_display);
			
			_drag = new DragItem(this);
			_index = new DragIndex(this, _drag);
		}

	// --------------------------------------------------
	//  List data get / set
	// --------------------------------------------------
		
		/*public function get listData():Array
		{
			var list:Array = new Array();
			
			for (var j:int = 0; j < _display.numChildren; j++)
			{
				// unfinished
			}
			
			return list;
		}*/
		
		public function set listData(dat:Array):void
		{
			updateRowCount(dat.length);

			// get number of rows
			var rows:int = dat.length-1;
			
			// populate list items
			for (var j:int = 0; j < dat.length; j++)
			{
				var item:LayersListData = dat[j];
				var listItem:LayersListItem = LayersListItem(_display.getChildAt(j));
				
				listItem.y = Math.round((rows * listItem.height) - (listItem.height * j));
				listItem.setDisplay(j, item.id, item.abbrev);
				listItem.selected = false;
			}
			selectedIndex = _selectedIndex;
			redraw();
		}
		
	// --------------------------------------------------
	//  Selected index get / set
	// --------------------------------------------------
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(n:int):void
		{
			try
			{
				getSeledtedItem().selected = false;
				LayersListItem(_display.getChildAt(n)).selected = true;
			}
			catch (e)
			{
				// could not resolve a selection
			}
			_selectedIndex = n;
		}
		
	// --------------------------------------------------
	//  private methods
	// --------------------------------------------------
		
		private function updateRowCount(num:int):void
		{
			var item:LayersListItem;
			
			// repeat until list has as many items as are required
			while(num != _display.numChildren)
			{
				// Add layer item if a new item has been added
				if (num > _display.numChildren)
				{
					// create new list item
					item = new LayersListItem();
					
					// listen for mouse clicks
					item.addEventListener(MouseEvent.MOUSE_DOWN, this.handleSelectItem);
					
					// add item to display list
					_display.addChild(item);
				}
				// remove and item if a layer has been removed
				else if (num < _display.numChildren)
				{
					// get first list item
					item = LayersListItem(_display.getChildAt(0));
					
					// remove its mouse listener
					item.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleSelectItem);
					
					// remove it from display
					_display.removeChildAt(0);
				}
			}
		}
		
		private function getSeledtedItem():LayersListItem
		{
			return LayersListItem(_display.getChildAt(_selectedIndex));
		}
		
		private function startItemDrag():void
		{
			// get selected list item
			var item:LayersListItem = getSeledtedItem();
			
			// enable the drag sprite
			_drag.enable(item.layerName, _display.getRect(this));
			
			// enable the depth index marker
			_index.enable(item.width, item.height, _selectedIndex, _display.numChildren-1);
		}
		
		private function redraw():void
		{
			// draw list border
			graphics.clear();
			graphics.lineStyle(1, 0x90C1EF, 1);
			graphics.beginFill(0xefefef, 1);
			graphics.drawRect(-1, -1, width+1, height+1);
			graphics.endFill();
		}
		
	// --------------------------------------------------
	//  event handlers
	// --------------------------------------------------
		
		private function handleSelectItem(evt:MouseEvent):void
		{
			// get index of selected item
			var index:int = _display.getChildIndex(Sprite(evt.currentTarget));

			// if index is already selected
			if (selectedIndex == index)
			{
				// start layer drag
				startItemDrag();
			}
			else
			{
				// otherwise, select list index
				selectedIndex = index;
				
				// call selection
				dispatchEvent(new LayersListEvent(LayersListEvent.SELECT, index));
			}
		}
	}
}