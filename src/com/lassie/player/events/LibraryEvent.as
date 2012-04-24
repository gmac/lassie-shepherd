/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.events
{
	import flash.events.Event;

	final public class LibraryEvent extends Event
	{
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		
		private var _loaderName:String = "";
		private var _percentLoaded:Number = 0;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
	
		public function LibraryEvent($type:String, $loader:String, $perc:Number=0, $bubbles:Boolean=false, $cancelable:Boolean=false):void
		{
			super($type, $bubbles, $cancelable);
			_loaderName = $loader;
			_percentLoaded = $perc;
		}
		
		public function get loaderName():String
		{
			return _loaderName;
		}
		
		public function get percentLoaded():Number
		{
			return _percentLoaded;
		}
	}
}