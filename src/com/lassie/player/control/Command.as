﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.control{	import com.lassie.player.core.LPDispatcher;	import com.lassie.player.events.ControllerEvent;	public class Command extends LPDispatcher	{		// protected		protected var _stopped:Boolean = false;		// private		private var _called:Boolean = false;		public function Command():void {			super();		}	//-------------------------------------------------	// Process methods	//-------------------------------------------------		public function destroy():void {			// override in subclass		}		internal function parse($xml:XML):void {			// override in subclass		}		override public function toString():String {			return "[Command]";		}	//-------------------------------------------------	// Call methods	//-------------------------------------------------		public final function call():void {			_called = true;			_run();		}		public final function get called():Boolean {			return _called;		}	//-------------------------------------------------	// Control methods	//-------------------------------------------------		public function stop():void {			// override in subclass		}		public function resume():void {			// override in subclass		}		public function skip():void		{			if (!called) _skipBeforeCall();			else _skipAfterCall();		}	//-------------------------------------------------	// Command methods	//-------------------------------------------------		protected function _run():void {			// override in subclass		}		protected function _skipBeforeCall():void {			// override in subclass		}		protected function _skipAfterCall():void {			// override in subclass		}		protected final function _complete():void {			dispatchEvent(new ControllerEvent(ControllerEvent.COMMAND_COMPLETE));		}	}}