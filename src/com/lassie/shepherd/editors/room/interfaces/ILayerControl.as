﻿package com.lassie.shepherd.editors.room.interfaces{	import com.lassie.shepherd.editors.room.interfaces.IControlSystem;		public interface ILayerControl extends IControlSystem	{		function addLayer(type:String):void;		function cloneLayer():void;		function removeLayer():void;		function selectLayerAt(index:int):void;		function shiftLayerTo(index:int):void;		function listLayers():void;	}}