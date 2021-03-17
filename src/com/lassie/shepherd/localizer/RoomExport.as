﻿package com.lassie.shepherd.localizer{	import flash.events.Event;	import flash.net.URLLoader;	import flash.net.URLRequest;	import com.lassie.shepherd.data.game.*;	import com.lassie.shepherd.data.room.*;	import com.lassie.shepherd.data.*;	final public class RoomExport extends RoomLocalizer	{		private var _io:URLLoader;		public function RoomExport():void {			super();		}		override protected function _start():void {			exportAllRooms();		}		/**		* Called upon clicking the "export all" button.		*/		public function exportAllRooms($event:Event=null):void {			addEventListener(LocalizerSetup.SETUP_LOAD_COMPLETE, this._onExportListLoad, false, 0, true);			getRoomsList();		}			private function _onExportListLoad($event:Event):void {				removeEventListener(LocalizerSetup.SETUP_LOAD_COMPLETE, this._onExportListLoad);				addEventListener(LocalizerSetup.ITEM_EXPORT_COMPLETE, this.exportNextRoom);				addEventListener(LocalizerSetup.EXPORT_COMPLETE, this._onExportListComplete);				exportNextRoom();			}			private function _onExportListComplete($event:Event):void {				removeEventListener(LocalizerSetup.ITEM_EXPORT_COMPLETE, this.exportNextRoom);				removeEventListener(LocalizerSetup.EXPORT_COMPLETE, this._onExportListComplete);				_console = null;				dispatchEvent(new Event(Event.COMPLETE));			}		/*		* --------------------------------------------------------------------------------------------------		* --------------------------------------------------------------------------------- Export		* --------------------------------------------------------------------------------------------------		*/		/**		* Exports the new room listed in the room queue.		*/		public function exportNextRoom($event:Event=null):void {			if (_rooms.length > 0) {				exportRoom( _rooms.shift() );				_console.log('exported: '+ _filename);			} else {				_console.log("export complete.", true);				dispatchEvent(new Event(LocalizerSetup.EXPORT_COMPLETE));			}		}		/**		* Opens a room data file and exports all dialogue in language nodes.		*/		public function exportRoom( $id:String ):void {			_filename = $id;			_io = new URLLoader();			_io.addEventListener(Event.COMPLETE, this._onExportRoomLoad, false, 0, true);			_io.load(new URLRequest(FileService.FILE_SERVICE + 'rooms/'+ _filename +'.'+ FileService.EXT_ROOM));		}			/**			* Called upon loading the room to export.			*/			private function _onExportRoomLoad($event:Event):void {				_io.removeEventListener(Event.COMPLETE, this._onExportRoomLoad);				RoomDataParser.parse(RoomData.instance, JSON.parse( _io.data ));				_io = null;				_titleLinkage = RoomData.instance.titleLinkage = 0;				_actionLinkage = RoomData.instance.actLinkage = 0;				_dialogueLinkage = RoomData.instance.diaLinkage = 0;				var $xml:String = _getRoomExport();				RoomData.instance.titleLinkage = _titleLinkage;				RoomData.instance.actLinkage = _actionLinkage;				RoomData.instance.diaLinkage = _dialogueLinkage;				var $io:FileIO = new FileIO();				$io.addEventListener(Event.COMPLETE, this._onExportXMLSave);				$io.save(FileService.FILE_SERVICE, "../"+LocalizerSetup.LOCALIZATION_FOLDER, _filename + ".xml", $xml);			}			/**			* Called upon saving the room to export.			*/			private function _onExportXMLSave($event:Event):void {				$event.target.removeEventListener(Event.COMPLETE, this._onExportXMLSave);				var $io:FileIO = new FileIO();				$io.addEventListener(Event.COMPLETE, this._onExportRoomSave);				$io.save(FileService.FILE_SERVICE, "rooms", _filename + "." + FileService.EXT_ROOM, JSON.stringify(RoomData.instance));			}			/**			* Called upon saving the room to export.			*/			private function _onExportRoomSave($event:Event):void {				$event.target.removeEventListener(Event.COMPLETE, this._onExportRoomSave);				dispatchEvent(new Event(LocalizerSetup.ITEM_EXPORT_COMPLETE));			}		/**		* Compiles the export XML.		*/		private function _getRoomExport():String		{			var $xml:String = '<?xml version="1.0" encoding="UTF-8"?><room>';			var $titles:String = '';			var $actions:String = '';			var $contexts:String = '';			var $dialogue:String = '';			var $dia:DialogueData;			// loop through layers			for each (var $layer:LayerData in RoomData.instance.layers)			{				// loop through states				for each (var $state:PhaseData in $layer.phases)				{					if ($state.linkage == "") $state.linkage = (_titleLinkage++).toString();					$titles += _exportNoun( $state.title, $state.linkage );					// loop through state base actions					for each (var $action:InteractionData in $state.actions)					{						$actions += _exportAction( $action, $state.title );						// loop through dialogue						for each ($dia in $action.dialogue) {							$dialogue += _exportDialogue( $dia );						}					}					// loop through state item actions					for each (var $item:InteractionData in $state.items)					{						$contexts += _exportContext( $item, $state.title );						// loop through dialogue						for each ($dia in $item.dialogue) {							$dialogue += _exportDialogue( $dia );						}					}				}			}			// loop through trees			for each (var $tree:TreeRecord in RoomData.instance.diaTrees) {				var $puppets:Array = $tree.puppets.split(",");				$dialogue += _exportTier( $tree.root, $puppets );			}			$xml =  _exportXML($titles, $actions, $contexts, $dialogue);			return new XML($xml).toXMLString();		}		/**		* Compiles a tier of dialogue within a tree structure.		*/		private function _exportTier($tier:TierData, $puppets:Array):String		{			var $dialogue:String = '';			for each (var $topic:TopicData in $tier.topics)			{				for each (var $dia:DialogueData in $topic.action.dialogue) {					$dialogue += _exportDialogue( $dia, $puppets );				}				$dialogue += _exportTier( $topic.tier, $puppets );			}			return $dialogue;		}	}}