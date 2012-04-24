/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.core
{
	import flash.events.IEventDispatcher;

	/**
	* IRoomDisplay defines methods available for an interactive room.
	*/
	public interface IRoomDisplay extends IEventDispatcher
	{
		function get mouseChildren():Boolean;
		function set mouseChildren($enable:Boolean):void;
		function get scroll():IRoomScroll;
		function getLayer($id:String):IRoomLayerDisplay;
		function getPuppet($id:String):IPuppetDisplay;
	}
}