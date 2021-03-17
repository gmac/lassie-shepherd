﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.ui{	import flash.display.Stage;	import flash.events.EventDispatcher;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import com.lassie.player.core.LPDispatcher;	import com.lassie.player.core.IKeyboardInput;	final public class KeyboardInput extends LPDispatcher implements IKeyboardInput	{	//-------------------------------------------------	// Static configuration	//-------------------------------------------------		static private var _keysByCode:Array;		static private var _keysByValue:Object;		/**		* Initializes the key code/value pair lookup tables.		*/		static public function _initKeys():void		{			// build key code/value pair relationship tables.			_keysByCode = _getKeyCodeTable();			_keysByValue = new Object();			for (var $j:int = 0; $j < _keysByCode.length; $j++) {				if ( _keysByCode[$j] is String ) _keysByValue[ "_"+_keysByCode[$j] ] = $j;			}		}		/**		* Tests if the specified key value exists within the table.		*/		static public function hasKeyValue($value:String):Boolean {			if (!_keysByValue) _initKeys();			return _keysByValue.hasOwnProperty( "_"+$value );		}		/**		* Tests if the specified key code exists within the index.		*/		static public function hasKeyCode($code:uint):Boolean {			if (!_keysByCode) _initKeys();			return (_keysByCode[ $code ] is String);		}		/**		* Gets a key code based on its associated value.		*/		static public function getKeyCode($value:String):uint {			if (!_keysByValue) _initKeys();			if (hasKeyValue($value)) return _keysByValue[ "_"+$value ];			return 0;		}		/**		* Gets a key value based on its associated code.		*/		static public function getKeyValue($code:uint):String {			if (!_keysByCode) _initKeys();			if (hasKeyCode($code)) return _keysByCode[ $code ];			return "";		}	//-------------------------------------------------	// Instance configuration	//-------------------------------------------------		// private		private var _stage:Stage;		private var _scripts:Object;		private var _enabled:Boolean = true;		private var _enabledStatus:Object;		public function KeyboardInput($stage:Stage):void		{			super();			// configure stage references			_stage = $stage;			_stage.addEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDown, false, 0, true);			_stage.focus = _stage;			// configure reference tables			_scripts = {};			_enabledStatus = {system:true, game:true};		}		/**		* Destroys the object.		*/		public function destroy():void		{			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDown);			_stage = null;			for (var $j:String in _scripts) {				delete _scripts[$j];			}			_scripts = null;		}		/**		* Specifies if the keyboard component as a whole is enabled within the engine.		* This value may be set by the developer though the XML API.		* However, this value may be overridden by the engine's internal "systemEnabled" toggle.		*/		public function get enabled():Boolean {			return _enabledStatus['game'];		}		public function set enabled($enable:Boolean):void {			_enabledStatus['game'] = $enable;			_updateEnabledStatus();		}		/**		* Specifies if the keyboard component as a whole is enabled within the engine.		* This value is used as the master system toggle (only used by the engine controls).		* This value will override the developer-controlled keyboard enabled setting.		*/		public function get systemEnabled():Boolean {			return _enabledStatus['system'];		}		public function set systemEnabled($enable:Boolean):void {			_enabledStatus['system'] = $enable;			_updateEnabledStatus();		}		/**		* Sets enabled status for a specific system.		* Multiple enabled keys are used by various systems that disable keyboard status.		*/		public function setEnabledStatus($key:String, $enabled:Boolean):void {			_enabledStatus[$key] = $enabled;			_updateEnabledStatus();		}		/**		* Updates enabled status based on the table of enabled-status settings.		* Various systems within the engine may assign their own enabled status.		*/		private function _updateEnabledStatus():void {			_enabled = true;			for each (var i:Boolean in _enabledStatus) {				if (!i) {					_enabled = false;					break;				}			}		}		/**		* Adds a script into the keyboard registry.		*/		public function addKeyScript($keyValue:String, $script:XML, $branch:Boolean=false):void {			_scripts[$keyValue] = new KeyScript($script, $branch);		}		/**		* Removes a script from the keyboard registry.		*/		public function removeKeyScript($keyValue:String):void {			if (hasKeyScript($keyValue)) delete _scripts[$keyValue];		}		/**		* Specifies if a script for the specified key exists within the registry.		*/		public function hasKeyScript($keyValue:String):Boolean {			return _scripts.hasOwnProperty($keyValue);		}		/**		* Specifies if a script for the specified key exists within the registry.		*/		public function getKeyScript($keyValue:String):KeyScript {			if (hasKeyScript($keyValue)) return _scripts[$keyValue] as KeyScript;			return null;		}		/**		* Specifies if the key is enabled within the registry.		*/		public function getKeyEnabled($keyValue:String):Boolean {			var $script:KeyScript = getKeyScript( $keyValue );			if (!!$script) return $script.enabled;			return false;		}		/**		* Registers a keycode with the list of disabled keys.		*/		public function setKeyEnabled($keyValue:String, $enable:Boolean):void		{			if ($keyValue == "*")			{				// set the enabled status of all registered scripts.				for (var $key:String in _scripts) {					KeyScript(_scripts[$key]).enabled = $enable;				}			}			else			{				// set the enabled status of a single script.				var $script:KeyScript = getKeyScript($keyValue);				if (!!$script) $script.enabled = $enable;			}		}	//-------------------------------------------------	// Event handlers	//-------------------------------------------------		private function _onKeyDown($event:KeyboardEvent):void		{			trace("keydown", _enabled, KeyboardInput.hasKeyCode($event.keyCode), $event.keyCode);			// block full process if engine has disabled the keyboard component.			if (_enabled) {				// test if the keyCode has a value within the table.				if (KeyboardInput.hasKeyCode($event.keyCode))				{					// pull keyCode's identifier.					var $keyId:String = KeyboardInput.getKeyValue($event.keyCode);					if (hasKeyScript($keyId)) {						// send script to controller for processing.						var $script:KeyScript = getKeyScript( $keyId );						if (!!$script && $script.enabled) gameController.processXML( $script.script, $script.processAsBranch );					}				}			}		}	//-------------------------------------------------	// Utility methods	//-------------------------------------------------		static private function _getKeyCodeTable():Array		{			var $values:Array = new Array();			$values[Keyboard.ENTER] = "enter";			$values[Keyboard.SPACE] = "space";			$values[Keyboard.SHIFT] = "shift";			$values[Keyboard.UP] = "up";			$values[Keyboard.DOWN] = "down";			$values[Keyboard.LEFT] = "left";			$values[Keyboard.RIGHT] = "right";			$values[Keyboard.F1] = "f1";			$values[Keyboard.F2] = "f2";			$values[Keyboard.F3] = "f3";			$values[Keyboard.F4] = "f4";			$values[Keyboard.F5] = "f5";			$values[Keyboard.F6] = "f6";			$values[Keyboard.F7] = "f7";			$values[Keyboard.F8] = "f8";			$values[Keyboard.F9] = "f9";			$values[Keyboard.F10] = "f10";			$values[48] = "0";			$values[49] = "1";			$values[50] = "2";			$values[51] = "3";			$values[52] = "4";			$values[53] = "5";			$values[54] = "6";			$values[55] = "7";			$values[56] = "8";			$values[57] = "9";			$values[65] = "a";			$values[66] = "b";			$values[67] = "c";			$values[68] = "d";			$values[69] = "e";			$values[70] = "f";			$values[71] = "g";			$values[72] = "h";			$values[73] = "i";			$values[74] = "j";			$values[75] = "k";			$values[76] = "l";			$values[77] = "m";			$values[78] = "n";			$values[79] = "o";			$values[80] = "p";			$values[81] = "q";			$values[82] = "r";			$values[83] = "s";			$values[84] = "t";			$values[85] = "u";			$values[86] = "v";			$values[87] = "w";			$values[88] = "x";			$values[89] = "y";			$values[90] = "z";			return $values;		}	}}/*** Wrapper object for individual key actions.*/final internal class KeyScript{	public var enabled:Boolean = true;	private var _branch:Boolean = false;	private var _script:XML;	public function KeyScript($script:XML, $branch:Boolean=false):void {		_script = $script;		_branch = $branch;	}	/**	* Specifies the action's XML script.	*/	public function get script():XML {		return _script	}	/**	* Specifies if the action should run as a branch process.	*/	public function get processAsBranch():Boolean {		return _branch;	}}