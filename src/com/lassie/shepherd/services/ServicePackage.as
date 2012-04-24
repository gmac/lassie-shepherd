﻿package com.lassie.shepherd.services{	import com.lassie.shepherd.core.LSSprite;	import com.lassie.shepherd.core.IServicePackage;	import com.lassie.shepherd.core.IDataCore;	import com.lassie.shepherd.events.ServiceEvent;	import com.lassie.shepherd.data.FileService;	import com.lassie.shepherd.data.KeyValues;	import com.lassie.shepherd.services.alert.AlertWindow;	import com.lassie.shepherd.services.loader.LoaderWindow;	import com.lassie.shepherd.services.lib.LibClassWindow;	import com.lassie.shepherd.services.lib.LibClassContent;	import com.lassie.shepherd.services.files.FileSelectorWindow;	import com.lassie.shepherd.services.files.RoomFileManager;	import flash.display.DisplayObjectContainer;	import flash.display.Sprite;	import flash.events.Event;	import flash.geom.Rectangle;		public final class ServicePackage extends LSSprite implements IServicePackage	{		private var _scope:DisplayObjectContainer;		private var _overlay:Sprite;		private var _bleed:int = 5;				private var _service:ServiceWindow;		private var _alert:AlertWindow;		private var _loader:LoaderWindow;		private var _libClass:LibClassWindow;		private var _fileSelect:FileSelectorWindow;		private var _roomFiles:RoomFileManager;			// --------------------------------------------------	//  Constructor	// --------------------------------------------------				public function ServicePackage(scope:DisplayObjectContainer):void		{			super();						_scope = scope;			_overlay = new Sprite();			_overlay.x = -_bleed;			_overlay.y = -_bleed;			addChild(_overlay);						_alert = new AlertWindow();			_loader = new LoaderWindow();			_libClass = new LibClassWindow();			_roomFiles = new RoomFileManager();			_fileSelect = new FileSelectorWindow(this);		}				protected override function init():void		{			addEventListener(ServiceEvent.CLOSE_SERVICE, this._onCloseService);			stage.addEventListener(Event.RESIZE, this._onStageResize);		}				protected override function uninit():void		{			removeEventListener(ServiceEvent.CLOSE_SERVICE, this._onCloseService);			stage.removeEventListener(Event.RESIZE, this._onStageResize);		}			// --------------------------------------------------	//  Interface methods	// --------------------------------------------------		public function modal():void		{			_open(null);		}				public function status(mssg:String, closable:Boolean=false):void		{			_alert.message = mssg;			_alert.closable = closable;			_alert.resizable = false;			_alert.redraw();			_open(_alert);		}				public function alert(mssg:String, action:String="OK", closable:Boolean=true):void		{			_alert.message = mssg;			_alert.closable = closable;			_alert.resizable = false;			_alert.setButtons(action);			//_alert.addCloseAction(action);			_alert.redraw();			_open(_alert);		}				public function dialogue(mssg:String, action:String="OK,Cancel", closable:Boolean=false):void		{			_alert.message = mssg;			_alert.closable = closable;			_alert.resizable = false;			_alert.setButtons(action);			_alert.redraw();			_open(_alert);		}				public function loadLibs(csv:String, purge:Boolean=false):void		{			//_loader.redraw();			_loader.closable = false;			_loader.resizable = false;			_loader.redraw();			_open(_loader);						// call load after adding to display			_loader.load(lsLibrary, csv, purge);		}				public function showProgress(perc:Number):void		{			if (_service != _loader)			{				_loader.closable = false;				_loader.resizable = false;				_loader.redraw();				_open(_loader);			}			_loader.showProgress(perc);		}				public function browseLibs(currentSelection:String, contentType:String=LibClassContent.MOVIE_CLIP_CONTENT):void		{			_libClass.closable = true;			_libClass.resizable = false;			_libClass.populate(lsLibrary, currentSelection, contentType);			_libClass.redraw();			_open(_libClass);		}				public function getRoomFiles():void		{			_roomFiles.closable = false;			_roomFiles.resizable = false;			_roomFiles.redraw();			_open(_roomFiles);		}				public function selectCoreLib(db:IDataCore):void		{			_selectFile(FileService.PATH_LIB_ROOT, FileService.EXT_SWF, db);		}				public function selectVoiceLib(db:IDataCore):void		{			_selectFile(FileService.PATH_LIB_VOICE, FileService.EXT_SWF, db);		}				public function selectRawData(db:IDataCore):void		{			_selectFile(FileService.PATH_RAW_DATA, FileService.EXT_XML, db);		}				private function _selectFile(path:String, ext:String, db:IDataCore):void		{			_fileSelect.closable = true;			_fileSelect.resizable = false;			_fileSelect.redraw();			_fileSelect.populate(path, ext, db);			_open(_fileSelect);		}				public function close():void		{			if (_service != null)			{				_service.parent.removeChild(_service);				_service = null;			}						if (parent != null)			{				parent.removeChild(this);				dispatchEvent(new ServiceEvent(ServiceEvent.CLOSE_SERVICE));			}		}		// --------------------------------------------------	//  Private methods	// --------------------------------------------------			private function _open(win:ServiceWindow):void		{			if (_service != null && this.contains(_service))			{				removeChild(_service);				_service = null;			}						if (win != null)			{				_service = win;				addChild(_service);			}						_redraw();			_scope.addChild(this);		}				private function _redraw():void		{			if (_scope != null)			{				var canvasW:Number = _scope.stage.stageWidth;				var canvasH:Number = _scope.stage.stageHeight;				var bleed:int = 5;								_overlay.graphics.clear();				_overlay.graphics.beginFill(0x000000, 0.3);				_overlay.graphics.drawRect(0, 0, canvasW+(bleed*2), canvasH+(bleed*2));				_overlay.graphics.endFill();							if (_service != null)				{					_service.x = Math.round((canvasW - _service.width) / 2);					_service.y = Math.round((canvasH - _service.height) / 2);				}			}		}			// --------------------------------------------------	//  Event handlers	// --------------------------------------------------				private function _onStageResize(evt:Event):void		{			_redraw();		}				private function _onCloseService(evt:Event):void		{			evt.stopPropagation();			close();		}	}}