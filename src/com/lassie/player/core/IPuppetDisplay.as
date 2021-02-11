﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.core{	import com.lassie.player.room.PuppetTween;	import flash.geom.Point;	/**	* IPuppetDisplay defines methods available on a room puppet layer.	*/	public interface IPuppetDisplay extends IRoomLayerDisplay	{		function callAction( $index:int=-1, $itemId:String="", $repeat:Boolean=false ):void;		function tween( $param:PuppetTween ):void;		function stopTween():void;		function resumeTween():void;		function skipTween():void;		function clearTween():void;		function moveTo( $target:Point ):void;		function setRestState( $turnView:int=-1 ):void;		function setMoveState( $turnView:int=-1 ):void;		function setSpeakState( $frame:String="", $turnView:int=-1 ):void;	}}