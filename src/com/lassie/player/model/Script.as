﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.model{	final public class Script extends DataModel	{		private var _script:XML;				public function Script($id:String):void		{			super($id);		}			//-------------------------------------------------	// Overrides	//-------------------------------------------------			override public function destroy():void {			_script = null;		}				override internal function parse($xml:XML):void {			_script = $xml;		}				override public function toString():String {			return "[Script] id: "+id;		}			//-------------------------------------------------	// Read-only properties	//-------------------------------------------------			/**		* Gets the raw script text.		*/		public function get script():XML {			return _script;		}				/**		* Gets the script text with parameterized input from an XMLList.		*/		public function getParamScript($args:XMLList):XML		{			var $params:Object = new Object();			// format all parameters as a generic object.			for each (var $value:XML in $args) {				$params[ $value.name().toString() ] = $value.toString();			}						// parse parameters using methodology protocols.			return Methodology.parseParams( _script, $params );		}	}}