﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.control{	import com.lassie.player.events.LibraryEvent;	import com.lassie.player.model.Room;	final internal class LibraryControl extends ProcessCommand	{		/**		* <library load="" unload=""/>		*/		public function LibraryControl():void		{			super();		}		override public function toString():String {			return "[LibraryControl]";		}	//-------------------------------------------------	// Control methods	//-------------------------------------------------		override protected function _run():void		{			// get a list of libraries to retain.			var $retain:String = _sourceXML.@retain.toString();			// unload a comma-seperated list of libraries.			if (_sourceXML.@unloadRoom != undefined)			{				var $room:Room = Targeting.getRoom( _sourceXML.@unloadRoom.toString() );				if (!!$room) {					gameLibrary.unload( _filter($room.coreLibs, $retain) );					gameLibrary.unload( _filter($room.voiceLibs, $retain) );				}			}			// unload a comma-seperated list of libraries.			if (_sourceXML.@unload != undefined) {				gameLibrary.unload( _filter(_sourceXML.@unload, $retain) );			}			// load a comma-seperated list of libraries.			if (_sourceXML.@load != undefined)			{				var $loaderName:String = gameLibrary.getUniqueLoaderName();				gameLibrary.addLoadListener($loaderName, LibraryEvent.COMPLETE, this._onLoadComplete);				gameLibrary.load($loaderName, _sourceXML.@load);			}			else			{				_complete();			}		}		/**		* Filters a source list of CSV values by excluding items from a second CSV list.		*/		private function _filter($source:String, $exclude:String):String		{			var $src:Array = $source.split(",");			var $ex:Array = $exclude.split(",");			for each (var $filter:String in $ex) {				var $index:int = $src.indexOf($filter);				if ($index > -1) $src.splice($index, 1);			}			return $src.join(",");		}		override public function stop():void {			// none.		}		override public function resume():void {			// none.		}		override public function skip():void {			//_run();		}		private function _onLoadComplete($event:LibraryEvent):void		{			gameLibrary.removeLoadListener($event.loaderName, LibraryEvent.COMPLETE, this._onLoadComplete);			_complete();		}	}}