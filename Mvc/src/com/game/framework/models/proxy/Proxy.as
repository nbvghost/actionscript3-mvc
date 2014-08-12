package com.game.framework.models.proxy {
	import com.game.framework.FW;
	import com.game.framework.base.BaseNotify;
	import com.game.framework.ifaces.IProxy;
	import com.game.framework.ifaces.IResourceManager;
	import com.game.framework.views.Mediator;
	
	/**
	 *
	 *@author sixf
	 */
	public class Proxy extends BaseNotify implements IProxy {
		
		private var _resourceManager:IResourceManager;
		
		
		public function Proxy() {
			
		}
		
		FW function set resourceManager(value:IResourceManager):void {
			_resourceManager = value;
		}
		
		protected function get resourceManager():IResourceManager {
			return _resourceManager;
		}
		
		public function obtainMediator(MediatroClass:Class):Mediator {
			// TODO Auto Generated method stub
			return launcher.obtainMediator(MediatroClass);
		}
		
		public function initProxy():void {
			
		}
		
		public function obtainProxy(ProxyClass:Class):IProxy {
			// TODO Auto Generated method stub
			return launcher.obtainProxy(ProxyClass);
		}
		
	}
}