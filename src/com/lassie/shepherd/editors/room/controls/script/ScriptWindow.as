package com.lassie.shepherd.editors.room.controls.script
{
	import com.lassie.shepherd.ui.window.FloatingWindow;
	import com.lassie.shepherd.display.TextRestrictions;
	import com.lassie.shepherd.editors.room.RoomController;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.events.Event;
	
	public final class ScriptWindow extends FloatingWindow
	{
		private const TAB_SCRIPTS:String = "Scripts";
		private const OPTION_ENTER_ROOM:String = "enterRoom";
		private const OPTION_EXIT_ROOM:String = "exitRoom";
		private const OPTION_NOTES:String = "notes";
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
	
		private var _activePanel:ScriptWindowPanel;
		private var _scriptEditor:RoomScriptsEditor;
		private var _notesEditor:NotesEditor;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function ScriptWindow(dockIndex:int=0):void
		{
			super();
			
			_scriptEditor = new RoomScriptsEditor();
			_notesEditor = new NotesEditor();
			
			addWindowTab(TAB_SCRIPTS, dockIndex);
			addWindowOption(OPTION_ENTER_ROOM);
			addWindowOption(OPTION_EXIT_ROOM);
			addWindowOption(OPTION_NOTES);
			enableResize(300, 200, 200, 100);
		}
		
	// --------------------------------------------------
	//  Methods
	// --------------------------------------------------
		
		protected override function launch():void
		{
			super.launch();
			selectWindowOption(OPTION_ENTER_ROOM);
			_openedX = RoomController.roomData.scriptWinX;
			_openedY = RoomController.roomData.scriptWinY;
		}
		
		protected override function logWindowCoords():void
		{
			RoomController.roomData.scriptWinX = x;
			RoomController.roomData.scriptWinY = y;
		}
		
		protected override function resize():void
		{
			super.resize();
			if (_activePanel) _activePanel.resize((_resizer.x - _activePanel.x - FloatingWindow.PADDING_X), (_resizer.y - _activePanel.y - FloatingWindow.PADDING_Y));
		}
		
		protected override function activate():void
		{
			resize();
		}
		
		protected override function onChangeWindowOption(opt:String):void
		{
			// clear any existing active panel
			if (_activePanel != null)
			{
				removeChild(_activePanel);
				_activePanel = null;
			}
			
			switch(opt)
			{
				case OPTION_ENTER_ROOM:
					
					_activePanel = _scriptEditor;
					_scriptEditor.mode = RoomScriptModes.ENTER_ROOM;
					break;
				
				case OPTION_EXIT_ROOM:
					
					_activePanel = _scriptEditor;
					_scriptEditor.mode = RoomScriptModes.EXIT_ROOM;
					break;
					
				case OPTION_NOTES:
					
					_activePanel = _notesEditor;
					break;
			}
			
			if (_activePanel != null)
			{
				_activePanel.x = 10;
				_activePanel.y = FloatingWindow.TAB_HEIGHT + FloatingWindow.OPTIONS_HEIGHT + FloatingWindow.TOP_PADDING;
				_activePanel.populate();
				addChild(_activePanel);
				resize();
			}
		}
	}
}