﻿/*** Lassie Engine* @author Greg MacWilliam.*/package com.lassie.menu.views{	import com.lassie.external.ILassiePlayer;	import com.lassie.menu.LPGameMenu;	import com.lassie.menu.actions.MenuAction;	import com.lassie.menu.format.MenuFormat;	import com.lassie.menu.ui.List;	import com.lassie.menu.ui.ListItem;	import com.lassie.menu.ui.UIStyle;	import flash.display.Sprite;		/**	* ViewController is an abstract class for all view control implementations.	*/	public class PanelView extends Sprite	{		/**		* Specifies the number of saved game slots to render.		* The maximum is 25.		*/		public const SAVE_SLOTS:uint = 10;				public var hideBg:Boolean = false;		private var _enabled:Boolean = false;		private var _language:String = "";		protected var _action:MenuAction;				public function PanelView():void {			super();			mouseEnabled = false;		}				/**		* Provides a reference to the main game menu.		*/		public function get gameMenu():LPGameMenu {			return LPGameMenu.instance;		}				/**		* Provides a reference to the menu's configured formatting object.		*/		public function get menuFormat():MenuFormat {			return LPGameMenu.instance.menuFormat;		}				/**		* Provides a reference to the Lassie Player API.		*/		public function get lassiePlayer():ILassiePlayer {			return LPGameMenu.instance.lassiePlayer;		}				/**		* Specifies if the component is active.		*/		public function get enabled():Boolean {			return _enabled;		}		public function set enabled($enable:Boolean):void {			_enabled = $enable;			_enableControls($enable);						if (menuFormat.language != _language) {				// repopulate menu labels when the language changes.				_language = menuFormat.language;				_setLabels();			}						if (_enabled) _populate();		}				/**		* Assigns an action to the panel view.		*/		public function setAction($action:MenuAction):PanelView {			_action = $action;			return this;		}				/**		* Configures event listeners on all UI controls.		*/		protected function _enableControls($enable:Boolean):void {			// override in subclass.		}				/**		* Populates all control labels with the current language-specific text.		*/		protected function _setLabels():void {			// override in subclass.		}				/**		* Populates the view with all current Lassie Player settings.		*/		protected function _populate():void {			// override in subclass.		}				/**		* Populates the games list selector.		*/		protected function _populateGamesList($list:List, $select:Boolean=true):void		{			if (!!lassiePlayer) {				// adjust the list's row height to fit all items.				var $style:UIStyle = menuFormat.listStyle;				$style.cellHeight = $list.height / SAVE_SLOTS;				$list.style = $style;								// populate all saved games.				var $games:Array = lassiePlayer.savedGames;				var $limit:int = Math.min(SAVE_SLOTS, $games.length);				$list.removeAll();								for (var $i:int = 0; $i < $limit; $i++) {					$list.addItem( new ListItem($games[$i], $i) );				}								// populate current game.				if ($select) $list.selectedIndex = lassiePlayer.activeGameIndex;			}		}	}}