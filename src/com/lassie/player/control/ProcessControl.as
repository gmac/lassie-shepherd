﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.control{	import com.lassie.player.model.Action;	import com.lassie.player.model.Dialogue;	import com.lassie.utils.XmlUtil;		final internal class ProcessControl extends ProcessCommand	{		// private		private var _action:Action;				public function ProcessControl():void		{			super();		}			//-------------------------------------------------	// Process methods	//-------------------------------------------------			override public function destroy():void {			super.destroy();			_action.destroy();			_action = null;		}				override internal function parse($scriptXml:XML):void		{			_sourceXML = $scriptXml;			_action = new Action();						// add all nested commands as children of the branch process action.			for each (var $child:XML in $scriptXml.children()) {				_action.addScript( $child );			}			// add all remaining dialouge from the parent process into the new process branch.			for each (var $dia:Dialogue in parentProcess.dialogue) {				_action.addDialogue( $dia );			}		}				override public function toString():String {			return "[ProcessControl]";		}			//-------------------------------------------------	// Control methods	//-------------------------------------------------				override protected function _run():void {			_process();			_complete();		}				//override public function stop():void {			// no stop.		//}				//override public function resume():void {			// no resume.		//}				override public function skip():void {			try {				_process().skip();			} catch ($error:Error) {				// do nothing.			}		}				private function _process():Process {			var $trunk:Boolean = XmlUtil.parseBoolean(_sourceXML.@trunk, false);			return Process.create(_action, !$trunk, XmlUtil.parseBoolean(_sourceXML.@orphan, false));		}	}}