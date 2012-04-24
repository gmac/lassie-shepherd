package com.lassie.shepherd.editors.room.layout.layering
{
	import flash.events.Event;
	import com.lassie.shepherd.data.room.LayerData;
	import com.lassie.shepherd.data.room.LayerTypes;
	
	public final class CharacterLayer extends LayerObject
	{
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function CharacterLayer(dat:LayerData=null):void
		{
			// run super constructors
			super(dat != null ? dat : new LayerData(LayerTypes.CHARACTER));
			
			// premanently lock Id / art
			_permanentLockId = true;
			_permanentLockArt = true;
			
			// create and add hit area
			_hit = new HitArea();
			
			// create and hold registration point
			_reg = new Registration();
			addChild(_reg);
			
			// create and hold floor target point
			_tar = new DummyTarget();

			// update display based on phase properties
			updateDisplay();
		}
		
		protected final override function handleLayerDrag(evt:Event):void
		{
			// update layer with filters ONLY (do not update position controls)
			applyScaleFilter();
			applyColorFilter();
			applyFocusFilter();
		}
	}
}