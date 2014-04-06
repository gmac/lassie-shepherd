﻿/*** Lassie Engine* @author Greg MacWilliam.*/package com.lassie.menu.views{	import com.lassie.menu.views.MenuView;	import com.lassie.menu.controls.HeaderControl;	import com.lassie.menu.controls.SliderControl;	import com.lassie.menu.controls.ToggleControl;	import com.lassie.menu.controls.PickerControl;	import com.lassie.menu.controls.ButtonControl;	import com.lassie.external.LPFullScreenMode;	import flash.display.DisplayObject;	import flash.display.StageQuality;	import flash.events.MouseEvent;	import flash.events.Event;		/**	* Lassie Player game menu; options panel controller.	*/	public class OptionsView extends PanelView	{		// stage instances.		public var uiOptionsHeader:HeaderControl;		public var uiMusicVolume:SliderControl;		public var uiSoundFxVolume:SliderControl;		public var uiVoiceVolume:SliderControl;		public var uiSubtitleSpeed:SliderControl;		public var uiFullScreenMode:PickerControl;		public var uiGraphicsQuality:PickerControl;		public var uiSubtitleLanguage:PickerControl;		public var uiSubtitleEnabled:ToggleControl;		public var uiVoiceEnabled:ToggleControl;		public var uiOptionsDone:ButtonControl;				private var _controls:Array;				public function OptionsView():void {			super();						// add full screen display options.			uiFullScreenMode.addOption("OFF", LPFullScreenMode.OFF);			uiFullScreenMode.addOption("CENTER", LPFullScreenMode.CENTER);			uiFullScreenMode.addOption("FULL", LPFullScreenMode.FULL);						// add graphics quality options			uiGraphicsQuality.addOption("HIGH", StageQuality.BEST);			uiGraphicsQuality.addOption("FAST", StageQuality.MEDIUM);						// create an array with the controls' row order.			_controls = new Array();			_controls.push(uiMusicVolume);			_controls.push(uiSoundFxVolume);			_controls.push(uiVoiceVolume);			_controls.push(uiSubtitleSpeed);			_controls.push(uiVoiceEnabled);			_controls.push(uiSubtitleEnabled);			_controls.push(uiSubtitleLanguage);			_controls.push(uiFullScreenMode);			_controls.push(uiGraphicsQuality);		}				/**		* Configures event listeners on all UI controls.		*/		override protected function _enableControls($enable:Boolean):void		{			if (!!lassiePlayer) {				if ($enable) {					uiMusicVolume.addEventListener(Event.CHANGE, this._onSetSoundtrackVolume, false, 0, true);					uiSoundFxVolume.addEventListener(Event.CHANGE, this._onSetSoundFxVolume, false, 0, true);					uiVoiceVolume.addEventListener(Event.CHANGE, this._onSetVoiceVolume, false, 0, true);					uiSubtitleSpeed.addEventListener(Event.CHANGE, this._onSetSubtitleSpeed, false, 0, true);					uiFullScreenMode.addEventListener(Event.CHANGE, this._onSetFullScreen, false, 0, true);					uiGraphicsQuality.addEventListener(Event.CHANGE, this._onSetGraphicsQuality, false, 0, true);					uiVoiceEnabled.addEventListener(Event.CHANGE, this._onSetVoiceEnabled, false, 0, true);					uiSubtitleEnabled.addEventListener(Event.CHANGE, this._onSetSubtitleEnabled, false, 0, true);					uiSubtitleLanguage.addEventListener(Event.CHANGE, this._onSetSubtitleLanguage, false, 0, true);					uiOptionsDone.addEventListener(MouseEvent.CLICK, this._onDone, false, 0, true);				}				else {					uiMusicVolume.removeEventListener(Event.CHANGE, this._onSetSoundtrackVolume);					uiSoundFxVolume.removeEventListener(Event.CHANGE, this._onSetSoundFxVolume);					uiVoiceVolume.removeEventListener(Event.CHANGE, this._onSetVoiceVolume);					uiSubtitleSpeed.removeEventListener(Event.CHANGE, this._onSetSubtitleSpeed);					uiFullScreenMode.removeEventListener(Event.CHANGE, this._onSetFullScreen);					uiGraphicsQuality.removeEventListener(Event.CHANGE, this._onSetGraphicsQuality);					uiVoiceEnabled.removeEventListener(Event.CHANGE, this._onSetVoiceEnabled);					uiSubtitleEnabled.removeEventListener(Event.CHANGE, this._onSetSubtitleEnabled);					uiSubtitleLanguage.removeEventListener(Event.CHANGE, this._onSetSubtitleLanguage);					uiOptionsDone.removeEventListener(MouseEvent.CLICK, this._onDone);				}			}		}				/**		* Populates all control label texts.		*/		override protected function _setLabels():void		{			uiOptionsHeader.label = menuFormat.optionsHeader;			uiOptionsDone.label = menuFormat.doneButton;			uiMusicVolume.label = menuFormat.musicVolumeControl;			uiSoundFxVolume.label = menuFormat.fxVolumeControl;			uiVoiceVolume.label = menuFormat.voiceVolumeControl;			uiSubtitleSpeed.label = menuFormat.subtitleSpeedControl;			uiFullScreenMode.label = menuFormat.fullscreenControl;			uiGraphicsQuality.label = menuFormat.graphicsQualityControl;			uiVoiceEnabled.label = menuFormat.voiceToggleControl;			uiSubtitleEnabled.label = menuFormat.subtitleToggleControl;			uiSubtitleLanguage.label = menuFormat.subtitleLanguageControl;			uiFullScreenMode.swapLabels([menuFormat.fullScreenOff, menuFormat.fullScreenCenter, menuFormat.fullScreenFull]);			uiGraphicsQuality.swapLabels([menuFormat.graphicsQualityHigh, menuFormat.graphicsQualityFast]);		}				/**		* Populates the view with all current Lassie Player settings.		*/		override protected function _populate():void		{			// toggle control visibility.			uiVoiceVolume.visible = uiVoiceEnabled.visible = gameMenu.voiceOption;			uiSubtitleSpeed.visible = gameMenu.subtitleSpeedOption;			uiSubtitleEnabled.visible = gameMenu.subtitleOption;			uiGraphicsQuality.visible = gameMenu.graphicsQualityOption;						// populate control values.			if (!!lassiePlayer) {			  			  var $languages = lassiePlayer.languageOptions;			  uiSubtitleLanguage.visible = $languages.length > 0;			  uiSubtitleLanguage.reset();			  			  for (var $i:int=0; $i < $languages.length; $i++) {			    var $lang:String = $languages[$i];			    uiSubtitleLanguage.addOption(menuFormat.getTitleForLanguage($lang), $lang);			  }			  				uiFullScreenMode.visible = (gameMenu.fullScreenOption && lassiePlayer.fullScreenEnabled);				uiMusicVolume.percent = lassiePlayer.soundtrackVolume;				uiSoundFxVolume.percent = lassiePlayer.soundfxVolume;				uiVoiceVolume.percent = lassiePlayer.voiceVolume;				uiSubtitleSpeed.percent = lassiePlayer.subtitleSpeed;				uiSubtitleLanguage.value = lassiePlayer.language;				uiFullScreenMode.value = lassiePlayer.fullScreenMode;				uiGraphicsQuality.value = lassiePlayer.graphicsQuality;				uiVoiceEnabled.selected = lassiePlayer.voiceEnabled;				uiSubtitleEnabled.selected = lassiePlayer.subtitleEnabled;			}						// arrange all visible controls			var $y:int = Math.round(uiOptionsHeader.y + uiOptionsHeader.height) + 15;			for (var $j:int = 0; $j < _controls.length; $j++) {				var $control:DisplayObject = _controls[$j] as DisplayObject;				if ($control.visible) {					$control.y = $y;					$y += 28;				}			}		}			//--------------------------------------------------	// Slider Handlers	//--------------------------------------------------				/** @private called upon adjusting the soundtrack volume slider. */		private function _onSetSoundtrackVolume($event:Event):void {			lassiePlayer.soundtrackVolume = uiMusicVolume.percent;		}				/** @private called upon adjusting the sound Fx volume slider. */		private function _onSetSoundFxVolume($event:Event):void {			lassiePlayer.soundfxVolume = uiSoundFxVolume.percent;		}				/** @private called upon adjusting the voice volume slider. */		private function _onSetVoiceVolume($event:Event):void {			lassiePlayer.voiceVolume = uiVoiceVolume.percent;		}				/** @private called upon adjusting the subtitle speed slider. */		private function _onSetSubtitleSpeed($event:Event):void {			lassiePlayer.subtitleSpeed = uiSubtitleSpeed.percent;		}			//--------------------------------------------------	// CheckBox Handlers	//--------------------------------------------------			/** @private called upon toggling the "full screen" selector. */		private function _onSetFullScreen($event:Event):void {			lassiePlayer.fullScreenMode = uiFullScreenMode.value;		}		/** @private called upon toggling the "graphics quality" selector. */		private function _onSetGraphicsQuality($event:Event):void {			lassiePlayer.graphicsQuality = uiGraphicsQuality.value;		}				/** @private called upon toggling the "subtitle language" checkbox. */		private function _onSetSubtitleLanguage($event:Event):void {			lassiePlayer.language = uiSubtitleLanguage.value;			menuFormat.language = uiSubtitleLanguage.value;			_setLabels();		}				/** @private called upon toggling the "voice enabled" checkbox. */		private function _onSetVoiceEnabled($event:Event):void {			lassiePlayer.voiceEnabled = uiVoiceEnabled.selected;		}				/** @private called upon toggling the "subtitle enabled" checkbox. */		private function _onSetSubtitleEnabled($event:Event):void {			lassiePlayer.subtitleEnabled = uiSubtitleEnabled.selected;		}			//--------------------------------------------------	// Button Handlers	//--------------------------------------------------			/** @private called upon click of the "done" button. */		private function _onDone($event:Event):void {			gameMenu.setView( MenuView.MAIN );		}	}}