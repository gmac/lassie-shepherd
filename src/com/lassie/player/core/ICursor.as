﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.core{	import flash.events.IEventDispatcher;		/**	* ICursor defines methods of the Cursor user interface.	*/	public interface ICursor extends IUILayer	{		function get hover():Boolean;		function set hover($enable:Boolean):void;		function get wait():Boolean;		function set wait($enable:Boolean):void;		function get systemWait():Boolean;		function set systemWait($enable:Boolean):void;		function get hasCustomTooltip():Boolean;		function get hasItemTooltip():Boolean;		function get itemId():String;		function get itemTitle():String;		function get visible():Boolean;		function set visible($show:Boolean):void;		function setAbsoluteHover($enable:Boolean):void;		function setTooltip($frameLabel:String=""):void;		function loadItem($itemId:String):void;		function setItemFrame($frameLabel:String):void;		function setWaitStatus($key:String, $enable:Boolean):void;		function clearItem():void;	}}