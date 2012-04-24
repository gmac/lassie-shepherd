/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.events
{
	import flash.events.Event;
	
	final public class RoomEvent extends Event
	{
		static public const RESTACK_LAYERS:String = "restackLayers";
		
		public function RoomEvent($type:String, $bubbles:Boolean=false, $cancelable:Boolean=false):void
		{
			super($type, $bubbles, $cancelable);
		}
	}
}