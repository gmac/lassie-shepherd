﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.room{	import com.lassie.player.events.RoomEvent;	import com.lassie.player.events.ScrollEvent;	import flash.geom.Rectangle;	import flash.events.Event;	final public class FloatContainer extends RoomObject	{		// private		private var _layers:Array;		public function FloatContainer($parent:RoomDisplay):void		{			super($parent);			mouseEnabled = false;			// create a layers registry.			_layers = new Array();			// listen for room events.			addEventListener(RoomEvent.RESTACK_LAYERS, this._onRestackLayers);			parentRoom.background.addEventListener(ScrollEvent.SCROLL, this._onScroll, false, 0, true);		}	//-------------------------------------------------	// Overrides	//-------------------------------------------------		override public function destroy():void		{			removeEventListener(RoomEvent.RESTACK_LAYERS, this._onRestackLayers);			parentRoom.background.removeEventListener(ScrollEvent.SCROLL, this._onScroll);			// clear all layers from the display.			_removeAllChildren();			// nullify layers list			// all individual layers are destroyed by the RoomDisplay			_layers = null;			// IMPORTANT:			// run super destroyer AFTER destroying parentRoom references.			super.destroy();		}	//-------------------------------------------------	// Methods	//-------------------------------------------------		/**		* Adds a layer to the float container display.		*/		public function addLayer($layer:RoomLayerDisplay):void		{			_layers.push($layer);			addChild($layer);		}		/**		* Removes a layer from the float container display.		*/		public function removeLayer($layer:RoomLayerDisplay):void		{			if (contains($layer))			{				for (var $i:int = 0; $i < _layers.length; $i++) {					if (_layers[$i] == $layer) _layers.splice($i, 1);				}				removeChild($layer);			}		}		/**		* Stacks all layers based on float ordering.		*/		public function restack():void		{			// Create scoring variables:			// spread: increment between base layer scores			// maxFloat: running total of maximum allowed float score			var $spread:int = 1000;			var $maxFloat:int = (_layers.length * $spread);			var $prevOrder:String = _getLayerOrder();			// create containers for primary and custom stack operations.			var $primStack:Array = new Array();			var $customStack:Array = new Array();			// Sort all layers by Y position			// array is ordered from bottom to top (max-Y >> min-Y)			_layers.sort(_floatOrder);			// loop through all layers from bottom to top (lowest/front >> highest/back)			for (var $j:int=0; $j < _layers.length; $j++)			{				var $layer:RoomLayerDisplay = RoomLayerDisplay(_layers[$j]);				if ($layer.floatBehind != "")				{					// CUSTOM STACK-BEHIND					// add layer to a queue of custom stacking layers.					// custom stacks will be addressed after the basic stack has been resolved.					$customStack.push($layer);				}				else if ($layer.floatEnabled)				{					// If layer is floating:					// score layer with the maximum allowed float score, or at its native depth score.					// then, set the new maximum float score to one below this layer.					$layer.layeringScore = Math.min($maxFloat, $layer.nativeDepth * $spread);					$maxFloat = $layer.layeringScore-1;					$primStack.push($layer);				}				else				{					// If layer is NOT floating:					// score layer with its native depth score.					$layer.layeringScore = $layer.nativeDepth * $spread;					$primStack.push($layer);				}			}			// Sort layers again by their layering score,			// array is ordered from back to front (min-score >> max-score)			$primStack.sortOn("layeringScore", Array.NUMERIC);			// Merge all custom-stacking layers into the primary stack.			while ($customStack.length > 0)			{				// shift all layers from the custom queue.				var $insertLayer:RoomLayerDisplay = $customStack.shift();				var $inserted:Boolean = false;				// insert custom-stacking layers into the queue behind their "floatBehind" Id.				for (var $i:int=0; $i < $primStack.length; $i++)				{					if ($insertLayer.floatBehind == RoomLayerDisplay($primStack[$i]).id) {						$primStack.splice($i, 0, $insertLayer);						$inserted = true;						break;					}				}				// if the layer's floatBehind Id was not found,				// then pile the layer to on top of the primary stack.				if (!$inserted) $primStack.push($insertLayer);			}			// assign the primary stack back to the main layers container			_layers = $primStack;			// compare previous and current orders			// only restack if there has been a change.			if ($prevOrder != _getLayerOrder())			{				// Loop through all layers and update their display index.				for (var j:int=0; j < _layers.length-1; j++) {					setChildIndex(RoomLayerDisplay(_layers[j]), j);				}			}		}		/**		* Sorts layers into their default float order.		* - Primary ordering: by y-position (max >> min)		* - Secondary ordering: by depth (max >> min)		*/		private function _floatOrder($a:RoomLayerDisplay, $b:RoomLayerDisplay):int		{			if ($a.y > $b.y) return -1;			else if ($a.y < $b.y) return 1;			else if ($a.nativeDepth > $b.nativeDepth) return -1;			else if ($a.nativeDepth < $b.nativeDepth) return 1;			else return 0;		}		/**		* Compiles a comma-seperated list of layer IDs in their current stacking order.		*/		private function _getLayerOrder():String		{			var $order:String = "";			for (var $j:int=0; $j < _layers.length; $j++) {				$order += RoomLayerDisplay(_layers[$j]).id + ",";			}			return $order;		}	//-------------------------------------------------	// Event handlers	//-------------------------------------------------		private function _onScroll($event:ScrollEvent):void {			if ($event.cropEnabled) {				scrollRect = $event.scrollRect;			} else {				x = -$event.offsetX;				y = -$event.offsetY;			}		}		private function _onRestackLayers($event:Event):void {			$event.stopPropagation();			restack();		}	}}