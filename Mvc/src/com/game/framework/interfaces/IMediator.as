package com.game.framework.interfaces
{
	import com.game.framework.Launcher;
	
	/**
	 * 
	 *@author sixf
	 */
	public interface IMediator
	{	
		/**
		 * Mediator 层的名称，在所有的Mediator 层中，必须是唯一的。 
		 * @return 
		 * 
		 */
		function get name():String;
			
		/**
		 *  Mediator 被注册到 Launcher 里响应，并传入 UI 管理器 IUIManager
		 * @see  com.game.framework.interfaces.IUIManager
		 * @param uimanager
		 * 
		 */
		function initMediator():void;
		/**
		 * 初始化UI管理器
		 * @param uimanager
		 * 
		 */
		function intiUIManager(uimanager:IUIManager):void;
		/**
		 * 释放资源
		 * 
		 */
		function dispose():void;
		/**
		 * 引用  Launcher 的 对象，Launcher 是单例
		 * @return 
		 * 
		 */
		function get launcher():Launcher;
		
		function get view():ICreateView;
		function set view(value:ICreateView):void;
	}
}