﻿/*** Lassie Engine* @author Greg MacWilliam.*/package com.lassie.menu.views{	import com.lassie.menu.views.MenuView;	import com.lassie.menu.controls.HeaderControl;	import com.lassie.menu.controls.ButtonControl;	import flash.text.TextField;	import flash.events.MouseEvent;	import flash.events.Event;		/**	* Lassie Player game menu; help panel controller.	*/	public class HelpView extends PanelView	{		// stage instances		public var uiHelpHeader:HeaderControl;		public var uiHelpText:TextField;		public var uiHelpDone:ButtonControl;					public function HelpView():void {			super();		}				/**		* Configures event listeners on all UI controls.		*/		override protected function _enableControls($enable:Boolean):void		{			if (!!lassiePlayer) {				if ($enable) {					uiHelpDone.addEventListener(MouseEvent.CLICK, this._onDone, false, 0, true);				}				else {					uiHelpDone.removeEventListener(MouseEvent.CLICK, this._onDone);				}			}		}				/**		* Populates all control label texts.		*/		override protected function _setLabels():void		{			uiHelpHeader.label = menuFormat.helpHeader;			uiHelpDone.label = menuFormat.doneButton;		}				/**		* Populates the view with all current Lassie Player settings.		*/		override protected function _populate():void		{			if (!!uiHelpText) uiHelpText.htmlText = gameMenu.helpText;		}			//--------------------------------------------------	// Button Handlers	//--------------------------------------------------				/** @private called upon click of the "done" button. */		private function _onDone($event:Event):void {			gameMenu.setView( MenuView.MAIN );		}	}}