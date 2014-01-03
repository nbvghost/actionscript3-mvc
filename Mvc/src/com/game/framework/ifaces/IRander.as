package com.game.framework.ifaces {
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	/**
	 *
	 *@author sixf
	 */
	public interface IRander {
		/**
		 * Event.ENTER_FRAME
		 * @param e
		 *
		 */
		function enterFrame(e:Event):void;
		
		/**
		 * Event.RESIZE 事件
		 * @param e
		 *
		 */
		function reSize(e:Event):void;
		
		function timerRun(event:TimerEvent):void;
	}
}