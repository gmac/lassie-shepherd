﻿package com.lassie.shepherd.ui.buttons{	import flash.display.MovieClip;	import flash.events.MouseEvent;		internal class ButtonClip extends MovieClip	{		private var _pressed:Boolean = false;				public function ButtonClip():void		{			super();			stop();						tabEnabled = false;						addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);			addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);		}			// --------------------------------------------------	//  Event handlers	// --------------------------------------------------			private function handleMouseOver(evt:MouseEvent):void		{			if (_pressed)			{				gotoAndStop(3);			}			else			{				gotoAndStop(2);			}			onMouseOver();		}				private function handleMouseOut(evt:MouseEvent):void		{			gotoAndStop(1);			onMouseOut();		}				private function handleMouseDown(evt:MouseEvent):void		{			_pressed = true;			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);			gotoAndStop(3);			onMousePress();		}				private function handleMouseUp(evt:MouseEvent):void		{			_pressed = false;			stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);						if (hitTestPoint(stage.mouseX, stage.mouseY, true))			{				gotoAndStop(2);				onMouseRelease();			}		}			// --------------------------------------------------	//  Mouse responders	// --------------------------------------------------				protected function onMouseOver():void		{			// override in subclass		}				protected function onMouseOut():void		{			// override in subclass		}				protected function onMousePress():void		{			// override in subclass		}				protected function onMouseRelease():void		{			// override in subclass		}	}}