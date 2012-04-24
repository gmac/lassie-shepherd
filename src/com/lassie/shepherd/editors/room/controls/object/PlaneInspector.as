﻿package com.lassie.shepherd.editors.room.controls.object{	import com.lassie.shepherd.editors.room.controls.object.InspectorPanel;	import com.lassie.shepherd.editors.room.display.HelpKeys;	import com.lassie.shepherd.ui.HelpLabel;	import com.lassie.shepherd.ui.UIComponents;	import flash.events.Event;	import fl.controls.ComboBox;		public final class PlaneInspector extends InspectorPanel	{		public var selectParallax:ComboBox;			public var stateSelectHelp:HelpLabel;		public var stateIdHelp:HelpLabel;		public var stateNumHelp:HelpLabel;		public var varsHelp:HelpLabel;		public var posXHelp:HelpLabel;		public var posYHelp:HelpLabel;		public var parallaxHelp:HelpLabel;		public var shapeHelp:HelpLabel;		public var hitXHelp:HelpLabel;		public var hitYHelp:HelpLabel;		public var hitWHelp:HelpLabel;		public var hitHHelp:HelpLabel;		public var frameHelp:HelpLabel;		public var blendHelp:HelpLabel;		public var imgXHelp:HelpLabel;		public var imgYHelp:HelpLabel;		public var imgWHelp:HelpLabel;		public var imgHHelp:HelpLabel;		public var alphaHelp:HelpLabel;			// --------------------------------------------------	//  Constructor	// --------------------------------------------------			public function PlaneInspector():void		{			super();			headerBar.title = "Plane Layer";		}			// --------------------------------------------------	//  Launch	// --------------------------------------------------			protected override function launch():void		{			var tab:int = 1;			tab = launchPhaseControls(tab);						textVars.tabIndex = tab++;			textVars.addEventListener(Event.CHANGE, this.captureVars);						UIComponents.initCheckBox(checkDefaultPhase, this.captureDefaultPhase);			UIComponents.initNumerator(numPhase, tab++, this.capturePhaseNum);			UIComponents.initNumerator(numPosX, tab++, this.capturePosX);			UIComponents.initNumerator(numPosY, tab++, this.capturePosY);			UIComponents.initSelector(selectParallax, this.captureParallax);			UIComponents.initCheckBox(checkFloat, this.captureFloat);			UIComponents.initCheckBox(checkCache, this.captureCache);			UIComponents.initCheckBox(checkMouse, this.captureMouse);			tab = launchHitControls(tab);			tab = launchImageControls(tab);						selectShape.enabled = false;			stateSelectHelp.key = HelpKeys.STATE_SELECT;			stateIdHelp.key = HelpKeys.STATE_ID;			stateNumHelp.key = HelpKeys.STATE_NUM;			varsHelp.key = HelpKeys.STATE_VARS;			posXHelp.key = HelpKeys.PLOT_X;			posYHelp.key = HelpKeys.PLOT_Y;			parallaxHelp.key = "layer_plane_parallax";			shapeHelp.key = HelpKeys.HIT_SHAPE;			hitXHelp.key = HelpKeys.HIT_X;			hitYHelp.key = HelpKeys.HIT_Y;			hitWHelp.key = HelpKeys.HIT_W;			hitHHelp.key = HelpKeys.HIT_H;			frameHelp.key = HelpKeys.IMG_FRAME;			blendHelp.key = HelpKeys.IMG_BLEND;			imgXHelp.key = HelpKeys.IMG_X;			imgYHelp.key = HelpKeys.IMG_Y;			imgWHelp.key = HelpKeys.IMG_W;			imgHHelp.key = HelpKeys.IMG_H;			alphaHelp.key = HelpKeys.IMG_ALPHA;		}				public override function populate():void		{			popPhaseControls();			textVars.text = selectedLayer.activePhaseData.vars;			numPosX.value = selectedLayer.x;			numPosY.value = selectedLayer.y;			checkFloat.selected = selectedLayer.float;			checkCache.selected = selectedLayer.cache;			checkMouse.selected = selectedLayer.mouse;			popHitControls();			popImageControls();			popPhaseOrder();			popParallax();		}				private function popParallax():void		{			// get layer's parallax value			var val:String = selectedLayer.parallax;			var select:int = 0;						// loop through combobox and find corresponding item			for (var j:int = 0; j < selectParallax.length; j++)			{				if (selectParallax.getItemAt(j).data == val)				{					select = j;					break;				}			}						// set selection index			selectParallax.selectedIndex = select;		}			// --------------------------------------------------	//  Capture methods	// --------------------------------------------------				private function captureParallax(evt:Event):void		{			selectedLayer.parallax = selectParallax.value;		}	}}