/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.model
{
	final public class InventoryCombo extends DataModel
	{
		// private
		private var _primary:String;
		private var _pool:Array;
		private var _action:Action;

		public function InventoryCombo($id:String):void
		{
			super($id);
			_action = new Action();
		}

	//-------------------------------------------------
	// Overrides
	//-------------------------------------------------

		override public function destroy():void
		{
			_action.destroy();
			_action = null;
			_pool = null;
		}

		override internal function parse($xml:XML):void
		{
			_primary = $xml.@primary;
			_pool = ($xml.@pool != "") ? ($xml.@pool).split(",") : new Array();
			_action.parse(XML($xml.action));
		}

		override public function toString():String
		{
			return "[InventoryCombo] id: "+id;
		}

	//-------------------------------------------------
	// Read-only properties
	//-------------------------------------------------

		public function get primary():String
		{
			return _primary;
		}

		public function get pool():Array
		{
			return _pool;
		}

		public function get action():Action
		{
			return _action;
		}
	}
}