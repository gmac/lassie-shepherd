﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.model{	final public class Methodology extends DataModel	{		public function Methodology():void {			super("methodology");			cacheEnabled = true;		}				/**		* Destroys the methodology table configuration.		*/		override public function destroy():void {			cacheEnabled = false;		}				/**		* Refreshes the methodology table with data from the cache.		*/		override public function refresh():void {			_cache = gameCache.getSession().getNamespace(id);			update();		}				/**		* [STATIC]: Parses parameters into an XML script.		*/		static public function parseParams($xml:XML, $params:Object):XML		{			var $script:String = $xml.toXMLString();						// parse all parameters into the script text.			for (var $var:String in $params) {				$script = $script.replace(new RegExp("@"+$var, "g"), $params[$var]);			}			// return the parsed script text as XML.			return new XML($script);		}				/**		* Adds a method to the methodology table. Method XML is formatted as:		* <methodology param1="" param2="">		*   <!-- child scripts -->		*   <cursor visible="$param1"/>		* </methodology>		*/		public function setMethod($id:String, $method:XML):void {			$method.setName("script");			cache.setValue($id, escape( $method.toXMLString() ));		}				/**		* Clears a method from the methodology table. Method XML is formatted as:		* <methodology remove="sfoo"">		*/		public function clearMethod($id:String):void {			cache.clearValue( $id );		}				/**		* Tests if a method exists within the table.		*/		public function hasMethod($id:String):Boolean {			return cache.hasValue( $id );		}				/**		* Gets a script with an XMLList of parameters parsed into the text.		*/		public function getMethod($id:String, $args:XMLList):XML		{			var $method:String = cache.getValue( $id );						if (!!$method)			{				$method = unescape($method);				var $script:XML = new XML( $method );				var $params:Object = new Object();				var $value:XML;								// copy over all default params.				for each ($value in $script.@*) {					$params[ $value.name().toString() ] = $value.toString();				}				// overwrite with all calling params.				for each ($value in $args) {					$params[ $value.name().toString() ] = $value.toString();				}								// parse all parameters into the script text.				return Methodology.parseParams($script, $params);			}			return null;		}	}}