﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.core{	import flash.events.IEventDispatcher;		/**	* IActionSelectable interface applies to all display objects that can be inspected by the action selector UI.	*/	public interface IActionSelectable extends IEventDispatcher	{		function get actionProps():Object;		function setAction($actionIndex:int):void;		function clearAction($releaseFocus:Boolean=false):void;	}}