package com.game.framework.display {
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	[Event(name="uncaught_error", type="com.game.framework.events.GlobalErrorEvent")]
	/**
	 * 伪装的一个 Stage 对象
	 *@author sixf
	 */
	public class AppStage extends LayerContainer implements IEventDispatcher{
		private var _trueStage:Stage;
		
		/**
		 * 传真正的 Stage 对象
		 * @param stage
		 *
		 */
		public function AppStage(stage:Stage,parentContainer:DisplayObjectContainer) {
			super(parentContainer);
			_trueStage = stage;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.container.addEventListener(type,listener,useCapture,priority,useWeakReference);
			
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			
			return container.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return container.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			// TODO Auto Generated method stub
			container.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return container.willTrigger(type);
		}
		
		
		/**
		 * 获取真正的 Stage 对象
		 * @return
		 *
		 */
		public function get trueStage():Stage {
			return _trueStage;
		}
		
		
		
	}
}