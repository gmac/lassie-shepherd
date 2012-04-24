/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.room
{
	import com.lassie.player.core.LPSprite;
	
	internal class RoomObject extends LPSprite
	{
		// reference to parent room display
		private var _parentRoom:RoomDisplay;
		
		public function RoomObject($parent:RoomDisplay):void
		{
			super();
			_parentRoom = $parent;
		}
		
		/**
		* Destroys room reference and super classes
		*/
		override public function destroy():void {
			super.destroy();
			_parentRoom = null;
		}

		/**
		* Gets a reference to the parent room display
		*/
		public function get parentRoom():RoomDisplay {
			return _parentRoom;
		}
	}
}