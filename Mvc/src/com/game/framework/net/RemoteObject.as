package com.game.framework.net
{
	import com.game.framework.data.RequesProxy;
	import com.game.framework.events.RemoteEvent;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	
	[Event(name="result",type="RemoteEvent")]
	[Event(name="fault",type="RemoteEvent")]
	public dynamic class RemoteObject extends RequesProxy
	{
		private var nc:NetConnection;
		private var _destination:String;
		private var _url:String;
		private var arguments:Array;	
		private var url:String;
		
		//private var messages:Array = [];
		public function RemoteObject(_destination:String=null)
		{
			super();
			
			this._destination = _destination;	
			
			nc = new NetConnection();
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onAsyncErrorHandler);
			nc.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			nc.addEventListener(NetStatusEvent.NET_STATUS,onNetStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityErrorHandler);
			nc.objectEncoding=ObjectEncoding.AMF3;			
			nc.client =this;
			
			
			
			
		}
		public function AppendToGatewayUrl(value:String):void
		{
			trace(value);
			nc.connect(url+value,arguments);
			//for(var i:int=0;i<messages.length;i++){
				//nc.call.apply(nc,messages[i]);
			//}		
			
		}
		override protected function send(name:String, ...parameters):void
		{
			var arr:Array = [];
			arr[0] = _destination+"."+name;
			arr[1] = new Responder(loadResult,error);
			for(var i:int=0;i<parameters.length;i++){
				arr.push(parameters[i]);
			}	
			//messages.push(arr);	
			nc.call.apply(nc,arr);
			
			/*for(var i:int=0;i<messages.length;i++){
				nc.call.apply(nc,messages[i]);
			}*/
		}	
		
		private function loadResult(value:*):void{
			
			this.dispatchEvent(new RemoteEvent(RemoteEvent.RESULT,value));
			
		}
		
		private function error(err:*):void{
			this.dispatchEvent(new RemoteEvent(RemoteEvent.RESULT,err));
		}
		protected function onSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace(event);
		}
		
		protected function onNetStatusHandler(event:NetStatusEvent):void
		{
			// TODO Auto-generated method stub
			trace(event.info.code);
			
		}
		
		protected function onIOErrorHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace(event);
		}
		
		protected function onAsyncErrorHandler(event:AsyncErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace(event);
		}	
		
		
		public function get destination():String
		{
			return _destination;
		}	
		public function set destination(value:String):void
		{
			_destination = value;
		}	
		
		public function connect(url:String,...arguments):void{
			
			this.url =url;
			nc.connect(url,arguments);
			
			nc.call(null,null);
			
		}
		
	}
}