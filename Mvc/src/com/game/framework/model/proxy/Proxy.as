package com.game.framework.model.proxy
{
	import com.game.framework.base.BaseNotify;
	import com.game.framework.interfaces.IProxy;
	import com.game.framework.interfaces.IResourceManager;
	import com.game.framework.view.Mediator;

	/**
	 *
	 *@author sixf
	 */
	public class Proxy extends BaseNotify implements IProxy
	{
		
	
	
		public function Proxy()
		{
			
			
		}		
		protected function get resourceManager():IResourceManager{
			return launcher.resourceManager;
		}
		public function obtainMediator(mediatroName:String):Mediator
		{
			// TODO Auto Generated method stub
			return launcher.obtainMediator(mediatroName);
		}		
		public function initProxy():void
		{
			// TODO Auto Generated method stub
			
		}
		public function obtainProxy(proxyName:String):IProxy
		{
			// TODO Auto Generated method stub
			return launcher.obtainProxy(proxyName);
		}
		
	}
}