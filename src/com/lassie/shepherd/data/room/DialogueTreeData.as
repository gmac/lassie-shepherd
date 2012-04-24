package com.lassie.shepherd.data.room
{
	public class DialogueTreeData extends Object
	{
		public var id:String = "";
		public var lockId:Boolean = false;
		public var topics:Array = new Array();
		public var spawn:int = 0;
		
		public function DialogueTreeData():void
		{
			super();
		}
	}
}