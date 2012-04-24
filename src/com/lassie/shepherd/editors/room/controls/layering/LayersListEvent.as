package com.lassie.shepherd.editors.room.controls.layering
{
	import flash.events.Event;
	
	public final class LayersListEvent extends Event
	{
		public static const SELECT:String = "selectLayerItem";
		
		public static const SHIFT_INDEX:String = "shiftLayerItem";
		
		public var index:int;
		
		public function LayersListEvent(type:String, i:int, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, bubbles, cancelable);
			index = i;
		}
	}
}