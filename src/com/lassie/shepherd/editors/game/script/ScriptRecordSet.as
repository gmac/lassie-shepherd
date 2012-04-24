﻿package com.lassie.shepherd.editors.game.script{	import com.lassie.shepherd.editors.game.GameRecordSet;	import com.lassie.shepherd.data.game.ScriptRecord;	import com.lassie.shepherd.data.game.GameDataParser;	import com.lassie.shepherd.data.game.Record;	import com.lassie.utils.ObjectUtil;	import flash.events.Event;		public final class ScriptRecordSet extends GameRecordSet	{		static public const GLOBAL:String = "Global Scripts";		static public const LOCAL:String = "Room Scripts";				public var type:String = "";				public function ScriptRecordSet():void		{			super();		}				public override function addRecord():void		{			fileNewRecord(new ScriptRecord("Script" + numRecords));		}				public override function copyRecord():void		{			var copy:ScriptRecord = GameDataParser.toScriptRecord(ObjectUtil.clone(selectedRecord));			copy.id += "Copy";			fileNewRecord(copy);		}				public override function get recordsMenu():Array		{			// returns an array of combobox menu items			// formatted as {label:"", data:""};						var menu:Array = new Array();						for each (var i:Record in _records)			{				var $asterisk:String = "";								if (type == LOCAL && i.id == lsRoomData.enterRoom) $asterisk = " [enter]";				else if (type == LOCAL && i.id == lsRoomData.exitRoom) $asterisk = " [exit]";								menu.push({label:i.id + $asterisk, data:i.id});			}			return menu;		}	}}