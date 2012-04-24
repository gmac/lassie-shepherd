﻿package com.lassie.shepherd.data.room{	import com.lassie.utils.ObjectUtil;	import com.lassie.shepherd.data.*;	import com.lassie.shepherd.data.game.GameDataParser;		public final class RoomDataParser	{		private var _voice:int = 0;				public static function parse(r:RoomData, dat:Object):void		{			try			{				ObjectUtil.assimilate(r, dat);				ActionsDataParser.voiceIncrement = r.voiceInc;				ActionsDataParser.reassignVoiceIncrement = false;								// purge assimilated layers array				r.layers = new Array();				for (var j:int = 0; j < dat.layers.length; j++)				{					r.layers.push(toLayerData(dat.layers[j]));				}								//trace("Layers: " + r.layers.length);								// purge assimilated walkareas array				r.walkareas = new Array();				for (j = 0; j < dat.walkareas.length; j++)				{					r.walkareas.push(toWalkareaData(dat.walkareas[j]));				}								//trace("Walkareas: " + r.walkareas.length);								// purge assimilated filters array				r.filters = new Array();				for (j = 0; j < dat.filters.length; j++)				{					r.filters.push(toFilterData(dat.filters[j]));				}								//trace("Filters: " + r.filters.length);								// purge assimilated scripts array				r.scripts = new Array();				for (j = 0; j < dat.scripts.length; j++)				{					r.scripts.push(GameDataParser.toScriptRecord(dat.scripts[j]));				}								//trace("Scripts: " + r.scripts.length);								// purge assimilated tree array				r.diaTrees = new Array();				for (j = 0; j < dat.diaTrees.length; j++)				{					r.diaTrees.push(GameDataParser.toTreeRecord(dat.diaTrees[j]));				}								r.voiceInc = ActionsDataParser.voiceIncrement;								//trace("Trees: " + r.diaTrees.length);			}			catch(e:Error)			{				trace("Could not create RoomData");			}		}				public static function toLayerData(dat:Object):LayerData		{			try			{				var l:LayerData = new LayerData();				ObjectUtil.assimilate(l, dat);				// purge assimilated actions array				l.actions = new Array();								for (var j:int = 0; j < dat.actions.length; j++)				{					l.actions.push(ActionsDataParser.toInteractionData(dat.actions[j]));				}								// purge assimilated phase array				l.phases = new Array();				for (j = 0; j < dat.phases.length; j++)				{					l.phases.push(toPhaseData(dat.phases[j]));				}								//trace("Phases: " + l.phases.length);				return l;			}			catch(e)			{				trace("Could not create LayerData");			}			return null;		}				public static function toPhaseData(dat:Object):PhaseData		{			try			{				var p:PhaseData = new PhaseData();				ObjectUtil.assimilate(p, dat);								// convert phase actions				p.actions = new Array();				for (var j:int = 0; j < dat.actions.length; j++)				{					p.actions.push(ActionsDataParser.toInteractionData(dat.actions[j]));				}								// convert phase items				p.items = new Array();				for (j = 0; j < dat.items.length; j++)				{					p.items.push(ActionsDataParser.toInteractionData(dat.items[j]));				}								return p;			}			catch(e)			{				trace("Could not create PhaseData");			}			return null;		}				public static function toWalkareaData(dat:Object):WalkareaData		{			try			{				var w:WalkareaData = new WalkareaData();				ObjectUtil.assimilate(w, dat);				// purge assimilated nodes array				w.nodes = new Array();								for (var j:int = 0; j < dat.nodes.length; j++)				{					w.nodes.push(toNodeData(dat.nodes[j]));				}								// purge assimilated boxes array				w.boxes = new Array();								for (j = 0; j < dat.boxes.length; j++)				{					w.boxes.push(toBoxData(dat.boxes[j]));				}								return w;			}			catch(e)			{				trace("Could not create WalkareaData");			}			return null;		}				public static function toNodeData(dat:Object):NodeData		{			try			{				var n:NodeData = new NodeData();				ObjectUtil.assimilate(n, dat);				return n;			}			catch(e)			{				trace("Could not create node");			}			return null;		}				public static function toBoxData(dat:Object):BoxData		{			try			{				var b:BoxData = new BoxData();				ObjectUtil.assimilate(b, dat);				return b;			}			catch(e)			{				trace("Could not create box");			}			return null;		}				public static function toFilterData(dat:Object):FilterData		{			try			{				var f:FilterData = new FilterData(dat.type);				ObjectUtil.assimilate(f, dat);				return f;			}			catch(e)			{				trace("Could not create filter");			}			return null;		}	}}