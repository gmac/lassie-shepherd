package com.lassie.shepherd.editors.room.controls.script
{
	import flash.events.Event;
	import fl.controls.TextArea;
	import com.lassie.shepherd.editors.room.RoomController;
	
	internal final class RoomScriptsEditor extends ScriptWindowPanel
	{
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
	
		private var _mode:String = RoomScriptModes.ENTER_ROOM;
		private var _scripts:TextArea;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function RoomScriptsEditor():void
		{
			super();
			
			_scripts = new TextArea();
			_scripts.focusRect = false;
			_scripts.addEventListener(Event.CHANGE, this.captureScript);
			addChild(_scripts);
		}
		
	// --------------------------------------------------
	//  Methods
	// --------------------------------------------------
		
		public function get mode():String
		{
			return _mode;
		}
		
		public function set mode(m:String):void
		{
			_mode = m;
		}
		
		public override function populate():void
		{
			var val:String = (mode == RoomScriptModes.ENTER_ROOM) ? RoomController.roomData.enterRoom : RoomController.roomData.exitRoom;
			_scripts.text = unescape(val);
		}
		
		public override function resize(w:int, h:int):void
		{
			_scripts.width = w;
			_scripts.height = h;
			_scripts.drawFocus(false);
		}
		
	// --------------------------------------------------
	//  Event handlers
	// --------------------------------------------------
		
		private function captureScript(evt:Event):void
		{
			switch(mode)
			{
				case RoomScriptModes.ENTER_ROOM:
				
					RoomController.roomData.enterRoom = escape(_scripts.text);
					break;
					
				case RoomScriptModes.EXIT_ROOM:
				
					RoomController.roomData.exitRoom = escape(_scripts.text);
					break;
			}
		}
	}
}