﻿/*** Lassie Engine Library* @author Greg MacWilliam.* @version 1.0*/package com.lassie.lib{	import flash.display.MovieClip;	import flash.media.Sound;		public interface ILibrary	{		function get movieClipContents():Array;		function get soundContents():Array;		function get xmlContents():Array;		function getMovieClip($className:String):MovieClip;		function getSound($className:String):Sound;		function getXML($id:String):XML;	}}