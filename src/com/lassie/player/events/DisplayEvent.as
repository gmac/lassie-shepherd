/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.events
{
	import flash.events.Event;

	final public class DisplayEvent extends Event
	{
		public static const DISPLAY_READY:String = "displayReady";
		public static const ROOM_DISPLAY_READY:String = "roomDisplayReady";

		public function DisplayEvent($type:String, $bubbles:Boolean=false, $cancelable:Boolean=false):void
		{
			super($type, $bubbles, $cancelable);
		}
	}
}