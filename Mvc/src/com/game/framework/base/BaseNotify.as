package com.game.framework.base {
	import com.asvital.debug.Console;
	import com.game.framework.FW;
	import com.game.framework.Launcher;
	import com.game.framework.error.OperateError;
	import com.game.framework.events.FrameWorkEvent;
	import com.game.framework.ifaces.INotify;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.models.NotifyData;
	
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	/**
	 *实现了 INotify 接口
	 *@see com.game.framework.interfaces.INotify
	 *@author sixf
	 */
	public class BaseNotify extends EventDispatcher implements INotify {
		
		private var _name:String;
		
		
		public function BaseNotify() {
			this._name = name;
			this.addEventListener(FrameWorkEvent.HANDER_NOTIFY, onHanderNotifyHandler);
			
		}
		
		private function onHanderNotifyHandler(event:FrameWorkEvent):void {
			this.handerNotify(event.notifyName, event.notifyData);
		}
		
		FW function disHanderNotify(type:String, notifyData:INotifyData):void {
			this.dispatchEvent(new FrameWorkEvent(FrameWorkEvent.HANDER_NOTIFY, notifyData, type));
		}
		
		public function get name():String {
			throw new OperateError("重写 name 目标：" + this);
			return _name;
		}
		
		public function sendNotify(type:String, notifyData:INotifyData):Boolean {
			
			if (notifyData == null) {
				notifyData = new NotifyData();
			}		
			notifyData.FW::target = _name;
			
			if (Launcher.FW::launcher.sendNotify(type, notifyData)) {
				return true;
			} else {
				return false;
			}
			
			
		}
		
		FW function get launcher():Launcher {
			return Launcher.FW::launcher;
		}
		
		public function registerNotify():Array {
			//Console.out(this+"该Mediator没有订阅消息，将不会收到任何的消息。如果想接收消息请重写 registerNotify 方法！");
			return [];
		}
		
		public function sendNotifyTarget(name:String, type:String, notifyData:INotifyData):void {
			notifyData.FW::target = _name;
			Launcher.FW::launcher.sendNotifyTarget(name, type, notifyData);
		}
		
		public function handerNotify(type:String, notifyData:INotifyData):void {
			if (Capabilities.isDebugger) {
				Console.out(new OperateError("未处理的消息：" + type, this));
			}
		}
	}
}