package com.lassie.shepherd.editors.room.layout.layering
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.lassie.shepherd.data.room.LayerData;
	import com.lassie.shepherd.data.room.LayerTypes;
	import com.lassie.shepherd.data.room.ParallaxAxis;
	import com.lassie.shepherd.editors.room.events.RoomEditorEvent;
	import com.lassie.shepherd.editors.room.RoomController;
	import com.lassie.shepherd.editors.room.layout.layering.LayerObject;
	import com.lassie.shepherd.editors.room.layout.layering.Registration;
	import com.lassie.shepherd.editors.room.layout.layering.HitArea;
	import com.lassie.shepherd.editors.room.layout.layering.DummyTarget;
	
	public final class PlaneLayer extends LayerObject
	{
		private var _parallaxEnabled:Boolean = false;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function PlaneLayer(dat:LayerData=null):void
		{
			// run super constructors
			super(dat != null ? dat : new LayerData(LayerTypes.PLANE));
			
			// create and add hit area
			_hit = new HitArea();
			addChildAt(_hit, 0);

			// create and add registration point
			_reg = new Registration();
			addChild(_reg);
			
			// create and display floor target point
			_tar = new DummyTarget();
			
			// update display based on phase properties
			updateDisplay();
			
			// update parallax setting to make sure scroll config is applied
			parallax = parallax;
		}
		
	// --------------------------------------------------
	//  Init / uninit
	// --------------------------------------------------
		
		protected override function uninit():void
		{
			super.uninit();
			parallax = ParallaxAxis.NONE;
		}
		
	// --------------------------------------------------
	//  Parallax scrolling
	// --------------------------------------------------
		
		public override function set parallax(val:String):void
		{
			super.parallax = val;
			
			if (!_parallaxEnabled && val != ParallaxAxis.NONE)
			{
				// enable parallax
				RoomController.instance.addEventListener(RoomEditorEvent.UPDATE_VIEWPORT, this.onScrollLayout);
				applyParallax();
			}
			else if (_parallaxEnabled && val == ParallaxAxis.NONE)
			{
				// disable parallax
				RoomController.instance.removeEventListener(RoomEditorEvent.UPDATE_VIEWPORT, this.onScrollLayout);
			}
		}
		
		private function applyParallax():void
		{
			// if the layer image is enabled and the layer has display
			if (image && _imgDisplay != null)
			{
				var rect:Rectangle = _imgDisplay.getRect(parent);
				var position:Point = new Point(x, y);
				var offset:Point = position.subtract(rect.topLeft);
				var axis:String = parallax;
				var rangeX:int = RoomController.layoutWidth - RoomController.viewportWidth;
				var rangeY:int = RoomController.layoutHeight - RoomController.viewportHeight;
				var range:Number;
				
				// X-axis shift
				if ((axis == ParallaxAxis.X || axis == ParallaxAxis.XY) && rangeX > 0)
				{
					range = RoomController.layoutWidth - rect.width + 2;
					rect.x = Math.floor(range * RoomController.layoutScrollPercentX) - 1;
					x = rect.x + offset.x;
				}
				
				// Y-axis shift
				if ((axis == ParallaxAxis.Y || axis == ParallaxAxis.XY) && rangeY > 0)
				{
					range = RoomController.layoutHeight - rect.height + 2;
					rect.y = Math.round(range * RoomController.layoutScrollPercentY) - 1;
					y = rect.y + offset.y;
				}
			}
		}
		
	// --------------------------------------------------
	//  Event listeners
	// --------------------------------------------------
		
		private function onScrollLayout(evt:RoomEditorEvent):void
		{
			applyParallax();
		}
	}
}