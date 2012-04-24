package com.lassie.shepherd.ui.tabs
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.lassie.shepherd.core.LSClip;
	import com.lassie.shepherd.ui.tabs.TabEvent;
	
	public class Tab extends LSClip
	{
		private var _collection:String;
		private var _option:String;
		private var _selected:Boolean = false;

		public function Tab(collection:String="", option:String=""):void
		{
			super();
			stop();
			
			_collection = collection;
			_option = option;

			tabEnabled = false;
			tabChildren = false;
			mouseChildren = false;
			buttonMode = true;
			useHandCursor = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, this.handleMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, this.handleMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
		}
		
		protected override function launch():void
		{
			parent.addEventListener(TabEvent.SELECT, this.handleSelect);
		}
		
		public override function dispose():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, this.handleMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, this.handleMouseOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
			parent.removeEventListener(TabEvent.SELECT, this.handleSelect);
		}
		
	// --------------------------------------------------
	//  Public interface
	// --------------------------------------------------
		
		public function get collection():String
		{
			return _collection;
		}
		
		public function set collection(val:String):void
		{
			_collection = val;
		}
		
		public function get option():String
		{
			return _option;
		}
		
		public function set option(val:String):void
		{
			_option = val;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(val:Boolean):void
		{
			_selected = val;
			gotoAndStop(_selected ? 3 : 1);
		}
		
	// --------------------------------------------------
	//  Event handlers
	// --------------------------------------------------
		
		private function handleMouseOver(evt:MouseEvent):void
		{
			if (!_selected)
			{
				gotoAndStop(2);
			}
		}
		
		private function handleMouseOut(evt:MouseEvent):void
		{
			if (!_selected)
			{
				gotoAndStop(1);
			}
		}
		
		private function handleMouseDown(evt:MouseEvent):void
		{
			parent.dispatchEvent(new TabEvent(TabEvent.SELECT, _collection, _option));
		}
		
		private function handleSelect(evt:TabEvent):void
		{
			// if event comes from tab's collection
			if (evt.collection == collection)
			{
				// select if the tab's option was called
				selected = (evt.option == option);
			}
		}
	}
}