﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.fileio{	import flash.filesystem.File;	import flash.filesystem.FileMode;	import flash.filesystem.FileStream;	import com.adobe.serialization.json.JSON;		final public class AIRFile extends FileIO	{		public function AIRFile($uri:String):void {			super($uri);		}				/**		* Loads object from the specified URI.		*/		override public function load():void		{			var $stream:FileStream = new FileStream();			var $file:File = File.applicationStorageDirectory;			$file = $file.resolvePath( this.uri +".txt" );						if ($file.exists) {				$stream.open($file, FileMode.READ);				this.data = JSON.decode( $stream.readUTF() );				$stream.close();				$stream = null;			} else {				this.data = new Object();			}			_onLoadComplete();		}				/**		* Saves data object to the currently assigned URI.		*/		override public function save():void		{			var $stream:FileStream = new FileStream();			var $file:File = File.applicationStorageDirectory;			$file = $file.resolvePath( this.uri +".txt" );			$stream.open($file, FileMode.WRITE);			$stream.writeUTF( JSON.encode(this.data) );			$stream.close();			$stream = null;			_onSaveComplete();		}					/**		* Clears data object from the currently assigned URI.		*/		override public function clear():void		{			var $file:File = File.applicationStorageDirectory;			$file = $file.resolvePath( this.uri +".txt" );			if ($file.exists) $file.deleteFile();			_onClearComplete();		}	}}