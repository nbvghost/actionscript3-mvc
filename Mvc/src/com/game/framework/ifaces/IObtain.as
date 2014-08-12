package com.game.framework.ifaces 
{
	import com.game.framework.views.Mediator;
	
	/**
	 *  用于获取 Proxy，Mediator 的一个接口
	 *@author sixf
	 */
	public interface IObtain {
		/**
		 * 获取一个  Proxy 层
		 * @param proxyName
		 * @return
		 *
		 */
		function obtainProxy(ProxyClass:Class):IProxy;
		
		/**
		 * 获取一个 Mediator 层
		 * @param mediatroName
		 * @return
		 *
		 */
		function obtainMediator(MediatroClass:Class):Mediator;
	}
}