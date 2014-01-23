package com.game.framework.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	public dynamic class RequesProxy extends Proxy implements IEventDispatcher
	{
		
		
	
		
		private var eventer:EventDispatcher=new EventDispatcher();
		
		
		public function RequesProxy()
		{
			
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			// TODO Auto Generated method stub
			eventer.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			// TODO Auto Generated method stub
			return eventer.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return eventer.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			eventer.removeEventListener(type,listener,useCapture);
			
		}
		
		public function willTrigger(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return eventer.willTrigger(type);
		}
		
		
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		override flash_proxy function getDescendants(name:*):*
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		override flash_proxy function hasProperty(name:*):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		override flash_proxy function isAttribute(name:*):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		override flash_proxy function nextName(index:int):String
		{
			// TODO Auto Generated method stub
			return "";
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		override flash_proxy function nextValue(index:int):*
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			trace("")
			var q:QName = name;
			if(q!=null){
				
				send.apply(this,[name,value]);
			}			
			
			// TODO Auto Generated method stub
			//super.flash_proxy::setProperty(name, value);
		}
		
		protected function send(name:String,...parameters):void{
			
		}
		override flash_proxy function callProperty(name:*, ...parameters):*
		{
			var q:QName = name;
			if(q!=null){
				
				parameters.splice(0,0,q.localName);
				
				return send.apply(this,parameters);
			}
			
			return this;
		}
		
	}
}