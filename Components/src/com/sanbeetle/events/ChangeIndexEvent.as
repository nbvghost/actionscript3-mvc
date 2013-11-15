package com.sanbeetle.events
{
	import flash.events.Event;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class ChangeIndexEvent extends Event
	{
		public static const CHANGE_INDEX:String="change_index";
		public var newIndex:int=-1;
		public var oldIndex:int=-1;
		
		public function ChangeIndexEvent(type:String,newIndex:int=-1,oldIndex:int=-1)
		{
			super(type, false, false);
			this.newIndex = newIndex;
			this.oldIndex = oldIndex;
		}
	}
}