package com.game.framework.events {
	import com.game.framework.ifaces.INotifyData;
	
	import flash.events.Event;
	
	/**
	 *
	 *@author sixf
	 */
	public class FrameWorkEvent extends Event {
		
		public var notifyName:String;
		public var notifyData:INotifyData;
		
		public static const INIT_OVER:String="init_over";
		
		/**
		 *
		 * @param eventType 事件类型
		 * @param notifyData
		 * @param notifyName 发送信息的ID，唯一
		 *
		 */
		public function FrameWorkEvent(eventType:String, notifyData:INotifyData = null, notifyName:String = null) {
			super(eventType, false, false);
			this.notifyName = notifyName;
			this.notifyData = notifyData;
			
		}
	}
}