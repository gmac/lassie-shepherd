﻿package com.lassie.shepherd.services.files{	import com.lassie.shepherd.services.ServiceWindow;	import com.lassie.shepherd.ui.buttons.LabeledActionButton;	import com.lassie.shepherd.ui.buttons.ActionButtonIcons;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.display.Sprite;	import flash.text.TextField;	import fl.controls.TextInput;	import fl.controls.List;		public class FileManagerWindow extends ServiceWindow	{		private const MAIN:String = "main";		private const MAIN_LOAD:String = "Load Room";		private const MAIN_NEW:String = "Create New Room";		private const MAIN_COPY:String = "Copy Selected";		private const MAIN_DELETE:String = "Delete Selected";		private const MAIN_CANCEL:String = "Cancel";				private const NEW:String = "new";		private const NEW_CREATE:String = "Create";		private const NEW_CANCEL:String = "Cancel";				private const COPY:String = "copy";		private const COPY_CREATE:String = "Copy";		private const COPY_CANCEL:String = "Cancel";				private const DELETE:String = "delete";		private const DELETE_YES:String = "Delete";		private const DELETE_NO:String = "Cancel";			// --------------------------------------------------	//  Stage instances	// --------------------------------------------------				public var titleText:TextField;		public var statusText:TextField;		public var errorText:TextField;		public var fileList:List;		public var fileName:TextInput;				private var _optionsMenu:Sprite;			// --------------------------------------------------	//  Constructor	// --------------------------------------------------			public function FileManagerWindow():void		{			super();			//titleText.text = title;			fileList.tabEnabled = false;			fileList.allowMultipleSelection = false;						_optionsMenu = new Sprite();			_optionsMenu.x = statusText.x;			addChild(_optionsMenu);			resizeWindow(width, height);		}				protected override function init():void		{			loadFilesList();		}			// --------------------------------------------------	//  Process: load files list / delete file	// --------------------------------------------------				protected function loadFilesList():void		{			// override in sub-class		}				protected function createNewFile():void		{			// override in sub-class		}				protected function copyFile():void		{			// override in sub-class		}				protected function deleteFile():void		{			// override in sub-class		}		protected function loadData():void		{			// override in sub-class		}	// --------------------------------------------------	//  Displays	// --------------------------------------------------			protected function setFileList(list:Array):void		{			fileList.removeAll();			list.sort();						for each (var j:String in list)			{				fileList.addItem({label:j, data:j});			}		}				protected function setStatus(mssg:String="Working..."):void		{			fileList.enabled = false;			fileName.visible = false;			statusText.text = mssg;			_clearOptionsMenu();			redraw();		}				protected function setMainMenu():void		{			fileList.enabled = true;			fileName.visible = false;			statusText.text = "File Options";			var opts:Array = [MAIN_LOAD, MAIN_NEW, MAIN_COPY, MAIN_DELETE, MAIN_CANCEL];			var icons:Array = [ActionButtonIcons.LOAD, ActionButtonIcons.ADD, ActionButtonIcons.COPY, ActionButtonIcons.DELETE, ActionButtonIcons.CANCEL];			_setOptionsMenu(MAIN, opts, icons);			redraw();		}				private function _setNewFileMenu():void		{			fileList.selectedIndex = -1;			fileList.enabled = false;			fileName.text = "";			fileName.visible = true;			statusText.text = "Enter new file name";			_setOptionsMenu(NEW, [NEW_CREATE, NEW_CANCEL], [ActionButtonIcons.ADD, ActionButtonIcons.CANCEL]);			redraw();		}				private function _setCopyFileMenu():void		{			fileList.enabled = false;			fileName.text = "";			fileName.visible = true;			statusText.text = "Enter copy name";			_setOptionsMenu(COPY, [COPY_CREATE, COPY_CANCEL], [ActionButtonIcons.COPY, ActionButtonIcons.CANCEL]);			redraw();		}				private function _setDeleteConfirmMenu():void		{			fileList.enabled = false;			fileName.visible = false;			statusText.text = "Confirm delete?";			_setOptionsMenu(DELETE, [DELETE_YES, DELETE_NO], [ActionButtonIcons.DELETE, ActionButtonIcons.CANCEL]);			redraw();		}				private function _clearOptionsMenu():void		{			// clear existing children			while (_optionsMenu.numChildren > 0)			{				var opt:Sprite = _optionsMenu.getChildAt(0) as Sprite;				opt.removeEventListener(MouseEvent.CLICK, this._onOptionClick);				_optionsMenu.removeChild(opt);			}		}				private function _requireSelection(proceed:Function):void		{			if (fileList.selectedIndex > -1)			{				proceed();			}			else			{				errorText.text = "Please select a file.";			}		}				private function _requireFilename(proceed:Function):void		{			if (fileName.text != "")			{				proceed();			}			else			{				errorText.text = "Please enter a file name.";			}		}				private function _setOptionsMenu(menu:String, opts:Array, icons:Array):void		{			_clearOptionsMenu();			_optionsMenu.y = (fileName.visible ? fileName.y+fileName.height : statusText.y+statusText.height) + 10;						var yinc:int = 0;						// add new option buttons			for (var j:int=0; j < opts.length; j++)			{				var opt:LabeledActionButton = new LabeledActionButton();				opt.addEventListener(MouseEvent.CLICK, this._onOptionClick);				opt.value = menu;				opt.label = opts[j];				opt.icon = icons[j];				opt.y = yinc;				_optionsMenu.addChild(opt);				yinc += opt.height;			}		}				private function _handleOptionSelect(menu:String, opt:String):void		{			// clear any existing error			errorText.text = "";						if (menu == MAIN)			{				switch (opt)				{					case MAIN_LOAD: _requireSelection(loadData); break;					case MAIN_NEW: _setNewFileMenu(); break;					case MAIN_COPY: _requireSelection(_setCopyFileMenu); break;					case MAIN_DELETE: _requireSelection(_setDeleteConfirmMenu); break;					case MAIN_CANCEL: close(); break;				}			}			else if (menu == NEW)			{				switch (opt)				{					case NEW_CREATE: _requireFilename(createNewFile); break;					case NEW_CANCEL: setMainMenu(); break;				}			}			else if (menu == COPY)			{				switch (opt)				{					case COPY_CREATE: _requireFilename(copyFile); break;					case COPY_CANCEL: setMainMenu(); break;				}			}			else if (menu == DELETE)			{				switch (opt)				{					case DELETE_YES: deleteFile(); break;					case DELETE_NO: setMainMenu(); break;				}			}		}			// --------------------------------------------------	//  Event handlers	// --------------------------------------------------			private function _onOptionClick(evt:MouseEvent):void		{			var opt:LabeledActionButton = evt.currentTarget as LabeledActionButton;			_handleOptionSelect(opt.value, opt.label);		}	}}