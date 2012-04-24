﻿package com.lassie.shepherd.editors.room.controls.object{	import com.lassie.shepherd.data.game.CastRecord;	import com.lassie.shepherd.editors.room.RoomController;	import com.lassie.shepherd.editors.room.display.HelpKeys;	import com.lassie.shepherd.ui.HelpLabel;	import com.lassie.shepherd.ui.UIComponents;	import fl.controls.ComboBox;	import flash.events.Event;		public final class CharacterInspector extends InspectorPanel	{		public var selectCastPreview:ComboBox;				public var previewHelp:HelpLabel;		public var rateHelp:HelpLabel;		public var varsHelp:HelpLabel;		public var scaleHelp:HelpLabel;		public var colorHelp:HelpLabel;		public var focusHelp:HelpLabel;		public var speedHelp:HelpLabel;			// --------------------------------------------------	//  Constructor	// --------------------------------------------------			public function CharacterInspector():void		{			super();			headerBar.title = "Avatar Layer";		}			// --------------------------------------------------	//  Launch	// --------------------------------------------------				protected override function launch():void		{			previewHelp.key = "layer_avatar_preview";			rateHelp.key =  HelpKeys.RATE;			varsHelp.key = HelpKeys.STATE_VARS;			scaleHelp.key = HelpKeys.SCALE_FILTER;			colorHelp.key = HelpKeys.COLOR_FILTER;			focusHelp.key = HelpKeys.BLUR_FILTER;			speedHelp.key = HelpKeys.SPEED_FILTER;						RoomController.filterData.addEventListener(Event.REMOVED, this.handleRemoveFilter);			selectCastPreview.addEventListener(Event.CHANGE, this.handleUpdateCastPreview);			textVars.addEventListener(Event.CHANGE, this.captureVars);			numRate.addEventListener(Event.CHANGE, this.captureRate);			launchFilterControls();		}			// --------------------------------------------------	//  Populate	// --------------------------------------------------			public override function populate():void		{			numRate.value = selectedLayer.rate;			textVars.text = selectedLayer.activePhaseData.vars;			populateCastSelect();			popFilterControls();		}				private function populateCastSelect():void		{			var sel:int = -1;			var actors:Array = lsGameData.actorList;			selectCastPreview.removeAll();						if (actors.length > 0)			{				for (var j:int=0; j < actors.length; j++)				{					selectCastPreview.addItem({label:actors[j], data:actors[j]});										if (actors[j] == selectedLayer.title)					{						sel = j;					}				}								if (sel < 0)				{					selectCastPreview.selectedIndex = 0;					populateCharPreview();				}				else				{					selectCastPreview.selectedIndex = sel;				}			}		}				private function populateCharPreview():void		{			var actorList:Array = lsGameData.actors;			var actor:CastRecord = lsGameData.getRecordById(actorList, selectCastPreview.selectedLabel) as CastRecord;						if (actor != null)			{				selectedLayer.title = actor.id;				selectedLayer.asset = actor.asset;				selectedLayer.imgX = -actor.regX;				selectedLayer.imgY = -actor.regY;			}			else			{				selectedLayer.title = "";				selectedLayer.asset = "";				selectedLayer.imgX = 0;				selectedLayer.imgY = 0;			}		}			// --------------------------------------------------	//  Event handlers	// --------------------------------------------------				private function handleRemoveFilter(evt:Event):void		{			popFilterControls();		}				private function handleUpdateCastPreview(evt:Event):void		{			populateCharPreview();		}	}}