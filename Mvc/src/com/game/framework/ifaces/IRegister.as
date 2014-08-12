package com.game.framework.ifaces {
	import com.game.framework.models.proxy.Proxy;
	import com.game.framework.views.BaseMediator;
	
	
	/**
	 *
	 *@author sixf
	 */
	public interface IRegister {
		function registerCommand(commandID:String, command:Class):void;
		
		function registerMediator(MediatorClass:Class):void;
		
		function registerProxy(ProxyClass:Class):void;
	}
}