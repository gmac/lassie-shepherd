﻿/*** Lassie Engine Library* @author Greg MacWilliam.* @version 1.0*/package com.lassie.lib{	import flash.display.MovieClip;	import flash.media.Sound;		public class Library extends MovieClip implements ILibrary	{		// public		public var validationMode:Boolean = false;				// private		private var _movieClip:Object;		private var _sound:Object;		private var _xml:Object;			// --------------------------------------------------	//  Constructor	// --------------------------------------------------		public function Library():void		{			super();			stop();			_movieClip = new Object();			_sound = new Object();			_xml = new Object();		}			// --------------------------------------------------	//  Include a library media class	// --------------------------------------------------				/**		* Adds a MovieClip class to the library.		*/		public function addMovieClip($class:Class, $id:String=""):void		{			if (validationMode && !(new $class() is MovieClip))			{				throw(new Error($class +" is not a valid MovieClip."));			}			else			{				_addClassTo(_movieClip, $class, $id);			}		}				/**		* Adds a Sound class to the library.		*/		public function addSound($class:Class, $id:String=""):void		{			if (validationMode && !(new $class() is Sound))			{				throw(new Error($class +" is not a valid Sound."));			}			else			{				_addClassTo(_sound, $class, $id);			}		}				/**		* Adds XML data to the library.		*/		public function addXML($data:XML, $id:String):void		{			if (validationMode && !($data is XML))			{				throw(new Error("XML \""+ $id +"\" is not a valid XML structure."));			}			else			{				_xml[$id] = $data;			}		}				/** @private adds a class object into the library */		private function _addClassTo($obj:Object, $class:Class, $id:String=""):void		{			if ($id != "")			{				$obj[$id] = $class;			}			else			{				var cname:String = $class.toString();				$obj[cname.substr(7, cname.length-8)] = $class;			}		}			// --------------------------------------------------	//  Get library contents (lists class names)	// --------------------------------------------------				/**		* Gets a list of all extractable MovieClips within the Library.		*/		public function get movieClipContents():Array {			return _getContentsOf(_movieClip);		}				/**		* Gets a list of all extractable Sounds within the Library.		*/		public function get soundContents():Array {			return _getContentsOf(_sound);		}				/**		* Gets a list of all extractable XML within the Library.		*/		public function get xmlContents():Array {			return _getContentsOf(_xml);		}				/** @private gets the contents listing of a library fork. */		private function _getContentsOf($obj:Object):Array		{			var list:Array = new Array();			for (var j:String in $obj) list.push(j);			list.sort();			return list;		}			// --------------------------------------------------	//  Extract library class asset	// --------------------------------------------------				/**		* Extracts a MovieClip from the Library.		*/		public function getMovieClip($id:String):MovieClip		{			try			{				var mc:Class = _movieClip[$id];				return new mc() as MovieClip;			}			catch(e:Error)			{				// do nothing			}			return null;		}				/**		* Extracts a Sound from the Library.		*/		public function getSound($id:String):Sound		{			try			{				var sound:Class = _sound[$id];				return new sound() as Sound;			}			catch(e:Error)			{				// do nothing			}			return null;		}				/**		* Extracts XML from the Library.		*/		public function getXML($id:String):XML		{			try			{				return _xml[$id];			}			catch(e:Error)			{				// do nothing			}			return null;		}	}}