﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.logic{	import com.lassie.player.core.LPDispatcher;	import com.lassie.player.model.Cache;	import com.lassie.player.room.GridActivity;		final internal class LogicValues extends Object	{		// private		private var _api:LPDispatcher;				/**		* Builds a new instance of game variables.		*/		public function LogicValues():void		{			super();			_api = new LPDispatcher();		}				/**		* Retrieves a variable from the game cache.		* @param fieldName The name of the field to pull from the cache.		*/		internal function getCacheValue($fieldName:String):String		{			// retrieve the game vars cache instance.			var $cache:Cache = _api.gameCache.getSessionVars();						if ($cache.hasValue($fieldName)) {				return $cache.getValue($fieldName) as String;			}			return "";		}				/**		* Specifies the Lassie Player version.		*/		public function get _lassieVersion():String {			return _api.gameSystem.lassieVersion;		}			//-------------------------------------------------	// Game properties	//-------------------------------------------------			/**		* Specifies the Id of the currently active game room.		*/		public function get _currentRoom():String {			return _api.gameModel.currentRoom;		}				/**		* Specifies the Id of the currently active actor.		*/		public function get _currentActor():String {			return _api.gameModel.currentActor;		}				/**		* Specifies the Id of the currently active inventory collection.		*/		public function get _currentInventory():String {			return _api.gameModel.currentInventory;		}				/**		* Specifies the Id of the currently active item tooltip, or blank if none.		*/		public function get _currentItemTooltip():String {			return _api.uiCursor.itemId;		}				/**		* Specifies the X-position of the current room's scroll.		*/		public function get _roomScrollX():int {			if (!!_api.gameModel.gameRoom)				return _api.gameModel.gameRoom.scroll.scrollX;			return -1;		}				/**		* Specifies the Y-position of the current room's scroll.		*/		public function get _roomScrollY():int {			if (!!_api.gameModel.gameRoom)				return _api.gameModel.gameRoom.scroll.scrollY;			return -1;		}			//-------------------------------------------------	// Grid properties	//-------------------------------------------------				/**		* Specifies the starting position Id called for the last room load operation.		*/		public function get _startPosition():String {			return GridActivity.startPosition;		}				/**		* Specifies if the active script was called by a puppet tweening to a grid node.		*/		public function get _calledByGrid():String {			return GridActivity.callingGrid.toString();		}				/**		* Specifies if the active script was called by a starting room position.		*/		public function get _calledByPosition():String {			return GridActivity.callingPosition.toString();		}				/**		* Specifies the name of the node that the tweening puppet has arrived at.		*/		public function get _gridAt():String {			return GridActivity.atNodeName;		}				/**		* Specifies the name of the node that the tweening puppet is arriving from.		*/		public function get _gridFrom():String {			return GridActivity.fromNodeName;		}				/**		* FROM: Specifies if the inbound direction of a puppet arriving at a grid point came from a general direction.		*/		public function get _gridFromAbove():String {			var $dir:int = GridActivity.inboundTurn;			return ($dir == 8 || $dir == 1 || $dir == 2).toString();		}				public function get _gridFromBelow():String {			var $dir:int = GridActivity.inboundTurn;			return ($dir == 6 || $dir == 5 || $dir == 4).toString();		}				public function get _gridFromLeft():String {			var $dir:int = GridActivity.inboundTurn;			return ($dir == 6 || $dir == 7 || $dir == 8).toString();		}				public function get _gridFromRight():String {			var $dir:int = GridActivity.inboundTurn;			return ($dir == 2 || $dir == 3 || $dir == 4).toString();		}				/**		* Specifies the inbound turn view of a puppet arriving at a grid node.		*/		public function get _gridFromView():String {			return GridActivity.inboundTurn.toString();		}					/**		* Specifies the name of the node that the tweening puppet is going to.		*/		public function get _gridTo():String {			return GridActivity.toNodeName;		}				/**		* TO: Specifies if the outbound direction of a puppet leaving a grid point is going in a general direction.		*/		public function get _gridToAbove():String {			var $dir:int = GridActivity.outboundTurn;			return ($dir == 8 || $dir == 1 || $dir == 2).toString();		}				public function get _gridToBelow():String {			var $dir:int = GridActivity.outboundTurn;			return ($dir == 6 || $dir == 5 || $dir == 4).toString();		}				public function get _gridToLeft():String {			var $dir:int = GridActivity.outboundTurn;			return ($dir == 6 || $dir == 7 || $dir == 8).toString();		}				public function get _gridToRight():String {			var $dir:int = GridActivity.outboundTurn;			return ($dir == 2 || $dir == 3 || $dir == 4).toString();		}					/**		* Specifies the outbound turn view of a puppet departing from a grid node.		*/		public function get _gridToView():String {			return GridActivity.outboundTurn.toString();		}	}}