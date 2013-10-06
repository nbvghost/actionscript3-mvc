package com.game.framework.interfaces
{
	import com.game.framework.view.BaseMediator;
	/**
	 *
	 *@author sixf
	 */
	public interface IRegister
	{
		function registerCommand(commandID:String,command:Class):void;
		function registerMediator(mediator:BaseMediator):void;
		function registerProxy(proxy:IProxy):void;
	}
}