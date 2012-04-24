package com.lassie.shepherd.editors.room.layout.walkarea
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.lassie.shepherd.core.LSSprite;
	import com.lassie.shepherd.data.room.BoxData;
	import com.lassie.shepherd.editors.room.RoomController;
	
	public final class BoxObject extends LSSprite
	{
		private static const COLOR_NORMAL:uint = 0x000000;
		private static const COLOR_HILITE:uint = 0x00CCFF;
		
	// --------------------------------------------------
	//  Private members
	// --------------------------------------------------
		
		private var _data:BoxData;
		private var _selected:Boolean = false;
		private var _resizing:Boolean = false;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
	
		public function BoxObject(dat:BoxData):void
		{
			super();
			
			// store reference to box display's source data
			_data = dat;
			
			// draw the initial box display
			redraw();
		}
		
	// --------------------------------------------------
	//  Init / uninit
	// --------------------------------------------------
		
		protected override function init():void
		{
			// if placed offscreen (just created)
			if (_data.x < 0 && _data.y < 0)
			{
				// plot at the center of the current viewable area
				x = _data.x = Math.round(RoomController.layoutCenterX - (width / 2));
				y = _data.y = Math.round(RoomController.layoutCenterY - (height / 2));
			}
			else
			{
				// otherwise, plot at data coordinates
				x = _data.x;
				y = _data.y;
			}
		}
		
	// --------------------------------------------------
	//  Property getter / setters
	// --------------------------------------------------
		
		public function get data():BoxData
		{
			return _data;
		}
		
		public function get id():String
		{
			return _data.id;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(val:Boolean):void
		{
			_selected = val;
			redraw();
		}
		
	// --------------------------------------------------
	//  Appearance
	// --------------------------------------------------
		
		public function redraw():void
		{
			var color:uint = _selected ? COLOR_HILITE : COLOR_NORMAL;
			graphics.clear();
			graphics.lineStyle(1, color, 0.5);
			graphics.beginFill(color, 0.20);
			graphics.drawRect(0, 0, _data.width, _data.height);
			graphics.endFill();
		}
		
		public override function stopDrag():void
		{
			super.stopDrag();
			_data.x = x;
			_data.y = y;
		}
		
		public function enableResize(enable:Boolean):void
		{
			if (enable && !_resizing)
			{
				addEventListener(Event.ENTER_FRAME, this.handleResize);
			}
			else if (!enable && _resizing)
			{
				removeEventListener(Event.ENTER_FRAME, this.handleResize);
				reorient();
			}
			_resizing = enable;
		}
		
		/**
		* reorient();
		* Corrects box orientation after resize
		* assures that registration always falls in the upper-left
		*/
		private function reorient():void
		{
			// test for horizontal inversion
			if (_data.width < 0)
			{
				_data.width = Math.abs(_data.width);
				x -= _data.width;
			}
			
			// test for vertical inversion
			if (_data.height < 0)
			{
				_data.height = Math.abs(_data.height);
				y -= _data.height;
			}
			
			// redraw box with correct orientation
			redraw();
		}
		
	// --------------------------------------------------
	//  Event handlers
	// --------------------------------------------------
		
		private function handleResize(evt:Event):void
		{
			_data.width = mouseX;
			_data.height = mouseY;
			redraw();
		}
	}
}