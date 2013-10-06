package com.game.framework.interfaces
{
	import flash.events.IEventDispatcher;

	/**
	 * 视图接口，扩展 IEventDispatcher 接口，说明该接口实现类，必须是一个视图对象，或者 实现了 IEventDispatcher 接口
	 * @see flash.events.IEventDispatcher
	 *@author sixf
	 */
	public interface ICreateView extends IEventDispatcher
	{
		 /**
		  * UIManager 这个会被自动注入
		  * @return 
		  * @see com.game.framework.interfaces.IUIManager
		  */
		 function get uimanager():IUIManager;	
		 function set uimanager(value:IUIManager):void;	
		 /**
		  * 是否在加载 
		  * @return 
		  * 
		  */
		 function get hasLoad():Boolean;
		 function set hasLoad(value:Boolean):void;
		 /**
		  * 释放资源 
		  * 
		  */
		 function dispose():void;
		 /**
		  * 加载 Skin 资源 
		  * @return 
		  * 
		  */
		 function loadSkin():ICreateView;
	}
}