﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.model{	import flash.events.EventDispatcher;	import com.lassie.player.events.ModelEvent;	import com.lassie.player.core.LPDispatcher;	public class DataModel extends LPDispatcher	{		// language key: managed by GameModel		internal static var languageKey:String = "en";		// protected		protected var _cache:Cache;		protected var _loaded:Boolean = false;		// private		private var _id:String="";		private var _cacheEnabled:Boolean=false;		public function DataModel($id:String):void		{			super();			_id = $id;		}	//-------------------------------------------------	// Read-only properties	//-------------------------------------------------		/**		* Reference Id of data model		*/		public function get id():String {			return _id;		}		/**		* Reference to model's cache object		*/		internal function get cache():Cache {			return _cache;		}	//-------------------------------------------------	// Get / set	//-------------------------------------------------		/**		* Enable / disable data caching		*/		public function get cacheEnabled():Boolean {			return _cacheEnabled;		}		public function set cacheEnabled($enable:Boolean):void		{			if ($enable && !_cacheEnabled)			{				// enable caching				gameCache.addEventListener(ModelEvent.CACHE_REFRESH, this._onRefreshCache, false, 0, true);				refresh();			}			else if (!$enable && _cacheEnabled)			{				// disable caching				gameCache.removeEventListener(ModelEvent.CACHE_REFRESH, this._onRefreshCache);				_cache = null;			}			_cacheEnabled = $enable;		}	//-------------------------------------------------	// Model methods	//-------------------------------------------------		/**		* Destroys the data model and all its dependancies		*/		public function destroy():void {			// override in subclass.		}		/**		* Calls for an updates of display objects that are subscribed to the model		*/		public function update():void {			dispatchEvent(new ModelEvent(ModelEvent.UPDATE_DISPLAY));		}		/**		* Refershes model's cache with the newest local data		*/		public function refresh():void {			// override in subclass.			// set "_cache" object here.			update();		}		/**		* Builds model from a provided XML structure		*/		internal function parse(xml:XML):void {			_loaded = true;			// override in subclass.		}		/**		* Selects appropriate value from an XML collection of language options.		*/		protected function _selectLanguage($xml:XML):String		{			if ($xml == null) return "";			else return ($xml[DataModel.languageKey] != undefined) ? $xml[DataModel.languageKey] : $xml.children()[0];		}	//-------------------------------------------------	// Event handlers	//-------------------------------------------------		private function _onRefreshCache($event:ModelEvent):void {			refresh();		}	}}