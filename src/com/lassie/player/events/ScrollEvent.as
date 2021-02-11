﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.events{	import flash.events.Event;	import flash.geom.Rectangle;	final public class ScrollEvent extends Event	{		static public const SCROLL:String = "roomScroll";		private var _totalWidth:int=0;		private var _totalHeight:int=0;		private var _viewWidth:int=0;		private var _viewHeight:int=0;		private var _rangeX:int=0;		private var _rangeY:int=0;		private var _offsetX:int=0;		private var _offsetY:int=0;		private var _percentX:Number=0;		private var _percentY:Number=0;		private var _crop:Boolean = false;		public function ScrollEvent($roomBounds:Rectangle, $viewBounds:Rectangle, $crop:Boolean=false):void		{			super(SCROLL, false, false);			_totalWidth = $roomBounds.width;			_totalHeight = $roomBounds.height;			_viewWidth = $viewBounds.width;			_viewHeight = $viewBounds.height;			_rangeX = _totalWidth - _viewWidth;			_rangeY = _totalHeight - _viewHeight;			_offsetX = $viewBounds.x;			_offsetY = $viewBounds.y;			_percentX = _offsetX / _rangeX;			_percentY = _offsetY / _rangeY;			_crop = $crop;		}		public function get totalWidth():int {			return _totalWidth;		}		public function get totalHeight():int {			return _totalHeight;		}		public function get viewWidth():int {			return _viewWidth;		}		public function get viewHeight():int {			return _viewHeight;		}		public function get rangeX():int {			return _rangeX;		}		public function get rangeY():int {			return _rangeY;		}		public function get offsetX():int {			return _offsetX;		}		public function get offsetY():int {			return _offsetY;		}		public function get percentX():Number {			return _percentX;		}		public function get percentY():Number {			return _percentY;		}		public function get cropEnabled():Boolean {			return _crop;		}		public function get scrollRect():Rectangle {			return new Rectangle(_offsetX, _offsetY, _viewWidth, _viewHeight);		}	}}