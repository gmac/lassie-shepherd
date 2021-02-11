/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.events
{
	import flash.events.Event;

	final public class ControllerEvent extends Event
	{
		static public const COMMAND_COMPLETE:String = "commandComplete";

		public function ControllerEvent($type:String, $bubbles:Boolean=false, $cancelable:Boolean=false):void
		{
			super($type, $bubbles, $cancelable);
		}
	}
}