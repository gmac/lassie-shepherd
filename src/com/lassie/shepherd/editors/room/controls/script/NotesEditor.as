package com.lassie.shepherd.editors.room.controls.script
{
	import flash.events.Event;
	import fl.controls.TextArea;
	import com.lassie.shepherd.editors.room.RoomController;
	
	internal final class NotesEditor extends ScriptWindowPanel
	{
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
	
		private var _notes:TextArea;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function NotesEditor():void
		{
			super();
			
			_notes = new TextArea();
			_notes.focusRect = false;
			_notes.addEventListener(Event.CHANGE, this.captureNotes);
			addChild(_notes);
		}
		
	// --------------------------------------------------
	//  Methods
	// --------------------------------------------------
		
		public override function populate():void
		{
			_notes.text = unescape(RoomController.roomData.notes);
		}
		
		public override function resize(w:int, h:int):void
		{
			_notes.width = w;
			_notes.height = h;
			_notes.drawFocus(false);
		}
		
	// --------------------------------------------------
	//  Event handlers
	// --------------------------------------------------
		
		private function captureNotes(evt:Event):void
		{
			RoomController.roomData.notes = escape(_notes.text);
		}
	}
}