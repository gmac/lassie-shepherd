/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.events
{
	import flash.events.Event;

	final public class UIEvent extends Event
	{
		static public const SHOW:String = "uiShow";
		static public const HIDE:String = "uiHide";
		static public const SHOW_COMPLETE:String = "uiShowComplete";
		static public const HIDE_COMPLETE:String = "uiHideComplete";
		static public const TWEEN_COMPLETE:String = "uiTweenComplete";

		public function UIEvent($type:String, $bubbles:Boolean=false, $cancelable:Boolean=false):void
		{
			super($type, $bubbles, $cancelable);
		}
	}
}