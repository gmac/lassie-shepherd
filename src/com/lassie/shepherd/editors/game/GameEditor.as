﻿package com.lassie.shepherd.editors.game{	import flash.display.Sprite;	import com.lassie.shepherd.Shepherd;	import com.lassie.shepherd.core.LSSprite;	import com.lassie.shepherd.core.IGameEditor;	import com.lassie.shepherd.display.EditorDimensions;	import com.lassie.shepherd.data.ApplicationData;	import com.lassie.shepherd.data.game.GameData;	import com.lassie.shepherd.data.FileService;	import com.lassie.shepherd.ui.buttons.ActionButton;	import com.lassie.shepherd.ui.buttons.ActionButtonIcons;	import com.lassie.shepherd.editors.game.ui.PanelDisplays;	import com.lassie.shepherd.editors.game.ui.NavPanel;	import com.lassie.shepherd.editors.game.ui.Panel;	import com.lassie.shepherd.events.ShepherdEvent;	import flash.events.Event;	import flash.events.MouseEvent;		public final class GameEditor extends LSSprite implements IGameEditor	{		private var _nav:NavPanel;		private var _controller:GameController;		private var _activePanel:Panel;		private var _overlay:Sprite;				public var closeBttn:ActionButton;			// --------------------------------------------------	//  Constructor	// --------------------------------------------------				public function GameEditor():void		{			super();						_controller = GameController.instance;			//GameController.library = lsLibrary;			//lsServices = lsServices;						_nav = new NavPanel();			_nav.addEventListener(Event.CHANGE, this._onSelectPanel);			_overlay = new Sprite();			addChildAt(_overlay, 0);			closeBttn.icon = ActionButtonIcons.CANCEL;			closeBttn.addEventListener(MouseEvent.CLICK, this._onReturnToRoomEditor);		}				protected override function launch():void		{			// load application XML data			//lsRoomData.addEventListener(ShepherdEvent.ROOM_DATA_LOADED, this._onFirstRoomLoad);			ApplicationData.instance.addEventListener(ApplicationData.APPLICATION_READY, this._onApplicationDataLoad);			ApplicationData.instance.load( lsResourcePath + "flash/config.xml");		}				protected override function init():void		{			closeBttn.visible = lsRoomData.isLoaded;			stage.addEventListener(Event.RESIZE, this._onResize);			_onResize();		}				protected override function uninit():void		{			stage.removeEventListener(Event.RESIZE, this._onResize);		}					// --------------------------------------------------	//  Event handlers	// --------------------------------------------------				private function _onApplicationDataLoad(evt:Event=null):void		{			// resolve application data and move onto GameData			ApplicationData.instance.removeEventListener(ApplicationData.APPLICATION_READY, this._onApplicationDataLoad);			// load GameData			lsGameData.addEventListener(ShepherdEvent.GAME_DATA_LOADED, this._onGameDataLoad);			lsGameData.load( lsGameData.id + "." + FileService.EXT_GAME);		}				private function _onGameDataLoad(evt:Event=null):void		{			// set application language based on loaded data.			ApplicationData.language = GameData.instance.editorLang;						// clean up game data load process and set starting display.			lsGameData.removeEventListener(ShepherdEvent.GAME_DATA_LOADED, this._onGameDataLoad);			_nav.changeTo(PanelDisplays.SETUP);			addChild(_nav);			//_setControls();		}				private function _onResize(evt:Event=null):void		{			// position game editor window			x = Math.round((stage.stageWidth-EditorDimensions.GAME_EDITOR_WIDTH) / 2);			y = Math.round((stage.stageHeight-EditorDimensions.GAME_EDITOR_HEIGHT) / 2);						// redraw and position overlay panel			_overlay.graphics.clear();			_overlay.graphics.beginFill(0x000000, 0.85);			_overlay.graphics.drawRect(0, 0, stage.stageWidth+4, stage.stageHeight+4);			_overlay.x = -(x+2);			_overlay.y = -(y+2);		}				private function _onSelectPanel(evt:Event=null):void		{			if (_activePanel != null && this.contains(_activePanel))			{				removeChild(_activePanel);			}						_activePanel = _controller[_nav.displayMode] as Panel;						if (_activePanel != null)			{				addChild(_activePanel);				_activePanel.populate();			}		}				private function _onReturnToRoomEditor(evt:Event):void		{			dispatchEvent(new ShepherdEvent(ShepherdEvent.LOAD_ROOM, true));		}	}}