package com.game.framework.interfaces
{
	/**
	 * 提供了，框架中各层消息处理的的方法
	 *@author sixf
	 */
	public interface INotify
	{		
		/**
		 * 发送消息，
		 * @param type 订阅的消息类型
		 * @param message 消息数据
		 * 
		 */
		function sendNotify(type:String,notifyData:INotifyData):Boolean;		
		/**
		 * 订阅消息
		 * @return 
		 * 
		 */
		function registerNotify():Array;
		/**
		 * 消息处理方法
		 * @param type
		 * @param notifyData
		 * 
		 */
		function handerNotify(type:String,notifyData:INotifyData):void;	
		/**
		 * 向指定目标发送消息 ，目标可以是Proxy,Mediator 
		 * @param name 已在注册列表里的对象名称
		 * @param type
		 * @param notifyData
		 * 
		 */
		function sendNotifyTarget(name:String,type:String,notifyData:INotifyData):void;		
	
		
	}
}