package com.lassie.shepherd.ui.tabs
{
	import flash.events.Event;
	
	public final class TabEvent extends Event
	{
		public static const SELECT:String = "selectUITab";
		
		public var collection:String;
		public var option:String;
		
		public function TabEvent(type:String, collect:String, opt:String, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, bubbles, cancelable);
			collection = collect;
			option = opt;
		}
	}
}