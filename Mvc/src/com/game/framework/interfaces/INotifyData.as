package com.game.framework.interfaces
{
	/**
	 * 消息数据接口
	 *@author sixf
	 */
	public interface INotifyData
	{
		/**
		 * 消息数据 
		 * @return 
		 * 
		 */
		function get message():Object;
		function set message(value:Object):void;
		/**
		 * 消息类型 
		 * @return 
		 * 
		 */
		function get type():String;
		function set type(value:String):void;
		/**
		 * 消息发送者，名称 
		 * @return 
		 * 
		 */
		function get target():String;
		function set target(value:String):void;
		
		function toString():String;		
	}
}