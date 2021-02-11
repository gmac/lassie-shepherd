﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.core{	import flash.events.IEventDispatcher;	import com.lassie.player.model.*;	/**	* IGameModel defines properties and methods of the LassiePlayer's MVC Model component.	*/	public interface IGameModel extends IEventDispatcher	{		function load():void;		// read-only		function get stageWidth():int;		function get stageHeight():int;		function get verbDialect():String;		function get itemDialect():String;		function get coreLibs():String;		function get voiceLibs():String;		// get/set current game states		function get currentLanguage():String;		function set currentLanguage($key:String):void;		function get currentActor():String;		function set currentActor($id:String):void;		function get currentInventory():String;		function set currentInventory($id:String):void;		function get currentResponse():String;		function set currentResponse($id:String):void;		function get currentRoom():String;		function set currentRoom($id:String):void;		function get soundfxVolume():Number;		function set soundfxVolume($vol:Number):void;		function get soundtrackVolume():Number;		function set soundtrackVolume($vol:Number):void;		function get voiceVolume():Number;		function set voiceVolume($vol:Number):void;		// get current game-state models		function get currentActorModel():Actor;		function get currentInventoryModel():InventoryCollection;		function get currentResponseModel():ActionList;		function get currentRoomModel():Room;		function get methodology():Methodology;		// model accessors		function getActor($id:String):Actor;		function hasActor($id:String):Boolean;		function getInventory($id:String):InventoryCollection;		function hasInventory($id:String):Boolean;		function getItem($id:String):InventoryItem;		function hasItem($id:String):Boolean;		function getItemCombo($item1:String, $item2:String):InventoryCombo;		function getCombo($id:String):InventoryCombo;		function hasCombo($id:String):Boolean;		function getResponse($id:String):ActionList;		function hasResponse($id:String):Boolean;		function getRoom($id:String):Room;		function hasRoom($id:String):Boolean;		function getKey($key:String):KeyStroke;		function hasKey($key:String):Boolean;	}}