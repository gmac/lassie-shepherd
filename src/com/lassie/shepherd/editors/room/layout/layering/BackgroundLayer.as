package com.lassie.shepherd.editors.room.layout.layering
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import com.lassie.shepherd.data.room.LayerData;
	import com.lassie.shepherd.data.room.LayerTypes;
	import com.lassie.shepherd.editors.room.layout.layering.LayerObject;
	import com.lassie.shepherd.editors.room.layout.layering.Registration;
	import com.lassie.shepherd.editors.room.layout.layering.HitArea;
	import com.lassie.shepherd.editors.room.layout.layering.DummyTarget;
	import com.lassie.shepherd.editors.room.RoomController;
	
	public final class BackgroundLayer extends LayerObject
	{
		private var _lastReportedW:int = 0;
		private var _lastReportedH:int = 0;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function BackgroundLayer(dat:LayerData=null):void
		{
			// run super constructors
			super(dat != null ? dat : new LayerData(LayerTypes.BACKGROUND));
			
			// set as permanently locked (ID / pos)
			_permanentLockId = true;
			_permanentLockPos = true;
			
			// create and add hit area
			_hit = new HitArea();
			addChildAt(_hit, 0);
			
			// create and hold registration point
			_reg = new Registration();
			
			// create and hold floor target point
			_tar = new DummyTarget();

			// update display based on phase properties
			updateDisplay();
		}
		
		public override function set asset(val:String):void
		{
			super.asset = val;
			updateLayoutSize();
		}
		
		public override function set hitW(val:int):void
		{
			super.hitW = val;
			updateLayoutSize();
		}
		
		public override function set hitH(val:int):void
		{
			super.hitH = val;
			updateLayoutSize();
		}
		
		public override function set image(val:Boolean):void
		{
			super.image = val;
			updateLayoutSize();
		}
		
		public override function set imgW(val:Number):void
		{
			super.imgW = val;
			updateLayoutSize();
		}
		
		public override function set imgH(val:Number):void
		{
			super.imgH = val;
			updateLayoutSize();
		}
		
		public override function set frame(val:int):void
		{
			super.frame = val;
			updateLayoutSize();
		}
		
		private function updateLayoutSize():void
		{
			// get regtangular bounds of background (excludes stroke thickness)
			var rect:Rectangle = getRect(this);
			
			// if background layer has changed size
			if (rect.width != _lastReportedW || rect.height != _lastReportedH)
			{
				RoomController.setLayoutSize(rect.width, rect.height);
				_lastReportedW = rect.width;
				_lastReportedH = rect.height;
			}
		}
	}
}