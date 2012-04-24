/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.model
{
	final public class ActionList extends DataModel
	{
		private var _actionList:Array;
		private var _actionTable:Object;
		
		public function ActionList($id:String=""):void
		{
			super($id);
			_actionList = new Array();
			_actionTable = new Object();
		}

	//-------------------------------------------------
	// Overrides
	//-------------------------------------------------
	
		override public function destroy():void
		{
			// destroy all actions in the list
			for each (var act:Action in _actionList) {
				act.destroy();
			}
			// clear all references in the keyed table
			for (var $j:String in _actionTable) {
				delete _actionTable[$j];
			}
			_actionList = null;
			_actionTable = null;
		}

		override internal function parse($xml:XML):void
		{
			var $index:int = 0;
			for each (var $actXml:XML in $xml.action)
			{
				var $action:Action = new Action($actXml.@id, $index);
				$action.parse($actXml);
				addAction($action);
				$index++;
			}
		}
		
		override public function toString():String {
			return "[ActionList] id: "+ id +", actions: "+ numActions;
		}
		
	//-------------------------------------------------
	// Model methods
	//-------------------------------------------------
	
		/**
		* Adds an Action object to the list.
		*/
		internal function addAction($action:Action):void
		{
			_actionList.push($action);
			
			// add reference to key table if action has a valid Id.
			if ($action.id != "") {
				_actionTable[$action.id] = $action;
			}
		}
		
		/**
		* Removes and returns an action at the specified index.
		*/
		internal function removeAction($index:int):Action
		{
			if ($index >= 0 && $index < _actionList.length) {
				return _actionList.splice($index, 1) as Action;
			}
			return null;
		}
		
		/**
		* Specifies whether an action with the specified id exists.
		*/
		public function hasAction($id:String):Boolean
		{
			return _actionTable.hasOwnProperty($id);
		}
		
		/**
		* Gets an action by Id from the key table.
		*/
		public function getAction($id:String):Action
		{
			if (hasAction($id)) {
				return _actionTable[$id] as Action;
			}
			return null;
		}

		/**
		* Gets an action by numeric index within the list.
		*/
		public function getActionAt($index:int):Action
		{
			if ($index >= 0 && $index < _actionList.length) {
				return _actionList[$index] as Action;
			}
			return null;
		}
		
		/**
		* Gets the title of the specified list action.
		*/
		public function getTitleAt($index:int):String
		{
			var $action:Action = getActionAt($index);
			if ($action != null) return $action.title;
			return "";
		}
		
		/**
		* Gets the number of actions in the list.
		*/
		public function get numActions():int {
			return _actionList.length;
		}
	}
}