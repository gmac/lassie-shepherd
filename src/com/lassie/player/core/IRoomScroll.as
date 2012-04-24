/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.core
{
	import flash.geom.Point;

	/**
	* IRoomScroll defines methods available for managing the room layout's scroll.
	*/
	public interface IRoomScroll
	{
		function get roomWidth():int;
		function get roomHeight():int;
		function get scrollRangeX():int;
		function get scrollRangeY():int;
		function get scrollX():int;
		function get scrollY():int;
		function get scrollEnabled():Boolean;
		function scrollAt($upperLeft:Point):void;
	}
}