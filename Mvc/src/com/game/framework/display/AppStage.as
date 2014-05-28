package com.game.framework.display {
	import com.game.framework.utils.Base64;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	[Event(name="uncaught_error", type="com.game.framework.events.GlobalErrorEvent")]
	/**
	 * 伪装的一个 Stage 对象
	 *@author sixf
	 */
	public class AppStage extends LayerContainer implements IEventDispatcher{
		private var _trueStage:Stage;
		private var mouseRecord:ByteArray = new ByteArray();
		
		/**
		 * 传真正的 Stage 对象
		 * @param stage
		 *
		 */
		public function AppStage(stage:Stage,parentContainer:DisplayObjectContainer) {
			super(parentContainer);
			_trueStage = stage;
			
			_trueStage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseHandler);
			_trueStage.addEventListener(MouseEvent.MOUSE_UP,onMouseHandler);
			_trueStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,onMouseHandler);
			_trueStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP,onMouseHandler);
		}
		public function getMouseRecord():String{
				
			return Base64.encodeByteArray(mouseRecord);
		}
		private function onMouseHandler(event:MouseEvent):void
		{
			
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					mouseRecord.writeUTF("d");
					mouseRecord.writeShort(_trueStage.mouseX);
					mouseRecord.writeShort(_trueStage.mouseY);
					mouseRecord.writeShort(_trueStage.stageWidth);
					mouseRecord.writeShort(_trueStage.stageHeight);
					
					break;
				case MouseEvent.MOUSE_UP:
					mouseRecord.writeUTF("u");
					mouseRecord.writeShort(_trueStage.mouseX);
					mouseRecord.writeShort(_trueStage.mouseY);
					mouseRecord.writeShort(_trueStage.stageWidth);
					mouseRecord.writeShort(_trueStage.stageHeight);
					break;
				case MouseEvent.RIGHT_MOUSE_DOWN:
					mouseRecord.writeUTF("rd");
					mouseRecord.writeShort(_trueStage.mouseX);
					mouseRecord.writeShort(_trueStage.mouseY);
					mouseRecord.writeShort(_trueStage.stageWidth);
					mouseRecord.writeShort(_trueStage.stageHeight);
					break;
				case MouseEvent.RIGHT_MOUSE_UP:
					mouseRecord.writeUTF("ru");
					mouseRecord.writeShort(_trueStage.mouseX);
					mouseRecord.writeShort(_trueStage.mouseY);
					mouseRecord.writeShort(_trueStage.stageWidth);
					mouseRecord.writeShort(_trueStage.stageHeight);
					break;
			}
			
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