package com.lassie.shepherd.editors.room.layout.layering
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	internal final class HitArea extends Sprite
	{
		public var resizing:Boolean = false;
		public var round:Boolean = false;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function HitArea():void
		{
			super();
		}
		
		public function redraw(w, h):void
		{
			graphics.clear();
			graphics.lineStyle(1, 0x000000, 0.5, false, "none");
			graphics.beginFill(0xFFFFFF, 0.25);
			
			if (round)
			{
				// Elliptical shape
				graphics.drawEllipse(0, 0, w, h);
			}
			else
			{
				// Rectangular shape
				graphics.drawRect(0, 0, w, h);
			}
			graphics.endFill();
		}
		
	// --------------------------------------------------
	//  Public methods
	// --------------------------------------------------
		
		public function reorient():void
		{
			var rect:Rectangle = getRect(this);

			if (rect.x < 0)
			{
				x -= rect.width;
			}
			
			if (rect.y < 0)
			{
				y -= rect.height;
			}
			redraw(rect.width, rect.height);
		}
		
		public function resize():void
		{
			redraw(mouseX, mouseY);
		}
	}
}