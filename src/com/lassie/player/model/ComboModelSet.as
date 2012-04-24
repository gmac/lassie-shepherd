/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.model
{
	final internal class ComboModelSet extends DataModelSet
	{
		private const JOIN:String = "_";
		private var _combos:Object;
		
		public function ComboModelSet($class:Class=null):void
		{
			super( InventoryCombo );
			_combos = new Object();
		}
		
	//-------------------------------------------------
	// Overrides
	//-------------------------------------------------
	
		override public function destroy():void
		{
			super.destroy();
			
			for (var j:String in _combos) delete _combos[j];
			_combos = null;
		}
		
		override internal function parse($list:XMLList):void
		{
			for each (var comboXml:XML in $list)
			{
				var combo:InventoryCombo = getModel(comboXml.@id) as InventoryCombo;
				combo.parse(comboXml);
				_integrate(combo);
			}
		}
		
		/**
		* Integrator: keys all item combinations into a lookup table.
		*/
		private function _integrate($combo:InventoryCombo):void
		{
			// localize combo's pool reference
			var pool:Array = $combo.pool;
			
			if ($combo.primary != "")
			{
				// If combo has a primary item assigned,
				// cross reference primary with all pool items.
				for each (var poolItem:String in pool)
				{
					_combos[$combo.primary +JOIN+ poolItem] = $combo;
				}
			}
			else
			{
				// If combo only has an items pool,
				// cross reference all items within the pool.
				for (var j:int=0; j < pool.length; j++)
				{
					for (var k:int=j+1; k < pool.length; k++)
					{
						_combos[pool[j] +JOIN+ pool[k]] = $combo;
					}
				}
			}
		}
		
	//-------------------------------------------------
	// ModelSet methods
	//-------------------------------------------------
		
		/**
		* Gets an InventoryCombo model that applies to two specific items.
		*/
		public function getComboOf($item1:String, $item2:String):InventoryCombo
		{
			// attempt: 1-2 order.
			if (_combos[$item1 +JOIN+ $item2] != undefined) {
				return _combos[$item1 +JOIN+ $item2] as InventoryCombo;
			}
			// attempt: 2-1 order.
			else if (_combos[$item2 +JOIN+ $item1] != undefined) {
				return _combos[$item2 +JOIN+ $item1] as InventoryCombo;
			}
			// default: null.
			return null;
		}
	}
}