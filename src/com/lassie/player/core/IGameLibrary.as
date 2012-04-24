/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.core
{
	import flash.events.IEventDispatcher;
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	/**
	* IGameLibrary defines properties and methods of the library manager object.
	*/
	public interface IGameLibrary extends IEventDispatcher
	{
		function getUniqueLoaderName():String;
		function load($loadName:String, $csv:String):void;
		function purgeAndLoad($loadName:String, $csv:String):void;
		function unload($csv:String):void;
		function addLoadListener($loaderName:String, $event:String, $handler:Function):void;
		function removeLoadListener($loaderName:String, $event:String, $handler:Function):void;
		function hasLibrary($libKey:String, $checkPending:Boolean=false):Boolean;
		function hasAllLibraries($csv:String):Boolean;
		function getLibrariesList():Array;
		function getMovieClipContents($libKey:String):Array;
		function getSoundContents($libKey:String):Array;
		function getXMLContents($libKey:String):Array;
		function getMovieClip($libKey:String, $class:String):MovieClip;
		function getSound($libKey:String, $class:String):Sound;
		function getXML($libKey:String, $id:String):XML;
		function getSWF($id:String):MovieClip;
		function getMovieClipByAddress($address:String):MovieClip;
		function getSoundByAddress($address:String):Sound;
		function getXMLByAddress($address:String):XML;
	}
}