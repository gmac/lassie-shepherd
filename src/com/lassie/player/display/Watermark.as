﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.display{	import flash.display.DisplayObject;	/**	* Watermark is a permanent brand of the Lassie logo in the upperleft of display.	* All visual formatting properties have been disabled to prevent external manipulation.	*/	final public class Watermark extends BaseSprite	{		public function Watermark():void {			super();			super.mouseEnabled = true;			super.mouseChildren = false;			super.alpha = 0.5;			super.x = 10;			super.y = 8;		}		final override public function set x($value:Number):void {			return;		}		final override public function set y($value:Number):void {			return;		}		final override public function set width($value:Number):void {			return;		}		final override public function set height($value:Number):void {			return;		}		final override public function set scaleX($value:Number):void {			return;		}		final override public function set scaleY($value:Number):void {			return;		}		final override public function set visible($enable:Boolean):void {			return;		}		final override public function set alpha($value:Number):void {			return;		}		final override public function set mouseEnabled($enable:Boolean):void {			return;		}		final override public function set mouseChildren($enable:Boolean):void {			return;		}		final override public function removeChild($child:DisplayObject):DisplayObject {			return null;		}		final override public function removeChildAt($index:int):DisplayObject {			return null;		}	}}