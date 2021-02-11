/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.events
{
	import flash.events.Event;

	final public class PuppetEvent extends Event
	{
		static public const TWEEN_COMPLETE:String = "puppetTweenComplete";

		public function PuppetEvent($type:String, $bubbles:Boolean=false, $cancelable:Boolean=false):void
		{
			super($type, $bubbles, $cancelable);
		}
	}
}