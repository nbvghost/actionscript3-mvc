package com.game.framework.interfaces
{
	import com.game.framework.view.Mediator;
	/**
	 *  用于获取 Proxy，Mediator 的一个接口
	 *@author sixf
	 */
	public interface IObtain
	{
		/**
		 * 获取一个  Proxy 层
		 * @param proxyName
		 * @return 
		 * 
		 */
		function obtainProxy(proxyName:String):IProxy;
		/**
		 * 获取一个 Mediator 层
		 * @param mediatroName
		 * @return 
		 * 
		 */
		function obtainMediator(mediatroName:String):Mediator;
	}
}