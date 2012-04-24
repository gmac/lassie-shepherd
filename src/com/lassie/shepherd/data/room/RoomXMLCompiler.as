﻿package com.lassie.shepherd.data.room{	import com.lassie.shepherd.data.*;	import com.lassie.shepherd.data.game.TreeRecord;	import com.lassie.shepherd.data.game.TierData;	import com.lassie.shepherd.data.game.TopicData;	import com.lassie.shepherd.data.game.TreeActionKeys;	import com.lassie.shepherd.data.game.ScriptRecord;	import flash.geom.Point;		public class RoomXMLCompiler extends XMLCompiler	{	// --------------------------------------------------	// Static interface	// --------------------------------------------------			private static var _instance:RoomXMLCompiler;				public static function parse(room:RoomData):String		{			if (_instance == null) _instance = new RoomXMLCompiler(new RoomXMLCompilerEnforcer());			return _instance.parseRoom(room);		}				public static function get transcript():String		{			if (_instance == null) _instance = new RoomXMLCompiler(new RoomXMLCompilerEnforcer());			return _instance._transcript;		}			// --------------------------------------------------	// Instance	// --------------------------------------------------				private var _bindings:Object;		private var _points:String;		private var _tierXML:Array;		private var _treePuppets:Array;		private var _statesActions:Object;				private var _curLayer:String = "";		private var _curState:String = "";		private var _curTree:String = "";		private var _curTier:String = "";				public function RoomXMLCompiler(enforcer:RoomXMLCompilerEnforcer):void		{			super();		}		override protected function reset():void		{			super.reset();			_points = "";			_bindings = new Object();		}			// --------------------------------------------------	// Grid compiler	// --------------------------------------------------				protected function parseRoom(dat:RoomData):String		{			reset();						var $voiceLibs:String = normalize(dat.voiceLibs);			_defaultVoiceLib = ($voiceLibs.indexOf("voice/") == 0) ? $voiceLibs.split(",")[0] : "";			_defaultVoiceClass = dat.id;						var j:int;			var xml:String = xmlHeader;			xml += '<room id="'+ dat.id +'" ';			xml += 'coreLibs="'+ normalize(dat.coreLibs) +'" ';			xml += 'voiceLibs="'+ $voiceLibs +'" ';			xml += 'enterScript="'+ dat.enterRoom +'" ';			xml += 'exitScript="'+ dat.exitRoom +'" ';			xml += 'grid="'+ _compileGridList(dat) +'" ';			xml += 'sound1="'+ dat.music +'" ';			xml += 'sound2="'+ dat.sound +'">\n';						// walkarea			_points = "";			xml += tab(1) + '<grids>\n';						for (j = 0; j < dat.walkareas.length; j++)			{				xml += _compileGrid(WalkareaData(dat.walkareas[j]));			}						xml += tab(1) + '</grids>\n';						// points			xml += tab(1) + '<positions>\n';			xml += _points;			xml += tab(1) + '</positions>\n';			_points = "";						// filters			xml += tab(1) + '<filters>\n';						for (j = 0; j < dat.filters.length; j++)			{				xml += _compileFilter(FilterData(dat.filters[j]));			}						xml += tab(1) + '</filters>\n';						// scripts			xml += tab(1) + '<scripts>\n';						for (j = 0; j < dat.scripts.length; j++)			{				xml += compileScript(ScriptRecord(dat.scripts[j]), 2);			}						xml += tab(1) + '</scripts>\n';						_transcript += "LAYERS\n";			// layers			xml += tab(1) + '<layers>\n';							for (j = 0; j < dat.layers.length; j++)			{				xml += _compileLayer(LayerData(dat.layers[j]), j);			}							xml += tab(1) + '</layers>\n';						_transcript += "\n\n\nTREES\n";						// trees			xml += tab(1) + '<trees>\n';							for (j = 0; j < dat.diaTrees.length; j++)			{				xml += _compileTree(TreeRecord(dat.diaTrees[j]));			}							xml += tab(1) + '</trees>\n';						xml += '</room>';						_transcript += "\n\n\n" + _dialogueCSV;			_transcript += "\n\n\n" + _dialogueAS;						var $xml:XML = new XML(xml);			XML.prettyPrinting = !_compact;			var $return:String = $xml.toXMLString();			XML.prettyPrinting = true;						return $return;		}			// --------------------------------------------------	// Grid compiler	// --------------------------------------------------				private function _compileGridList(dat:RoomData):String		{			// create containers for active grid Id's and the first grid ID.			var $grids:Array = new Array();			var $firstGrid:String = "";						// loop through all walkareas, rocording active grid ID's			for (var j:int = 0; j < dat.walkareas.length; j++)			{				var $walkarea:WalkareaData = WalkareaData(dat.walkareas[j]);				if (j == 0) $firstGrid = $walkarea.id;				if ($walkarea.active) $grids.push($walkarea.id);			}						// if there were no active grids, forcibly enable first grid.			if ($grids.length < 1) $grids.push($firstGrid);			return $grids.join(",");		}				private function _compileGrid(dat:WalkareaData, t:int=2):String		{			// clone walkarea grid			var grid:WalkareaData = GridCompiler.compile(dat);			var xml:String = tab(t) + '<grid id="'+ grid.id +'">\n';			xml += tab(t+1) + '<boxes>\n';						for (var j:int = 0; j < grid.boxes.length; j++)			{				xml += tab(t+2) + _compileBox(BoxData(grid.boxes[j]));			}						xml += tab(t+1) + '</boxes>\n';			xml += tab(t+1) + '<nodes>\n';						for (j = 0; j < grid.nodes.length; j++)			{				xml += tab(t+2) + _compileNode(NodeData(grid.nodes[j]), t+2);			}						xml += tab(t+1) + '</nodes>\n';			xml += tab(t) + '</grid>\n';			return xml;		}				private function _compileBox(dat:BoxData):String		{			var xml:String = '<box x="'+ dat.x +'" ';			xml += 'y="'+ dat.y +'" ';			xml += 'w="'+ dat.width +'" ';			xml += 'h="'+ dat.height +'" ';			xml += 'nodes="'+ dat.children.join(",") +'"/>\n';			return xml;		}				private function _compileNode(dat:NodeData, t:int=2):String		{			if (dat.name != "") {				_compilePosition(dat);			}						var xml:String = '<node id="'+ dat.id +'" ';			xml += 'x="'+ dat.x +'" ';			xml += 'y="'+ dat.y +'" ';			xml += 'join="'+ dat.neighbors.join(",") +'" ';			xml += 'trap="'+ boolean(dat.trap) +'" ';			if (dat.name != "") xml += 'name="'+ dat.name +'" ';			if (dat.scaleEnabled) xml += 'scale="'+ dat.scale +'" ';			if (dat.speedEnabled) xml += 'rate="'+ dat.speed +'" ';			if (dat.blurEnabled) xml += 'blur="'+ dat.blur +'" ';			if (dat.colorEnabled) {				xml += 'color="'+ color(dat.color) +'" ';				xml += 'tint="'+ dat.colorRatio +'"';			}			if (dat.commands != "") {				xml += '>\n';				xml += tab(t+1) + '<script>\n';				xml += tab(t+2) + unescape(dat.commands) +'\n';				xml += tab(t+1) + '</script>\n';				xml += tab(t) + '</node>\n';			}			else {				xml += '/>\n';			}			return xml;		}				private function _compilePosition(dat:NodeData, t:int=2):void		{			_points += tab(t) + '<position id="'+ dat.name +'" ';			_points += 'turn="'+ dat.turn +'" ';			_points += 'x="'+ dat.x +'" ';			_points += 'y="'+ dat.y +'" ';			if (dat.scaleEnabled) _points += 'scale="'+ dat.scale +'" ';			if (dat.speedEnabled) _points += 'rate="'+ dat.speed +'" ';			if (dat.blurEnabled) _points += 'blur="'+ dat.blur +'" ';			if (dat.colorEnabled) {				_points += 'color="'+ color(dat.color) +'" ';				_points += 'tint="'+ dat.colorRatio +'"';			}			if (dat.commands != "") {				_points += '>\n';				_points += tab(t+1) + '<script>\n';				_points += tab(t+2) + unescape(dat.commands) +'\n';				_points += tab(t+1) + '</script>\n';				_points += tab(t) + '</position>\n';			}			else {				_points += '/>\n';			}			_bindings[dat.name] = new Point(dat.x, dat.y);		}			// --------------------------------------------------	// Layer compiler	// --------------------------------------------------			private function _compileFilter(dat:FilterData, t:int=2):String		{			var xml:String = tab(t) + '<filter id="'+ dat.id +'" ';			xml += 'axis="'+ dat.axis +'" ';			xml += 'enabled="'+ boolean(dat.enabled) +'">\n';			xml += tab(t+1) + '<pole x="' + dat.x0 +'" ';			xml += 'y="'+ dat.y0 +'" ';			xml += 'scale="'+ dat.scale0 +'" ';			xml += 'rate="'+ dat.speed0 +'" ';			xml += 'blur="'+ dat.blur0 +'" ';			xml += 'color="'+ color(dat.color0) +'" ';			xml += 'tint="'+ dat.tint0 +'" />\n';			xml += tab(t+1) + '<pole x="' + dat.x1 +'" ';			xml += 'y="'+ dat.y1 +'" ';			xml += 'scale="'+ dat.scale1 +'" ';			xml += 'rate="'+ dat.speed1 +'" ';			xml += 'blur="'+ dat.blur1 +'" ';			xml += 'color="'+ color(dat.color1) +'" ';			xml += 'tint="'+ dat.tint1 +'" />\n';			xml += tab(t) + '</filter>\n';			return xml;		}	// --------------------------------------------------	// Layer compiler	// --------------------------------------------------				private function _compileLayer(dat:LayerData, index:int=0, t:int=2):String		{			// Compile all states XML			var $statesXML:String = "";			var $activeState:String = "";						// add transcript header.			_curLayer = dat.id;			_transcript += "\n"+ _textRule;			_transcript += "- Layer: "+ _curLayer +"\n";			_transcript += _textRule;						// reset state dialogue compliers			_statesActions = new Object();						for (var j:int = 0; j < dat.phases.length; j++)			{				var $phase:PhaseData = PhaseData(dat.phases[j]);				$statesXML += _compilePhase($phase, dat.type, t+2);								// tag state as active if it matches the layer default				if (dat.defaultPhase == $phase.id) $activeState = $phase.id;			}			// if no active state was matched, use first state ID as the active state.			if ($activeState == "") $activeState = PhaseData(dat.phases[0]).id;			_statesActions = null;						var xml:String = tab(t) + '<layer id="'+ dat.id +'" ';			xml += 'type="'+ _compileLayerType(dat.type) +'" ';			xml += 'asset="'+ dat.asset +'" ';			xml += 'depth="'+ index +'" ';			xml += 'visible="'+ boolean(dat.gameVis) +'" ';			xml += 'state="'+ $activeState +'">\n';						xml += tab(t+1) + '<states>\n';			xml += $statesXML;			xml += tab(t+1) + '</states>\n';			xml += tab(t) + "</layer>\n";			return xml;		}				private function _compileLayerType($type:String):String		{			if ($type == LayerTypes.HOTSPOT) return "puppet";			else if ($type == LayerTypes.CHARACTER) return "avatar";			return $type;		}				private function _compilePhase(dat:PhaseData, type:String, t:int):String		{			_curState = dat.id;			_transcript += ' '+ _textRule;			_transcript += ' State: '+ _curState +' (layer: '+ _curLayer +')\n';			_transcript += ' title: "'+ dat.title +'"\n\n';						var xml:String = tab(t) + '<state id="'+ dat.id +'" ';			xml += 'x="'+ dat.x +'" ';			xml += 'y="'+ dat.y +'" ';			xml += 'img="'+ boolean(dat.image) +'" ';			xml += 'imgX="'+ dat.imgX +'" ';			xml += 'imgY="'+ dat.imgY +'" ';			xml += 'imgW="'+ dat.imgW +'" ';			xml += 'imgH="'+ dat.imgH +'" ';			xml += 'frame="'+ dat.frame +'" ';			xml += 'blend="'+ dat.blend +'" ';			xml += 'alpha="'+ dat.opacity +'" ';			xml += 'bitmap="'+ boolean(dat.cache) +'" ';			xml += 'hit="'+ boolean(dat.hit) +'" ';			xml += 'hitX="'+ dat.hitX +'" ';			xml += 'hitY="'+ dat.hitY +'" ';			xml += 'hitW="'+ dat.hitW +'" ';			xml += 'hitH="'+ dat.hitH +'" ';			xml += 'shape="'+ dat.hitShape +'">\n';						// compile type-specific parameters			xml += tab(t+1) + '<param ';			switch (type)			{				case LayerTypes.HOTSPOT:									var $floor:Point;										// pull any binding point from the walkable grid.					if (dat.bind != "" && _bindings.hasOwnProperty(dat.bind)) {						$floor = _bindings[dat.bind] as Point;					}					else {						$floor = new Point(dat.floorX, dat.floorY);					}									xml += 'mapX="'+ $floor.x +'" ';					xml += 'mapY="'+ $floor.y +'" ';					xml += 'turnTo="'+ dat.turnTo +'" ';					xml += 'turn="'+ dat.angle +'" ';					xml += 'cursor="'+ dat.cursor +'" ';					xml += 'onclick="'+ dat.onclick +'" ';					xml += 'prefix="'+ dat.prefix +'" ';					xml += 'subtitle="'+ color(dat.diaColor) +'" ';					xml += 'mouse="'+ boolean(dat.mouse) +'" ';					xml += 'float="'+ boolean(dat.float) +'" ';					xml += 'tween="'+ dat.rate +'" ';					xml += 'rotate="'+ dat.rotate +'" ';					xml += 'scroller="0" ';					xml += 'scale="'+ dat.scale +'" ';					xml += 'color="'+ dat.color +'" ';					xml += 'rate="'+ dat.speed +'" ';					xml += 'blur="'+ dat.focus +'"';					break;								case LayerTypes.PLANE:					xml += 'mouse="'+ boolean(dat.mouse) +'" ';					xml += 'float="'+ boolean(dat.float) +'" ';					xml += 'parallax="'+ dat.parallax +'"';					break;									case LayerTypes.BACKGROUND:					xml += 'mouse="'+ boolean(dat.mouse) +'" ';					xml += 'scrollL="'+ dat.marginL +'" ';					xml += 'scrollR="'+ dat.marginR +'" ';					xml += 'scrollT="'+ dat.marginT +'" ';					xml += 'scrollB="'+ dat.marginB +'"';					break;									case LayerTypes.CHARACTER:					xml += 'scroller="1" ';					xml += 'float="1" ';					xml += 'mouse="0" ';					xml += 'tween="'+ dat.rate +'" ';					xml += 'scale="'+ dat.scale +'" ';					xml += 'color="'+ dat.color +'" ';					xml += 'rate="'+ dat.speed +'" ';					xml += 'blur="'+ dat.focus +'"';					break;			}			xml += '/>\n';						// variables			xml += tab(t+1) + '<vars '+ vars(dat.vars) +'/>\n';						// title			xml += tab(t+1) + '<title>\n';			xml += tab(t+2) + compileLang(includeNode(dat.title)) +'\n';			xml += tab(t+1) +'</title>\n';			// actions			xml += tab(t+1) + '<actions>\n';						var $actionList:Array = new Array();						for (var j:int = 0; j < dat.actions.length; j++)			{				var $action:InteractionData = InteractionData(dat.actions[j]);				$action.id = actionIdList[Math.min(j, actionIdList.length-1)];				_transcript += '  -----\n  Action: "'+ $action.title +'" (#'+ j +', layer: '+ _curLayer +', state: '+ _curState +')\n\n';								var $data:String = compileAction($action, t+2);				$actionList.push($data);								// reference a previously compiled action.				if ($action.title.indexOf("@state:") == 0) {					var $refId:String = $action.title.split("@state:").join("");					if (_statesActions.hasOwnProperty($refId)) {						var $refData:String = _statesActions[$refId][j];						if (!!$refData) $data = $refData;					}				}								xml += $data;			}						// register compiled action within the lookup table.			_statesActions[ _curState ] = $actionList;			xml += tab(t+1) + '</actions>\n';						// items			xml += tab(t+1) + '<items>\n';						for (j = 0; j < dat.items.length; j++)			{				var $item:InteractionData = InteractionData(dat.items[j]);				if ($item.context != "" && ($item.context.indexOf("#item") < 0 || $item.context.indexOf("#noun") < 0)) $item.context = "";				$item.id = $item.title;				$item.title = $item.context;				_transcript += '  -----\n  Item: "'+ $item.id +'", "'+ $item.context +'" (layer: '+ _curLayer +', state: '+ _curState +')\n\n';				xml += compileAction($item, t+2);				$item.title = $item.id; // << restore item title field. title is only changed while compiling.			}						xml += tab(t+1) + '</items>\n';			xml += tab(t) + '</state>\n';			return xml;		}				private function _compileTree(dat:TreeRecord, t:int=2):String		{			_curTree = dat.id;			_transcript += _textRule;			_transcript += '- Tree: '+ _curTree +'\n';			_transcript += _textRule;						_tierXML = new Array();			_treePuppets = dat.puppets.split(",");			_compileTreeTier(dat.root, "r", t+1);						var xml:String = tab(t) +'<tree id="'+ dat.id +'">\n';						for (var j:int = 0; j < _tierXML.length; j++)			{				xml += _tierXML[j];			}			_tierXML = null;			_treePuppets = null;						xml += tab(t) + '</tree>\n';			return xml;		}				private function _compileTreeTier(dat:TierData, tierKey:String, t:int=0):void		{			_curTier = dat.id;			_transcript += ' '+ _textRule;			_transcript += ' Tier: "'+ _curTier +'" (tree: '+ _curTree +')\n\n';						var xml:String = tab(t) +'<tier key="'+ tierKey +'" ';			xml += 'id="'+ dat.id +'">\n';						for (var j:int = 0; j < dat.topics.length; j++)			{				xml += _compileTreeTopic(TopicData(dat.topics[j]), tierKey, t+1);			}						xml += tab(t) + '</tier>\n';			_tierXML.push(xml);		}				private function _compileTreeTopic(dat:TopicData, tierKey:String, t:int=0):String		{			// compile any nested action			if (dat.tier.topics.length > 0) {				_compileTreeTier(dat.tier, tierKey+"_"+dat.key, t-1);			}						var xml:String = tab(t) +'<topic key="'+ dat.key +'" ';			xml += 'id="'+ dat.id +'" ';			xml += 'enabled="'+ boolean(!dat.hidden) +'" ';			xml += 'hold="'+ boolean( (dat.topicAction == TreeActionKeys.LINE_STATIC || dat.topicAction == TreeActionKeys.LINE_REVEAL) ) +'" ';			xml += 'expose="'+ ((dat.topicAction == TreeActionKeys.LINE_REVEAL || dat.topicAction == TreeActionKeys.LINE_REPLACE) ? dat.topicTarget : "") +'" ';			xml += 'go="'+ (dat.tierAction == TreeActionKeys.TOPIC_JUMP ? dat.tierTarget : dat.tierAction) +'">\n';						// swap in first dialogue line's text if the dialogue title line is blank.			var $swap:Boolean = (dat.action.title == "");			if ($swap && dat.action.dialogue.length > 0) dat.action.title = dat.action.dialogue[0].caption;			_transcript += '  -----\n  Topic: "'+ dat.id +'" (tree: '+ _curTree +', tier: '+ _curTier +')\n\n';			xml += compileActionBody(dat.action, t+1, _treePuppets);			if ($swap) dat.action.title = "";						xml += tab(t) + '</topic>\n';			return xml;		}	}}internal final class RoomXMLCompilerEnforcer {}