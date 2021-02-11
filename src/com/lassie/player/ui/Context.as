﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.ui{	import com.lassie.player.core.IContext;	import com.lassie.player.system.SystemParams;	import flash.text.TextField;	import flash.utils.Timer;	import flash.events.TimerEvent;	final public class Context extends UIText implements IContext	{		/** @private instance initializer values */		static public var initFormat:String = ContextFormat.NONE;		// private constants		private const VERB:String = "#verb#";		private const NOUN:String = "#noun#";		private const ITEM:String = "#item#";		// private		private var _format:String = ContextFormat.NONE;		private var _normalColor:uint = 0x000000;		private var _highlightColor:uint = 0x000000;		private var _highlightTimer:Timer;		private var _highlighted:Boolean = false;		private var _staticVerb:String = "";		private var _verb:String = "";		private var _noun:String = "";		public function Context($textField:TextField):void		{			super($textField);			_format = Context.initFormat;			_normalColor = SystemParams.contextOffColor;			_highlightColor = SystemParams.contextOnColor;			_highlightTimer = new Timer(SystemParams.contextOnSeconds * 1000, 1);			_highlightTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this._onHighlightTimeOut, false, 0, true);		}		override public function destroy():void		{			super.destroy();			_highlightTimer.stop();			_highlightTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this._onHighlightTimeOut);			_highlightTimer = null;		}	//-------------------------------------------------	// Interface methods	//-------------------------------------------------		/**		* Specifies the text format setting of the context display.		*/		public function get format():String {			return _format;		}		public function set format($format:String):void {			switch($format) {				case ContextFormat.UPPER_CASE:				case ContextFormat.LOWER_CASE:					_format = $format;				default:					_format = ContextFormat.NONE;			}		}		/**		* Specifies the normal text color display.		*/		public function get normalColor():uint {			return _normalColor;		}		public function set normalColor($color:uint):void {			_normalColor = $color;			_highlight(_highlighted);		}		/**		* Specifies the highlight text color display.		*/		public function get highlightColor():uint {			return _highlightColor;		}		public function set highlightColor($color:uint):void {			_highlightColor = $color;			_highlight(_highlighted);		}		/**		* Specifies the active console-tooltip verb.		*/		public function get staticVerb():String {			return _staticVerb;		}		public function set staticVerb($verb:String):void {			_staticVerb = $verb;			refresh();		}		/**		* Specifies the current context verb.		*/		public function get verb():String {			return _verb;		}		/**		* Specifies the current context noun.		*/		public function get noun():String {			return _noun;		}		/**		* Executes the current contextual summary.		*/		public function execute():void {			_highlight(true);			_highlightTimer.start();		}		/**		* Refreshes the contextual display with all current settings.		*/		public function refresh():void {			setSummary(_noun, _verb);		}		/**		* Clears the contextual display of all current language.		*/		public function clear():void {			_noun = "";			_verb = "";			_staticVerb = "";			refresh();		}		/**		* Sets the noun/verb pair for the primary contextual display. Cursor tooltips will be factored.		* @param $noun The title of the object currently being examined.		* @param $verb The title of the action that will target the noun object.		* @param $item An item-specific contextual string ("Use #item# with #noun#") provided by the target object.		* The aforementioned contextual string is looked up by the target object based on the item tooltip at rollover.		*/		public function setSummary($noun:String, $verb:String="", $itemDialect:String=""):void		{			if (!_highlightTimer.running)			{				var $summary:String = "";				if (!uiCursor.hasItemTooltip)				{					// No item cursor.					if (_staticVerb != "") {						// override all verbs with console value, when active.						$verb = _verb = _staticVerb;					}					if ($noun != "" && $verb == "")					{						// has noun but no verb.						$summary = $noun;					}					else if ($noun == "" && _staticVerb != "")					{						// has console verb, but no noun.						$summary = _staticVerb;					}					else if ($noun != "" && $verb != "")					{						// has noun and verb.						$summary = gameModel.verbDialect;						$summary = $summary.split(NOUN).join($noun);						$summary = $summary.split(VERB).join($verb);					}				}				else				{					// Has item cursor.					var $itemTitle:String = uiCursor.itemTitle;					if ($noun != "" || SystemParams.inventoryTouchEnabled)					{						// has noun						$summary = ($itemDialect != "") ? $itemDialect : gameModel.itemDialect;						$summary = $summary.split(NOUN).join($noun);						$summary = $summary.split(ITEM).join($itemTitle);					}					else					{						// no noun						$summary = $itemTitle;					}				}				switch (_format) {					// set text formatting.					case ContextFormat.UPPER_CASE: $summary = $summary.toUpperCase(); break;					case ContextFormat.LOWER_CASE: $summary = $summary.toLowerCase(); break;				}				// set contextual summary.				//text = $summary;				htmlText = $summary;			}			_noun = $noun;			_verb = $verb;		}		/** @private sets the highlight color of the text field */		private function _highlight($enable:Boolean):void {			textColor = $enable ? _highlightColor : _normalColor;			_highlighted = $enable;		}	//-------------------------------------------------	// Event handlers	//-------------------------------------------------		private function _onHighlightTimeOut($event:TimerEvent):void		{			_highlight(false);			_highlightTimer.reset();			refresh();		}	}}