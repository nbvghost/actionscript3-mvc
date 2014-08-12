package com.game.framework.command {
	import com.game.framework.FW;
	import com.game.framework.Launcher;
	import com.game.framework.ifaces.ICommand;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IObtain;
	import com.game.framework.ifaces.IProxy;
	import com.game.framework.views.Mediator;
	
	import flash.events.EventDispatcher;
	
	/**
	 *每一个Command 将被动态实例化，并执行 execute 方法，请把方法写在 execute 内。
	 *@author sixf
	 */
	public class Command extends EventDispatcher implements IObtain,ICommand {
		protected var launcher:Launcher;
		public function Command() {
			super();
			launcher = Launcher.launcher;
		}
		
		
		
		/**
		 * 每一个 Command 实例 被触发(sendNotify(Command.NAME,new NotifyData()))时， execute 被执行
		 * @param notify
		 *
		 */
		public function execute(notify:INotifyData):void {
			
			
		}
		
		
		
		/**
		 * 获取 Mediator 对象
		 * @param mediatroName 名称
		 * @return
		 *
		 */
		public function obtainMediator(MediatroClass:Class):Mediator {
			
			return  launcher.obtainMediator(MediatroClass);
		}
		
		/**
		 *  获取 Proxy 对象
		 * @param proxyName 名称
		 * @return
		 *
		 */
		public function obtainProxy(ProxyClass:Class):IProxy {
			
			return launcher.obtainProxy(ProxyClass);
		}
		
	}
}