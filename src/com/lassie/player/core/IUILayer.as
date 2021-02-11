﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.core{	import flash.events.IEventDispatcher;	import flash.display.Sprite;	/**	* IUILayer defines controls available for all layers in the user interface.	*/	public interface IUILayer extends IEventDispatcher	{		function get display():Sprite;		function get showSeconds():Number;		function set showSeconds($seconds:Number):void;		function get hideSeconds():Number;		function set hideSeconds($seconds:Number):void;		function get enabled():Boolean;		function set enabled($enable:Boolean):void;		function get tweenType():String;		function set tweenType($property:String):void;		function show($tween:Boolean=true):void;		function hide($tween:Boolean=true):void;		function toggle($tween:Boolean=true):void;	}}