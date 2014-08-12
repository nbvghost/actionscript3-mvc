package  com.game.framework.net {
	import com.asvital.dev.Log;
	import com.game.framework.data.NetRequestFormat;
	import com.game.framework.ifaces.ICallBack;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	public class NetRequest {
		
		
		
		private var thre:Object = new Object();
		
		public function NetRequest() {
		}
		
		public static function requestStream(request:URLVariables, callback:ICallBack, requesturl:String, action:int = 0):URLStream {
			
			
			var urlstream:URLStream = new URLStream();
			urlstream.addEventListener(Event.COMPLETE, onLoginHandler);
			urlstream.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			urlstream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			
			var url:URLRequest = new URLRequest(requesturl);
			url.data = request;
			//urlstream.load(new URLRequest(url.url+"&"+url.data));
			url.method = URLRequestMethod.POST;
			urlstream.load(url);
			
			//urlstream.load(new URLRequest("http://fj.yongshan-yl.com/ajax/orders.ashx?t=checkuser&email=ds&password=54700644c8ce4c663457c7433d6b49ed"));
			
			function onLoginHandler(event:Event):void {
				
				//Log.out((event.target as URLStream).bytesAvailable);
				var ba:ByteArray = new ByteArray();
				urlstream.readBytes(ba, 0, urlstream.bytesAvailable);
				ba.position = 0;
				
				callback.success(ba, action);
				Log.out(url.url + "&" + url.data);
			}
			
			function onErrorHandler(event:Object):void {
				Log.out(url.url + "&" + url.data);
				callback.error(event.toString(), action);
				
			}
			
			return urlstream;
		}	
		
		public static function request(callback:ICallBack,requesturl:String,dataFormat:String = URLLoaderDataFormat.TEXT,request:URLVariables=null, action:int = 0):URLLoader {
			var urlloader:URLLoader = new URLLoader();
			urlloader.addEventListener(Event.COMPLETE, onLoginHandler);
			urlloader.addEventListener(ProgressEvent.PROGRESS, onProgetHandler);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			urlloader.dataFormat = dataFormat;
			
			
			var url:URLRequest = new URLRequest(requesturl);
			url.data = request;
			
			urlloader.load(url);
			
			function onLoginHandler(event:Event):void {
				var data:Object =null;
				
				switch(dataFormat){
					case URLLoaderDataFormat.TEXT:
						data=String(urlloader.data);
						break;
					case URLLoaderDataFormat.BINARY:
						data=ByteArray(urlloader.data);
						break;
					case URLLoaderDataFormat.VARIABLES:
						data=new URLVariables(urlloader.data);
						break;
					case NetRequestFormat.XML_FORMAT:
						data = XML(urlloader.data);
						break;
					case NetRequestFormat.JSON_FORMAT:
						data = JSON.parse(urlloader.data);
						break;
					default:
						data = urlloader.data;
				}
				
				callback.success(data, action);
				Log.out(url.url + "&" + url.data);
				
			}
			
			function onErrorHandler(event:Object):void {
				callback.error(event.toString(), action);
				
			}
			
			function onProgetHandler(event:ProgressEvent):void {
				callback.progress(action);
				
			}
			
			return urlloader;
		}
		
	}
}