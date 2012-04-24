﻿package com.lassie.shepherd.editors.room.layout.layering{	import flash.display.Sprite;	import com.lassie.shepherd.data.room.LayerData;	import com.lassie.shepherd.data.room.LayerTypes;	import com.lassie.shepherd.editors.room.RoomController;	import com.lassie.shepherd.editors.room.layout.layering.LayerObject;	import com.lassie.shepherd.editors.room.layout.layering.Registration;	import com.lassie.shepherd.editors.room.layout.layering.HitArea;	import com.lassie.shepherd.editors.room.layout.layering.TargetObject;		public final class HotspotLayer extends LayerObject	{	// --------------------------------------------------	//  Constructor	// --------------------------------------------------				public function HotspotLayer(dat:LayerData=null):void		{			// run super constructors			super(dat != null ? dat : new LayerData(LayerTypes.HOTSPOT));						// allow hotspot to have additional controls			_allowInteractions = true;			_allowNPC = true;						// create and add hit area			_hit = new HitArea();			addChildAt(_hit, 0);						// create and add registration point			_reg = new Registration();			addChild(_reg);						// create and display floor target point			_tar = RoomController.targets.addTarget();			_tar.setLayerTarget(this);						// update display based on phase properties			updateDisplay();		}	}}