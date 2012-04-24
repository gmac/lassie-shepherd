﻿package com.lassie.shepherd.ui{	import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.TextFieldAutoSize;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.events.TimerEvent;	import flash.utils.Timer;	import flash.geom.Point;	import flash.geom.Rectangle;	import com.lassie.shepherd.data.ApplicationData;	import com.lassie.shepherd.data.HelpData;		public class HelpLabel extends Sprite	{		private const LABEL_COLOR:uint = 0x2E579B;		private const LABEL_HOVER:uint = 0x0099FF;				public var textField:TextField;				private var _key:String = "";		private var _enabled:Boolean = false;		private var _timerRunning:Boolean = false;		private var _data:HelpData;				public function HelpLabel():void		{			super();						mouseChildren = false;			textField.autoSize = TextFieldAutoSize.LEFT;			addEventListener(MouseEvent.MOUSE_OVER, this._onMouseOver);			addEventListener(MouseEvent.MOUSE_OUT, this._onMouseOut);			addEventListener(MouseEvent.CLICK, this._onMouseClick);		}			// --------------------------------------------------	//  Public methods	// --------------------------------------------------				public function get key():String		{			return _key;		}				public function set key(val:String):void		{			var changed:Boolean = (_key != val);			_key = val;			if (changed) _update();		}			// --------------------------------------------------	//  Private methods	// --------------------------------------------------				private function _update():void		{			_data = ApplicationData.getHelpData(_key);			_enabled = (_data.help != "");					textField.text = _data.label;			graphics.clear();			graphics.beginFill(0x000000, 0);			graphics.drawRect(textField.x, textField.y, textField.width, textField.height);			graphics.endFill();		}				private function _setHelp(enable:Boolean):void		{			if (enable)			{				var rect:Rectangle = this.getRect(stage);				var over:Boolean = (rect.y > 150);				var plot:Point = new Point(rect.x+(rect.width/2), rect.y + (!over ? rect.height : 0));				HelpBalloon.setHelp(_data.help, _data.title, over);				HelpBalloon.show(stage, plot);			}			else			{				HelpBalloon.hide();			}		}				private function _highlight(enable:Boolean):void		{			var tf:TextFormat = new TextFormat();			tf.color = enable ? LABEL_HOVER : LABEL_COLOR;			textField.setTextFormat(tf);		}				private function _setTimer(enable:Boolean):void		{			var timer:Timer = _getRollTimer();						if (enable)			{				timer.reset();				timer.addEventListener(TimerEvent.TIMER_COMPLETE, this._onRollTimeout);				timer.start();			}			else			{				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this._onRollTimeout);				timer.stop();			}			_timerRunning = enable;		}			// --------------------------------------------------	//  Event handlers	// --------------------------------------------------			private function _onMouseOver(evt:Event):void		{			if (_enabled) 			{				_highlight(true);				_setTimer(true);			}		}				private function _onMouseOut(evt:Event):void		{			if (_enabled) 			{				_highlight(false);				_setHelp(false);			}						if (_timerRunning)			{				_setTimer(false);			}		}				private function _onMouseClick(evt:Event):void		{			if (_enabled) 			{				_setTimer(false);				_setHelp(true);			}		}				private function _onRollTimeout(evt:Event):void		{			_setTimer(false);			_setHelp(true);		}			// --------------------------------------------------	//  Class timer	// --------------------------------------------------			private static var _timer:Timer;		private static function _getRollTimer():Timer		{			if (_timer == null) _timer = new Timer(1000, 1);			return _timer;		}	}}