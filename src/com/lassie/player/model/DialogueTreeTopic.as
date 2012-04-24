﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.model{	import com.lassie.utils.XmlUtil;		/**	* DialogueTreeTopic provides a list of dialogue items to play and scripts to call.	* In addition, a topic contains pointers as to where to go within a tree after playback.	* DialogueTreeTopic objects are built and managed by a parent DialogueTree model.	*/	final public class DialogueTreeTopic extends Action	{		// private		private var _data:TopicData;		private var _parentTree:DialogueTree;		public function DialogueTreeTopic($id:String, $tree:DialogueTree):void		{			super($id);			_parentTree = $tree;			_data = new TopicData();			cacheEnabled = true;		}			//-------------------------------------------------	// Overrides	//-------------------------------------------------				override public function destroy():void		{			super.destroy();			_data = null;			_parentTree = null;			cacheEnabled = false;		}				override public function refresh():void {			_cache = parentRoom.cache.getNamespace("trees."+ parentTree.id +"."+ id);		}				override internal function parse($xml:XML):void {			super.parse($xml);			XmlUtil.parseAttributes(_data, $xml.@*);			_loaded = true;		}				override public function toString():String {			return "[DialogueTreeTopic] id: "+ id +", title: "+ title;		}			//-------------------------------------------------	// Read-only properties	//-------------------------------------------------			/**		* Specifies the parent tree to which this topic belongs.		*/		public function get parentTree():DialogueTree {			return _parentTree;		}				/**		* Specifies the room in which this conversation's parent tree exists.		*/		public function get parentRoom():Room {			return _parentTree.parentRoom;		}		/**		* Specifies the unique address key of this topic.		*/		public function get key():String {			return _data.key;		}		/**		* Specifies if the line should remain visible after it has finished playing.		*/		public function get holdAfterPlay():Boolean {			return _data.hold;		}				/**		* Specifies a comma-seperated list of topic Ids to enable after this line is played.		*/		public function get exposeAfterPlay():String {			return _data.expose;		}				/**		* Specifies the tier to access after this line is played.		*/		public function get gotoAfterPlay():String {			return _data.go;		}			//-------------------------------------------------	// Get / set cache properties	//-------------------------------------------------				// enabled		public function get enabled():Boolean {			if (omit) return false;			return cache.pull("enabled", _data.enabled);		}		public function set enabled($enable:Boolean):void {			if (cache.push("enabled", $enable, _data.enabled, !_loaded)) update();		}				// omit		public function get omit():Boolean {			return cache.pull("omit", _data.omit);		}		public function set omit($enable:Boolean):void {			if (cache.push("omit", $enable, _data.omit, !_loaded)) update();		}	}}/*** Internal class used to store the source DialogueTreeTopic properties.*/final internal class TopicData extends Object{	public var key:String="";	public var omit:Boolean=false;	public var enabled:Boolean=true;	public var hold:Boolean = true;	public var expose:String="";	public var go:String="";		public function TopicData():void {		super();	}}