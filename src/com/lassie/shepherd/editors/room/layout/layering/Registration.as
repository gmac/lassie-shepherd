package com.lassie.shepherd.editors.room.layout.layering
{
	import flash.display.Sprite;
	
	internal final class Registration extends Sprite
	{
		public function Registration():void
		{
			super();
			draw();
		}
		
	// --------------------------------------------------
	//  Appearance
	// --------------------------------------------------
		
		private function draw():void
		{
			var r:Number = 4;
			graphics.clear();
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xFFFFFF, 1);
			graphics.drawCircle(0, 0, r);
			graphics.endFill();
			
			graphics.lineStyle(1, 0x000000, 0.3);
			graphics.moveTo(0, -r);
			graphics.lineTo(0, r);
			graphics.moveTo(-r, 0);
			graphics.lineTo(r, 0);
		}
	}
}