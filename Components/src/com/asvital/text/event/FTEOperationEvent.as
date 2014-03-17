package com.asvital.text.event
{
	import flash.events.Event;
	
	public class FTEOperationEvent extends Event
	{
		public static const LinkMouseDown:String="LinkMouseDown";
		public static const LinkMouseOver:String="LinkMouseOver";
		public static const LinkMouseOut:String="LinkMouseOut";
		
		public function FTEOperationEvent(type:String)
		{
			super(type, false, false);
		}
	}
}