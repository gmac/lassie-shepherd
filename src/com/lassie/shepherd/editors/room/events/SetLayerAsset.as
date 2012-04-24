package com.lassie.shepherd.editors.room.events
{
	import flash.events.Event;
	
	public final class SetLayerAsset extends Event
	{
	// --------------------------------------------------
	//  Command
	// --------------------------------------------------		

		public static const COMMAND:String = "SetLayerAsset";
		
	// --------------------------------------------------
	//  Params
	// --------------------------------------------------
		
		public var libraryId:String;
		public var libraryAsset:String;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function DeleteLayer(index:int, bubbles:Boolean=true, cancelable:Boolean=false):void
		{
			super(COMMAND, bubbles, cancelable);
			layerIndex = index;
		}
	}
}