package com.game.framework.events
{
	import flash.events.Event;
	
	public class RemoteEvent extends Event
	{
		/**
		 * 成功
		 */
		public static const RESULT:String ="result";
		/**
		 * 失败 
		 */
		public static const FAULT:String="fault";
		public var data:Object;
		public function RemoteEvent(type:String,data:Object=null)
		{
			super(type);
			this.data =data;
		}		
		override public function toString():String
		{
			// TODO Auto Generated method stub
			return super.toString()+" [data="+data+"]";
		}
		
	}
}