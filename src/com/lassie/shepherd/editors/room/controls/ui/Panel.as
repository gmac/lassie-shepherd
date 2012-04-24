package com.lassie.shepherd.editors.room.controls.ui
{
	import com.lassie.shepherd.core.LSSprite;
	import com.lassie.shepherd.editors.room.RoomController;
	import com.lassie.shepherd.editors.room.interfaces.ILayer;
	
	public class Panel extends LSSprite
	{
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function Panel():void
		{
			super();
		}
		
	// --------------------------------------------------
	//  Common data references
	// --------------------------------------------------
		
		public function get selectedLayer():ILayer
		{
			return RoomController.selectedLayer;
		}
		
		public function get roomInterface():RoomController
		{
			return RoomController.instance;
		}
		
	// --------------------------------------------------
	//  Panel interface
	// --------------------------------------------------
		
		public function populate():void
		{
			// override in sub-class
		}
		
		public function capture():void
		{
			// override in sub-class
		}
	}
}