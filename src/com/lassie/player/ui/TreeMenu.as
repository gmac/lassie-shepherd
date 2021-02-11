﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.ui{	import com.lassie.events.LassieEvent;	import com.lassie.player.model.*;	import com.lassie.player.control.CommandName;	import com.lassie.player.core.ITreeMenu;	import com.lassie.utils.DisplayUtil;	import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.text.TextField;	import flash.geom.Rectangle;	import flash.events.MouseEvent;	import flash.events.Event;	/**	* TreeMenu is an interactive list display for selection dialogue tree options.	*/	final public class TreeMenu extends UILayer implements ITreeMenu	{		/** @private */		private var _menuDisplay:TreeMenuList;		private var _scrollPrev:Sprite;		private var _scrollNext:Sprite;		private var _treeModel:DialogueTree;		private var _currentTierKey:String="";		public function TreeMenu($display:Sprite):void		{			super($display);			mouseEnabled = false;			mouseChildren = true;			addEventListener(MouseEvent.MOUSE_OVER, this._onMouseOver);			addEventListener(MouseEvent.MOUSE_OUT, this._onMouseOut);			hide(false);			_initDisplay();		}		/**		* Initializes the display's instances and mouse responsiveness.		*/		private function _initDisplay():void		{			// collect all sequential option display fields into an array.			var $optionCount:int = 0;			var $optionFields:Array = new Array();			var $option:DisplayObject = display.getChildByName(UIInstanceName.TREE_MENU_OPTION + $optionCount);			// collect all sequential fields.			while ($option is TextField)			{				$optionCount++;				$optionFields.push($option);				$option = display.getChildByName(UIInstanceName.TREE_MENU_OPTION + $optionCount);			}			// construct a menu item container			_menuDisplay = new TreeMenuList();			// if there were multiple option fields collected			if ($optionFields.length > 1)			{				var $first:TextField = $optionFields[0] as TextField;				var $second:TextField = $optionFields[1] as TextField;				_menuDisplay._$anchorAt($first.x, $first.y);				_menuDisplay.lineHeight = $second.y - $first.y;				// add all option displays to the list.				for each (var $field:TextField in $optionFields)				{					DisplayUtil.extractChild($field)					_menuDisplay._$addOptionDisplay($field);				}			}			else			{				trace("[TreeMenu] option display assets were not found.");			}			// disable mouse response on all remaining children			for (var $j:int=0; $j < display.numChildren; $j++)			{				var $child:DisplayObject = display.getChildAt($j);				if ($child.name.indexOf(UIInstanceName.TREE_MENU_SCROLL) == 0 && $child is Sprite)				{					var $key:String = $child.name.split("_").pop();					// set scoll button references					if ($key == UIInstanceName.SCROLL_PREV) _scrollPrev = Sprite($child);					else if ($key == UIInstanceName.SCROLL_NEXT) _scrollNext = Sprite($child);					else DisplayUtil.setMouseEnabled($child, false);				}				else				{					// disable mouse response on all other children.					DisplayUtil.setMouseEnabled($child, false);				}			}			// add mouse listeners to list display.			_menuDisplay.addEventListener(Event.SELECT, this._onSelectOption);			display.addChild(_menuDisplay);			// if scroll buttons were not found, fill them with placeholder displays.			if (_scrollPrev == null) _scrollPrev = new Sprite();			if (_scrollNext == null) _scrollNext = new Sprite();			_scrollPrev.addEventListener(MouseEvent.CLICK, this._onScrollPrev);			_scrollNext.addEventListener(MouseEvent.CLICK, this._onScrollNext);		}		override public function destroy():void		{			_treeModel = null;			_menuDisplay.removeEventListener(Event.SELECT, this._onSelectOption);			_scrollPrev.removeEventListener(MouseEvent.CLICK, this._onScrollPrev);			_scrollNext.removeEventListener(MouseEvent.CLICK, this._onScrollNext);			removeEventListener(MouseEvent.MOUSE_OVER, this._onMouseOver);			removeEventListener(MouseEvent.MOUSE_OUT, this._onMouseOut);			super.destroy();		}	//-------------------------------------------------	// Methods	//-------------------------------------------------		/**		* Loads a conversation tree model into the menu display.		*/		public function load($treeId:String, $startTierId:String=""):void		{			// get current room			var $room:Room = gameModel.currentRoomModel;			if ($room == null) {				trace("[TreeMenu] error loading room data.");				return;			}			// get tree data model			_treeModel = $room.getTree($treeId);			if ($room == null) {				trace("[TreeMenu] error loading tree data.");				return;			}			_enableControls(false);			populate(_treeModel.getTierKey($startTierId));			stage.dispatchEvent(new LassieEvent(LassieEvent.TREE_ENTER));		}		/**		* Populates a tier of conversation topics within the menu.		*/		public function populate($tierKey:String):void		{			if (_treeModel != null)			{				_currentTierKey = $tierKey;				_menuDisplay.reset(_treeModel.getTier(_currentTierKey));				_setScroll();				show();			}			else			{				trace("[TreeMenu] cannot populate menu without first loading a tree.");			}		}		/**		* Sets scroll arrow visibility.		*/		private function _enableControls($enable:Boolean):void {			gameRoom.mouseChildren = $enable;			uiKeyboard.systemEnabled = $enable;		}		/**		* Sets scroll arrow visibility.		*/		private function _setScroll():void		{			var $scroll:Boolean = _menuDisplay.scrollEnabled;			var $up:Boolean = _menuDisplay.prevEnabled;			var $down:Boolean = _menuDisplay.nextEnabled;			// up			_scrollPrev.visible = $scroll;			_scrollPrev.mouseEnabled = $up;			_scrollPrev.alpha = $up ? 1 : 0.5;			// down			_scrollNext.visible = $scroll;			_scrollNext.mouseEnabled = $down;			_scrollNext.alpha = $down ? 1 : 0.5;		}		/**		* Calls the action at the specified menu index.		*/		private function _callAction($topicKey:String):void		{			var $option:DialogueTreeTopic = _treeModel.getTopicByKey(_currentTierKey +"_"+ $topicKey);			var $goTo:Number = parseInt($option.gotoAfterPlay);			var $nextTier:String = _currentTierKey;			var $action:Action = $option.clone();			// 1) ENABLE / DISABLE THE SELECTED LINE			// set select's option's enabled status based on hold value.			$option.enabled = $option.holdAfterPlay;			// 2) ENABLE ALL "EXPOSE" LINE IDs			// if there are line Ids set to reveal after playback,			if ($option.exposeAfterPlay != "")			{				// create a list of all topic Ids to enable.				var $expose:Array = $option.exposeAfterPlay.split(",");				// loop through and enable each valid topic Id.				for each (var $topicId:String in $expose)				{					var $enableTopic:DialogueTreeTopic = _treeModel.getTopicById($topicId, false);					if ($enableTopic != null) $enableTopic.enabled = true;				}			}			// 3) SELECT NEXT TARGET TIER TO DISPLAY			/* Possible values:			* -2: Exit			* -1: Previous tier			* 0: No change			* 1: Next tier			* NaN: custom key.			*/			// if not exiting the tree menu,			if ($goTo != -2)			{				if (isNaN($goTo))				{					// USE CUSTOM TIER ID					$nextTier = _treeModel.getTierKey($option.gotoAfterPlay);				}				else if ($goTo == -1)				{					// GO BACK ONE STEP IN THE PATH					var $path:Array = $nextTier.split("_");					$path.pop();					$nextTier = $path.join("_");				}				else if ($goTo == 1)				{					// MOVE AHEAD ONE STEP IN THE PATH					$nextTier += ("_" + $option.key);				}				// Final validation: confirm that the next target tier key is valid.				// If next target tier is invalid, stay within the current tier.				if (!_treeModel.containsTierKey($nextTier)) $nextTier = _currentTierKey;				// apped a script to the outgoing Action to repopulate the tree menu.				$action.addScript(new XML('<'+ CommandName.TREE +' populate="'+ $nextTier +'"/>'));			}			else			{				// EXIT THE TREE MENU				// When exiting the tree, re-enable room mouse response.				_enableControls(true);				_treeModel = null;				stage.dispatchEvent(new LassieEvent(LassieEvent.TREE_EXIT));			}			// process action and hide the tree menu.			gameController.process($action);			hide();		}	//-------------------------------------------------	// Event handlers	//-------------------------------------------------		/** @private		* List option select event		*/		private function _onSelectOption($event:Event):void {			_callAction(_menuDisplay.selectedKey);		}		/** @private		* Scroll Up		*/		private function _onScrollPrev($event:MouseEvent):void {			_menuDisplay.scrollIndex -= 1;			_setScroll();		}		/** @private		* Scroll Down		*/		private function _onScrollNext($event:MouseEvent):void {			_menuDisplay.scrollIndex += 1;			_setScroll();		}		/** @private		* Generic MouseOver event		*/		private function _onMouseOver($event:MouseEvent):void {			uiCursor.hover = true;		}		/** @private		* Generic MouseOut event		*/		private function _onMouseOut($event:MouseEvent):void {			uiCursor.hover = false;		}	}}