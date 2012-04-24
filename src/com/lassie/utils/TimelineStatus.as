package com.lassie.supersheep.utils
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import com.lassie.supersheep.events.TimelineEvent;
	
	public final class TimelineStatus extends EventDispatcher
	{
		private var __parent:MovieClip;
		private var __movie:MovieClip;
		private var __prevFrame:int;
		private var __lastFrame:int;
		private var __playing:Boolean = true;
		private var __endTimeline:Boolean = false;
		private var __active:Boolean = false;
		
		public function TimelineStatus(mc:MovieClip):void
		{
			super();
			__parent = mc;
			__parent.addEventListener(Event.ADDED, this.hasChild);
		}
		
		private function hasChild(evt:Event):void
		{
			__parent.removeEventListener(Event.ADDED, this.hasChild);
			__movie = __parent.getChildAt(0);
			__prevFrame = __movie.currentFrame;
			__lastFrame = __movie.totalFrames;
			enableListener(true);
		}
		
		private function enableListener(enable:Boolean):void
		{
			if (enable && !__active)
			{
				__active = true;
				__movie.addEventListener(Event.ENTER_FRAME, this.moniter);
			}
			else if (!enable && __active)
			{
				__active = false;
				__movie.removeEventListener(Event.ENTER_FRAME, this.moniter);
			}
		}
		
		private function moniter(evt:Event):void
		{
			var current:int = __movie.currentFrame;

			if (current == 1 && __endTimeline)
			{
				// LOOP
				dispatchEvent(new TimelineEvent(TimelineEvent.LOOP, __movie));
			}
			
			__endTimeline = (current == __lastFrame);
			
			if (__playing && current == __prevFrame)
			{
				// STOP
				__playing = false;
				
				var type:String = (__endTimeline) ? TimelineEvent.FINISH : TimelineEvent.STOP;
				dispatchEvent(new TimelineEvent(type, __movie));
			}
			else if (!__playing && current != __prevFrame)
			{
				// START
				__playing = true;
				dispatchEvent(new TimelineEvent(TimelineEvent.START, __movie));
			}
			
			if (__endTimeline)
			{
				dispatchEvent(new TimelineEvent(TimelineEvent.END, __movie));
			}
			__prevFrame = current;
		}
		
		public function dispose():void
		{
			enableListener(false);
		}
	}
}