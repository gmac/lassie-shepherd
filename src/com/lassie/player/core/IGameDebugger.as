/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.core
{
	/**
	* IGameDebugger defines properties and methods of the debugger utility.
	*/
	public interface IGameDebugger
	{
		function get enabled():Boolean;
		function set enabled($enabled:Boolean):void;
		function get statsEnabled():Boolean;
		function set statsEnabled($enabled:Boolean):void;
		function echo($message:String):void;
		function show():void;
		function hide():void;
		function toggle():void;
	}
}