package com.game.framework.base
{
	import com.game.framework.Launcher;
	import com.game.framework.error.OperateError;
	import com.game.framework.interfaces.INotify;
	import com.game.framework.interfaces.INotifyData;
	import com.game.framework.model.NotifyData;
	
	import flash.system.Capabilities;
	
	
	/**
	 *实现了 INotify 接口
	 *@see com.game.framework.interfaces.INotify
	 *@author sixf
	 */
	public class BaseNotify implements INotify
	{
		
		private var _name:String;
		
		
		
		public function BaseNotify()
		{
			this._name = name;
		}		
		public function get name():String
		{
			throw new OperateError("重写 name 目标："+this);
			return _name;
		}		
		public function sendNotify(type:String, notifyData:INotifyData):Boolean
		{
			if(notifyData==null){
				notifyData = new NotifyData();
			}
			notifyData.target = _name;
			return launcher.sendNotify(type,notifyData);
		}
		public function get launcher():Launcher
		{			
			return Launcher.launcher;
		}
		
		public function registerNotify():Array
		{
			//trace(this+"该Mediator没有订阅消息，将不会收到任何的消息。如果想接收消息请重写 registerNotify 方法！");
			return [];
		}
		
		public function sendNotifyTarget(name:String, type:String, notifyData:INotifyData):void
		{
			notifyData.target = _name;
			return launcher.sendNotifyTarget(name,type,notifyData);
		}		
		public function handerNotify(type:String, notifyData:INotifyData):void
		{
			if(Capabilities.isDebugger){
				trace(new OperateError("未处理的消息："+type,this));
			}
		}
	}
}