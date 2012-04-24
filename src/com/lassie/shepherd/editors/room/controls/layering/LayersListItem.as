package com.lassie.shepherd.editors.room.controls.layering
{
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import com.lassie.shepherd.core.LSClip;
	
	public final class LayersListItem extends LSClip
	{
		public var textName:TextField;
		public var textType:TextField;
		
		public var _selected:Boolean = false;
		public var _index:int;
		public var _layerName:String;
		
		public function LayersListItem():void
		{
			super();
			stop();
			mouseChildren = false;
		}
		
	// --------------------------------------------------
	//  Initializers
	// --------------------------------------------------
	
		protected override function init():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, this.handleMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, this.handleMouseOut);
		}
		
		protected override function uninit():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, this.handleMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, this.handleMouseOut);
		}
		
	// --------------------------------------------------
	//  Methods
	// --------------------------------------------------
		
		public function setDisplay(index:int, id:String, type:String):void
		{
			_index = index;
			_layerName = id;
			textName.text = index + " : " + _layerName;
			textType.text = type;
		}
		
		public function get layerName():String
		{
			return _layerName;
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
	}
}