﻿package com.lassie.shepherd.editors.room.controls.viewport{	import flash.events.Event;		public final class ViewportEvent extends Event	{		public static const PAN_VIEWPORT:String = "panViewport";				public var percentX:Number;		public var percentY:Number;				public function ViewportEvent(type:String, xperc:Number, yperc:Number, bubbles:Boolean=false, cancelable:Boolean=false):void		{			super(type, bubbles, cancelable);			percentX = xperc;			percentY = yperc;		}	}}