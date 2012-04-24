package com.lassie.shepherd.data.room
{
	public class BoxData extends Object
	{
		public var id:String="b";
		public var x:int=-1;
		public var y:int=-1;
		public var width:int=100;
		public var height:int=75;
		public var children:Array=new Array();
	
		public function BoxData(index:int=0):void
		{
			super();
			id += index.toString();
		}
	}
}