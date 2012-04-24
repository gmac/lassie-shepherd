package com.lassie.shepherd.editors.room.controls.layering
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.geom.Rectangle;
	
	// --------------------------------------------------
	//  DRAG ITEM
	// --------------------------------------------------
	
	internal final class DragItem extends Sprite
	{
		private const PAD_X:int = 5;
		private const PAD_Y:int = 2;
		
		private var _scope:Sprite;
		private var _text:TextField;
		
		public function DragItem(scope:Sprite):void
		{
			super();
			_scope = scope;
			_text = new TextField();
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.defaultTextFormat = new TextFormat("Arial", 11);
			_text.selectable = false;
			addChild(_text);
		}
		
		public function enable(layerName:String, bounds:Rectangle):void
		{
			_scope.addChild(this);
			
			_text.text = layerName;
			_text.x = -Math.round(_text.width/2);
			_text.y = -Math.round(_text.height/2);
			redraw();
			
			bounds.x += Math.round(width/2);
			bounds.y += Math.round(height/2);
			bounds.width -= width;
			bounds.height -= Math.ceil(height/2);
			
			startDrag(true, bounds);
			x = parent.mouseX;
			y = parent.mouseY;
			
			stage.addEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
		}
		
		private function redraw():void
		{
			graphics.clear();
			graphics.lineStyle(1, 0x999999, 1);
			graphics.beginFill(0xEFEFEF, 0.90);
			graphics.drawRect(_text.x - PAD_X, _text.y - PAD_Y, _text.width + (PAD_X * 2), _text.height + (PAD_Y * 2));
			graphics.endFill();
		}
		
		private function handleMouseUp(evt:MouseEvent):void
		{
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
			parent.removeChild(this);
		}
	}
}