﻿package com.lassie.shepherd.events{	import flash.events.Event;		public final class ShepherdEvent extends Event	{		public static const LOAD_ROOM:String = "loadRoomLayout";		public static const UNLOAD_ROOM:String = "unloadRoomLayout";				public static const GAME_DATA_LOADED:String = "gameDataLoaded";		public static const GAME_DATA_SAVED:String = "gameDataSaved";		public static const GAME_DATA_LOG:String = "gameDataLog";		public static const GAME_LIST_LOAD:String = "gameListLoad";				public static const ROOM_DATA_LOADED:String = "roomDataLoaded";		public static const ROOM_DATA_SAVED:String = "roomDataSaved";		public static const ROOM_DATA_LOG:String = "roomDataLog";		public static const ROOM_DATA_CLEAR:String = "roomDataClear";		public static const ROOM_LIST_LOAD:String = "roomListLoad";						public static const OPEN_GAME_EDITOR:String = "openGameEditor";			// --------------------------------------------------	//  Constructor	// --------------------------------------------------				public function ShepherdEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false):void		{			super(type, bubbles, cancelable);		}	}}