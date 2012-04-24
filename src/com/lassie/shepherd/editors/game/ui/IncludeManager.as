﻿package com.lassie.shepherd.editors.game.ui{	import flash.display.Sprite;	import flash.text.TextField;	import flash.events.MouseEvent;	import flash.events.Event;	import fl.controls.List;	import com.lassie.shepherd.ui.buttons.ActionButton;	import com.lassie.shepherd.ui.buttons.ActionButtonIcons;	import com.lassie.shepherd.events.UIEvent;		public final class IncludeManager extends Sprite	{		public var titleText:TextField;		public var libList:List;		public var addBttn:ActionButton;		public var removeBttn:ActionButton;				private var _value:Array = new Array();		private var _enabled:Boolean = true;				public function IncludeManager():void		{			super();						libList.allowMultipleSelection = false;			addBttn.icon = ActionButtonIcons.ADD;			addBttn.addEventListener(MouseEvent.CLICK, this.onAddLib);			removeBttn.icon = ActionButtonIcons.DELETE;			removeBttn.addEventListener(MouseEvent.CLICK, this.onRemoveLib);		}			// --------------------------------------------------	//  Public properties	// --------------------------------------------------				public function get title():String		{			return titleText.text;		}				public function set title(val:String):void		{			titleText.text = val.toUpperCase();		}				public function get value():String		{			return _value.join(",");		}				public function set value(val:String):void		{			libList.removeAll();						// if value is not blank			if (val != "")			{				// add values to list display				var $list:Array = val.split(",");				var $valid:Array = new Array();								for (var j:int = 0; j < $list.length; j++)				{					if ($list[j] != "")					{						libList.addItem({label:$list[j], value:$list[j]});						$valid.push($list[j]);					}				}				libList.selectedIndex = -1;				_value = $valid;			}			else			{				//otherwise, clear the list				_value = new Array();							}		}				public function get enabled():Boolean		{			return _enabled;		}				public function set enabled(val:Boolean):void		{			_enabled = val;			libList.enabled = addBttn.enabled = removeBttn.enabled = _enabled;		}			// --------------------------------------------------	//  Event handlers	// --------------------------------------------------				private function onAddLib(evt:MouseEvent):void		{			dispatchEvent(new UIEvent(UIEvent.ADD));		}				private function onRemoveLib(evt:MouseEvent):void		{			if (libList.selectedIndex > -1)			{				_value.splice(libList.selectedIndex, 1);				value = value;				dispatchEvent(new UIEvent(UIEvent.DELETE));			}		}	}}