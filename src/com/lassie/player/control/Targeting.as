﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.control{	import com.lassie.player.core.LPDispatcher;	import com.lassie.player.model.Room;	import com.lassie.player.model.RoomLayer;	import com.lassie.player.model.RoomLayerState;	import com.lassie.player.model.InventoryCollection;		final public class Targeting extends LPDispatcher	{		/** @private static class stores a reference to a single instance of itself. */		static private var _instance:Targeting;				/** @private singleton instance reference */		static internal function get instance():Targeting {			if (_instance == null) _instance = new Targeting( new TargetingEnforcer() );			return _instance;		}				public function Targeting($enforcer:TargetingEnforcer):void {			super();		}				/**		* Parses a minimum number of targets from a delimited list string.		*/		static public function parseTargetList($list:String, $delimiter:String, $minFields:uint=1):Array		{			var $target:Array = $list.split($delimiter);			while ($target.length < $minFields) $target.push("");			return $target;		}				/**		* Swaps out "_current" for active actor Id.		*/		static public function getActorId($actorId:String):String {			if ($actorId == KeyValues.CURRENT) return instance.gameModel.currentActor;			return $actorId;		}				/**		* Swaps out "_current" for active room Id.		*/		static public function getRoomId($roomId:String):String {			if ($roomId == KeyValues.CURRENT) return instance.gameModel.currentRoom;			return $roomId;		}				/**		* Swaps out "_current" for active inventory Id.		*/		static public function getInventoryId($invenId:String):String {			if ($invenId == KeyValues.CURRENT) return instance.gameModel.currentInventory;			return $invenId;		}				/**		* Gets a reference to a room layer state model.		*/		static public function getInventory($invenId:String):InventoryCollection {			return instance.gameModel.getInventory( getInventoryId($invenId) );		}				/**		* Swaps out "_current" for active response Id.		*/		static public function getResponseId($responseId:String):String {			if ($responseId == KeyValues.CURRENT) return instance.gameModel.currentResponse;			return $responseId;		}				/**		* Finds a room model by target reference.		* EMPTY and CURRENT return the current room.		*/		static public function getRoom($roomId:String):Room		{			if ($roomId != "" && $roomId != KeyValues.CURRENT) {				return instance.gameModel.getRoom($roomId);			}			return instance.gameModel.currentRoomModel;		}				/**		* Gets a reference to a room layer model.		*/		static public function getLayer($layerId:String, $room:Room):RoomLayer {			if (!!$room) return $room.getLayer($layerId);			else trace("Layer "+ $layerId +" could not be found.");			return null;		}				/**		* Gets a reference to a room layer state model.		*/		static public function getLayerState($stateId:String, $roomLayer:RoomLayer):RoomLayerState {			if (!!$roomLayer) return $roomLayer.getState($stateId);			else trace("Layer state "+ $stateId +" could not be found.");			return null;		}	}}class TargetingEnforcer {}