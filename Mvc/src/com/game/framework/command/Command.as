package com.game.framework.command
{
	import com.game.framework.Launcher;
	import com.game.framework.interfaces.ICommand;
	import com.game.framework.interfaces.INotifyData;
	import com.game.framework.interfaces.IObtain;
	import com.game.framework.interfaces.IProxy;
	import com.game.framework.view.Mediator;
	
	/**
	 *每一个Command 将被动态实例化，并执行 execute 方法，请把方法写在 execute 内。
	 *@author sixf
	 */
	public class Command implements IObtain,ICommand
	{
		public function Command()
		{
			super();
		}		
		/**
		 * 每一个 Command 实例 被触发(sendNotify(Command.NAME,new NotifyData()))时， execute 被执行
		 * @param notify
		 * 
		 */
		public function execute(notify:INotifyData):void
		{
			
			
		}
		
		/**
		 * 获取 Mediator 对象
		 * @param mediatroName 名称
		 * @return 
		 * 
		 */
		public function obtainMediator(mediatroName:String):Mediator
		{
			
			return  Launcher.launcher.obtainMediator(mediatroName);
		}
		
		/**
		 *  获取 Proxy 对象
		 * @param proxyName 名称
		 * @return 
		 * 
		 */
		public function obtainProxy(proxyName:String):IProxy
		{
			
			return Launcher.launcher.obtainProxy(proxyName);
		}
		
	}
}