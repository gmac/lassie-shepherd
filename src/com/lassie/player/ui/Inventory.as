﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.ui{	import com.lassie.player.core.IInventory;	import com.lassie.player.system.SystemParams;	import com.lassie.player.display.BaseSprite;	import com.lassie.player.model.InventoryCollection;	import com.lassie.player.model.InventoryItem;	import com.lassie.player.events.ModelEvent;	import com.lassie.events.LassieEvent;		import com.lassie.utils.DisplayUtil;	import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.display.MovieClip;	import flash.geom.Point;	import flash.events.Event;	import flash.events.MouseEvent;		final public class Inventory extends UILayer implements IInventory	{		/**		* Inventory display modes:		* - "static": inventory is fixed on screen.		* - "dynamic": inventory opens dynamically, and closes upon click-off or mouse-out.		* - "dynamicItem": inventory opens dynamically, and closes upon click-off or mouse-out with an item cursor.		*/		private const DISPLAY_STATIC:String = "static";		private const DISPLAY_DYNAMIC:String = "dynamic";		private const DISPLAY_DYNAMIC_ITEM:String = "dynamicItem";				// private		private var _model:InventoryCollection;		private var _slots:Array;		private var _scrollPrev:Sprite;		private var _scrollNext:Sprite;		private var _scrollIndex:int = 0;		private var _scrollMax:int = 0;		private var _overScript:XML;		private var _outScript:XML;		private var _dynamicDisplay:Boolean = false;		private var _dynamicItem:Boolean = false;				public function Inventory($display:Sprite):void		{			super($display);			mouseEnabled = false;			mouseChildren = true;			addEventListener(MouseEvent.MOUSE_OVER, this._onMouseOver, false, 0, true);			addEventListener(MouseEvent.MOUSE_OUT, this._onMouseOut, false, 0, true);			gameModel.addEventListener(ModelEvent.CHANGE_INVENTORY, this._onChangeModel);						// configure initial display settings.			showSeconds = SystemParams.inventoryShowSeconds;			hideSeconds = SystemParams.inventoryHideSeconds;						var $displayMode:String = SystemParams.inventoryDisplayMode;			dynamicDisplay = ($displayMode == DISPLAY_DYNAMIC || $displayMode == DISPLAY_DYNAMIC_ITEM);			_dynamicItem = ($displayMode == DISPLAY_DYNAMIC_ITEM);						// initialize display assets.			_slots = new Array();			_initDisplay();		}				override public function destroy():void		{			super.destroy();			removeEventListener(MouseEvent.MOUSE_OVER, this._onMouseOver);			removeEventListener(MouseEvent.MOUSE_OUT, this._onMouseOut);			gameModel.removeEventListener(ModelEvent.CHANGE_INVENTORY, this._onChangeModel);			_clearModel();		}	//-------------------------------------------------	// Read-only properties / API methods	//-------------------------------------------------				private function get model():InventoryCollection {			return _model;		}				public function get numSlots():int {			return _slots.length;		}				/**		* Specifies if the inventory panel is configured to behave as a dynamically controlled display.		* When enabled, roll-off or click-off from the inventory panel will hide its display.		*/		public function get dynamicDisplay():Boolean {			return _dynamicDisplay;		}		public function set dynamicDisplay($enable:Boolean):void		{			// show/hide the inventory display.			$enable ? hide(false) : show(false);						// enable click-off behavior.			if ($enable && !_dynamicDisplay) {				//stage.addEventListener(MouseEvent.MOUSE_DOWN, this._onTestClickOff, false, 0, true);								/**				* Version 2.0: use capture phase for trapping click-off event.				*/				stage.addEventListener(MouseEvent.MOUSE_DOWN, this._onTestClickOff, true, 0, true);			} else if (!$enable && _dynamicDisplay) {				stage.removeEventListener(MouseEvent.MOUSE_DOWN, this._onTestClickOff);			}						// set overlay toggle.			_dynamicDisplay = $enable;		}				/**		* Sets an XML script to be called upon mouse over.		*/		public function setMouseOver($xml:XML):void {			_overScript = $xml;		}			/**		* Sets an XML script to be called upon mouse out.		*/		public function setMouseOut($xml:XML):void {			_outScript = $xml;		}				/**		* Scrolls the inventory to display the specified index or item Id.		* "_blank" may also be specified to page to the first blank		*/		public function scrollTo($target:String):void		{			var $items:Array = model.contents;			var $index:Number = parseInt($target);						if (!isNaN($index)) {				// a numeric page index was specified.				_scrollIndex = $index;			}			else if ($target == "_blank") {				// Scroll to the first blank slot at the end of the list.				_scrollIndex = _scrollMax = Math.floor($items.length / _slots.length);				_setDisplay(true);				return;			}			else if (model.contains($target)) {				// Scroll to the first instance of a specific item within the list.				_scrollMax = Math.floor(Math.max(0, $items.length-1) / _slots.length);				_scrollIndex = Math.floor(_scrollMax * ($items.indexOf( $target ) / _slots.length));				_setDisplay(true);				return;			}			_setDisplay(false);		}				/**		* Notifies of the display being revealed.		*/		override public function show($tween:Boolean=true):void {			super.show($tween);			stage.dispatchEvent(new Event(LassieEvent.INVENTORY_SHOW));		}				/**		* Notifies of the display being hidden.		*/		override public function hide($tween:Boolean=true):void {			super.hide($tween);			stage.dispatchEvent(new Event(LassieEvent.INVENTORY_HIDE));		}			//-------------------------------------------------	// Display methods	//-------------------------------------------------					/**		* Initializes the raw artwork of the inventory display asset.		*/		private function _initDisplay():void		{			// create a temporary array to collect slot indicies into.			var $slots:Array = new Array();						// disable mouse response on all children			for (var $j:int=0; $j < display.numChildren; $j++)			{				var $child:DisplayObject = display.getChildAt($j);								if ($child.name.indexOf(UIInstanceName.INVENTORY_SLOT) == 0 && $child is Sprite)				{					// ITEM SLOT										// get slot index and add reference to slot location.					var $index:Number = parseInt($child.name.split("_").pop());					if (!isNaN($index)) $slots[$index] = new Point($child.x, $child.y);										// disable slot placeholder display.					DisplayUtil.stopAllClips($child as Sprite);					DisplayUtil.setMouseEnabled($child, false);					$child.visible = false;				}				else if ($child.name.indexOf(UIInstanceName.INVENTORY_SCROLL) == 0 && $child is Sprite)				{					// INVENTORY SCROLLER										// identify scroll arrow's key					var $key:String = $child.name.split("_").pop();										// reference scroll arrow into appropriate role.					if ($key == UIInstanceName.SCROLL_PREV) _scrollPrev = Sprite($child);					else if ($key == UIInstanceName.SCROLL_NEXT) _scrollNext = Sprite($child);					else DisplayUtil.setMouseEnabled($child, false);				}				else				{					// disable mouse response on all other children.					DisplayUtil.setMouseEnabled($child, false);				}			}						// create a new inventory display slot for each valid slot position			for (var $k:int=0; $k < $slots.length; $k++)			{				if ($slots[$k] is Point) {					var $slot:InventorySlot = new InventorySlot();					var $point:Point = $slots[$k] as Point;					$slot.x = $point.x;					$slot.y = $point.y;					display.addChild($slot);					_slots.push($slot);				}			}						// if scroll buttons were not found, fill them with placeholder displays.			if (_scrollPrev == null) _scrollPrev = new Sprite();			if (_scrollNext == null) _scrollNext = new Sprite();						// add prev-button events			_scrollPrev.addEventListener(MouseEvent.CLICK, this._onScrollPrev, false, 0, false);			_scrollPrev.addEventListener(MouseEvent.MOUSE_OVER, this._onScrollOver, false, 0, false);			_scrollPrev.addEventListener(MouseEvent.MOUSE_OUT, this._onScrollOut, false, 0, false);			_scrollPrev.mouseChildren = false;						// add next-button events			_scrollNext.addEventListener(MouseEvent.CLICK, this._onScrollNext, false, 0, false);			_scrollNext.addEventListener(MouseEvent.MOUSE_OVER, this._onScrollOver, false, 0, false);			_scrollNext.addEventListener(MouseEvent.MOUSE_OUT, this._onScrollOut, false, 0, false);			_scrollNext.mouseChildren = false;		}				/**		* Draws the inventory display by placing a valid item into each corresponding slot.		* "Pre-indexed" status is used when setting a custom scroll configuration prior to setting the display.		*/		private function _setDisplay($preIndexed:Boolean=false):void		{			// generate a list of the collection's item models			var $items:Array = model.getItemsList();			if (!$preIndexed) {				// Restore last scroll setting.				_scrollMax = Math.floor(Math.max(0, $items.length-1) / _slots.length);				_scrollIndex = Math.min(_scrollIndex, _scrollMax);			}						var $offset:int = (_slots.length * _scrollIndex);			// loop through all inventory item slots.			for (var $j:int=0; $j < _slots.length; $j++)			{				var $item:InventoryItem = null;				var $slot:InventorySlot = _slots[$j] as InventorySlot;								if ($j + $offset < $items.length) {					// create an inventory item display for each item within range of index.					$item = InventoryItem($items[$j + $offset]);				}				// load items into display slots.				// loading null items will clear the slot display.				$slot.load($item);				$slot.slotId = ($j+$offset);			}						// enable scroll button display			_scrollPrev.visible = _scrollNext.visible = (_scrollMax > 0);			_setScrollEnabled(_scrollPrev, _scrollIndex > 0);			_setScrollEnabled(_scrollNext, _scrollIndex < _scrollMax);		}				/**		* Enables / disables a scroll arrow button.		*/		private function _setScrollEnabled($button:Sprite, $enable:Boolean):void		{			$button.mouseEnabled = $enable;			$button.visible = $enable;		}				/**		* Clears all references to any existing collection model.		*/		private function _clearModel():void		{			// clear all configuration on any existing model.			if (_model != null) {				_model.removeEventListener(ModelEvent.UPDATE_DISPLAY, this._onUpdateDisplay);				_model = null;			}		}	//-------------------------------------------------	// Event handlers	//-------------------------------------------------			/**		* Called when the active inventory collection is changed within the game model.		*/		private function _onChangeModel($event:ModelEvent):void		{			_clearModel();						// reference and moniter any activity on new current model.			_model = gameModel.currentInventoryModel;			_model.addEventListener(ModelEvent.UPDATE_DISPLAY, this._onUpdateDisplay);			_setDisplay();		}					/**		* Called when there is a change to the contents of the current inventory collection.		*/		private function _onUpdateDisplay($event:ModelEvent):void {			_setDisplay();		}				/**		* Mouse over full display area.		*/		private function _onMouseOver($event:MouseEvent):void		{			// show inventory if not already active.			if (!active && !!_overScript) gameController.processXML( _overScript, true );			if (!active && _dynamicDisplay) show();		}				/**		* Mouse out of full display area.		*/		private function _onMouseOut($event:MouseEvent):void		{			// hide inventory when mouse rolls out of the full display area.			if (!display.hitTestPoint(stage.mouseX, stage.mouseY, true)) {				if (!!_outScript) gameController.processXML( _outScript, true );								if (_dynamicDisplay) {					// Hide panel upon mouse-out in a "dynamic" display mode.					// However, this only applies if:					// - dynamicItem mode is NOT enabled,					// - OR dynamicItem mode is enabled, and there is an item tooltip active.					if (!_dynamicItem || uiCursor.hasItemTooltip) hide();				}			}		}				/**		* Mouse click on PREV button.		*/		private function _onScrollPrev($event:MouseEvent):void {			_scrollIndex = Math.max(0, _scrollIndex-1);			_setDisplay();		}				/**		* Mouse click on NEXT button.		*/		private function _onScrollNext($event:MouseEvent):void {			_scrollIndex = Math.min(_scrollIndex+1, _scrollMax);			_setDisplay();		}				/**		* Mouse over a scroll arrow.		*/		private function _onScrollOver($event:MouseEvent):void {			uiCursor.hover = true;		}				/**		* Mouse out of a scroll arrow.		*/		private function _onScrollOut($event:MouseEvent):void {			uiCursor.hover = false;		}				/**		* MOUSE_DOWN on stage: hides the inventory when mouse clicks out of bounds of its display.		*/		private function _onTestClickOff($event:MouseEvent):void {			/**			* Version 1.0: Any MOUSE_DOWN on stage that falls outside of inventory bounds hides inventory.			*/			//if (!this.hitTestPoint(stage.mouseX, stage.mouseY, true)) hide();						/**			* Version 2.0: Any mouse down that originates within the main room display hides inventory.			*/			var $target:DisplayObject = $event.target as DisplayObject;						while (!!$target.parent) {				if ($target == gameRoom) {					hide();					break;				}				else {					$target = $target.parent;				}			}		}	}}