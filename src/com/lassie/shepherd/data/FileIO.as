﻿package com.lassie.shepherd.data{	import flash.events.EventDispatcher;	import flash.events.IOErrorEvent;	import flash.events.Event;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.net.URLVariables;	import flash.net.URLRequestMethod;		public class FileIO extends EventDispatcher	{		private static const OPERATION_READ:String = "read";		private static const OPERATION_WRITE:String = "write";		private static const OPERATION_DELETE:String = "delete";				// local-host property: set by root Shepherd application		// tells if SWF is running locally or not.		public static var LOCAL_HOST:Boolean = false;			// --------------------------------------------------	//  Private members	// --------------------------------------------------				public var data:String="";		private var _fileIO:URLLoader;			// --------------------------------------------------	//  Constructor	// --------------------------------------------------				public function FileIO():void		{			super();		}			// --------------------------------------------------	//  Methods	// --------------------------------------------------				public function load(url:String):void		{			// set up request's path			var vars:URLVariables = new URLVariables();			vars.nocache = Math.random();						// load data from file service			_fileIO = new URLLoader();			enableIOEvents(_fileIO, true);			//_fileIO.load(createRequest(url, vars));			_fileIO.load(new URLRequest(nocache(url)));		}				public function request(service:String, path:String, file:String=""):void		{			// set up request's path			var vars:URLVariables = new URLVariables();			vars.path = path;			vars.read = file;						// load data from file service			_fileIO = new URLLoader();			enableIOEvents(_fileIO, true);			_fileIO.load(createRequest(service, vars));		}				public function save(service:String, path:String, file:String, dat:String=""):void		{			// format data as URL variables			var vars:URLVariables = new URLVariables();			vars.path = path;			vars.write = file;			vars.data = dat;			// send data to file service			_fileIO = new URLLoader();			enableIOEvents(_fileIO, true);			_fileIO.load(createRequest(service, vars));		}				public function dump(obj:Object):void		{			//trace(JSON.encode(obj));		}		public function remove(service:String, path:String, file:String):void		{			// set up request's path			var vars:URLVariables = new URLVariables();			vars.path = path;			vars[FileIO.OPERATION_DELETE] = file;						// load data from file service			_fileIO = new URLLoader();			enableIOEvents(_fileIO, true);			_fileIO.load(createRequest(service, vars));		}				private function nocache(url:String):String		{			if (!LOCAL_HOST)			{				var now:Date = new Date();				url += "?"+ (now.getTime()).toString() + Math.random();			}			return url;		}				private function createRequest(service:String, vars:URLVariables):URLRequest		{			// key variables with security key			vars.key = "shepherd";						// create URLRequest object with specified variables			var req:URLRequest = new URLRequest(nocache(service));			req.method = URLRequestMethod.POST;			req.data = vars;			return req;		}				private function enableIOEvents(io:URLLoader, enable:Boolean=true):void		{			if (enable)			{				io.addEventListener(Event.COMPLETE, this.onComplete);				io.addEventListener(IOErrorEvent.IO_ERROR, this.onError);			}			else			{				io.removeEventListener(Event.COMPLETE, this.onComplete);				io.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);			}		}				protected function fileIOComplete():void		{			dispatchEvent(new Event(Event.COMPLETE));		}				protected function fileIOError():void		{			trace("IOErrorEvent.IO_ERROR");			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));		}			// --------------------------------------------------	//  Event handlers	// --------------------------------------------------				private function onComplete(evt:Event):void		{			// extract raw data from file			data = _fileIO.data;			enableIOEvents(_fileIO, false);			_fileIO = null;			fileIOComplete();		}				private function onError(evt:Event):void		{			enableIOEvents(_fileIO, false);			_fileIO = null;			fileIOError();		}	}}