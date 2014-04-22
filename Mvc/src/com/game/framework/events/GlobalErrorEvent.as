package com.game.framework.events
{
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	
	/**
	 * @author sixf
	 * 日期：2014-4-14 下午3:57:19 2014
	 * Administrator
	 */
	public class GlobalErrorEvent extends Event
	{
		public static const UNCAUGHT_ERROR:String ="uncaught_error";
		public var uncaughtErrorEvent:UncaughtErrorEvent;
		public function GlobalErrorEvent(type:String,uncaughtErrorEvent:UncaughtErrorEvent=null)
		{
			super(type);
			this.uncaughtErrorEvent = uncaughtErrorEvent;
		}
	}
}