package com.game.framework.interfaces
{
	import flash.events.Event;
	/**
	 * 
	 *@author sixf
	 */
	public interface IRander
	{
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
	}
}