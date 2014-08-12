package com.game.framework.net
{
	import com.asvital.dev.Log;
	import com.game.framework.events.RemoteEvent;
	import com.game.framework.utils.Base64;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	
	[Event(name="result", type="com.game.framework.events.RemoteEvent")]
	[Event(name="fault", type="com.game.framework.events.RemoteEvent")]
	[Event(name="connect", type="flash.events.Event")]	
	/**
	 * 发邮件
	 * @author sixf
	 * 日期：2014-4-14 下午4:32:10 2014
	 * Administrator
	 */
	public class SendMail extends EventDispatcher
	{		
		public var to:String;
		public var server:String;
		public var port:int=25;
		public var subject:String;
		public var content:String;
		public var username:String;
		public var password:String;
		private var s:Socket;
		private var messages:Array;
		private var reg:RegExp=/([0-9a-zA-Z]+[-._+&])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/;
		private var counter:int;
		
		
		private var _isWorking:Boolean = false;
		
		public function SendMail(server:String=null,username:String=null,password:String=null,to:String=null,subject:String=null,content:String=null,sendNow:Boolean=false) {
			s=new Socket();
			this.server=server;
			this.port=port;
			this.username=username;
			this.password=password;
			this.to=to;
			this.subject=subject;
			this.content=content;
			
			if(sendNow){
				this.send();
			}
		}
		/**
		 * 是否处于工作状态 
		 * @return 
		 * 
		 */
		public function get isWorking():Boolean
		{
			return _isWorking;
		}

		public function set isWorking(value:Boolean):void
		{
			_isWorking = value;
		}
		/**
		 * 发送 
		 * 
		 */
		public function send():void{
			if(!server||!username||!password||!to)
				throw new Error("服务器地址、用户名、密码、收件人不可或缺！");
			if(!reg.test(username))
				throw new Error("用户名不是有效的电子邮件地址。");
			if(!reg.test(to))
				throw new Error("收件人不是有效的电子邮件地址。");
			messages=["ehlo localhost","auth login "+Base64.encode(username),Base64.encode(password),"mail from: <"+username+">","rcpt to: <"+to+">","data","From: <"+username+">\nTo: <"+to+">\nDate:"+new Date().toString()+"\nSubject:"+subject+"\nMIME-Version: 1.0Content-type: text/plain;\ncharset=\"gb2312\"\n\r\n"+content+"\r\n.","quit"];
			s.connect(server,port);
			s.addEventListener(Event.CONNECT,hconnect);
			s.addEventListener(IOErrorEvent.IO_ERROR,hioerr);
			s.addEventListener(SecurityErrorEvent.SECURITY_ERROR,hseerr);
			
			isWorking = true;
		}
		private function hconnect(e:Event):void{
			counter=0;
			s.addEventListener(ProgressEvent.SOCKET_DATA,hdata);
			s.removeEventListener(Event.CONNECT,hconnect);
			s.removeEventListener(IOErrorEvent.IO_ERROR,hioerr);
			s.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,hseerr);
			this.dispatchEvent(new Event(Event.CONNECT));
		}
		private function hioerr(e:IOErrorEvent):void{
			s.removeEventListener(Event.CONNECT,hconnect);
			s.removeEventListener(IOErrorEvent.IO_ERROR,hioerr);
			s.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,hseerr);
			//throw new Error("对不起，提供的服务商地址无效或无网络连接。");
			this.dispatchEvent(new RemoteEvent(RemoteEvent.FAULT,"对不起，提供的服务商地址无效或无网络连接。"));
		}
		private function hseerr(e:SecurityErrorEvent):void{
			//throw new Error("对不起，您所在的安全沙箱无权发送电子邮件。");
			this.dispatchEvent(new RemoteEvent(RemoteEvent.FAULT,"对不起，您所在的安全沙箱无权发送电子邮件。"));
		}
		private function hdata(e:ProgressEvent):void{
			var str:String=s.readMultiByte(s.bytesAvailable,"utf-8");
			if(str.charAt(0)=='4'||str.charAt(0)=='5'){
				if(s.connected){
					s.close();
				}
				//throw new Error("发送邮件遇到问题，具体情况是："+str);
				this.dispatchEvent(new RemoteEvent(RemoteEvent.FAULT,"发送邮件遇到问题，具体情况是："+str));
			}else{
				s.writeMultiByte(messages[counter++]+"\r\n","gb2312");
				s.flush();
				Log.out(str);
			}
			if(counter==messages.length){
				this.dispatchEvent(new RemoteEvent(RemoteEvent.RESULT));
				if(s.connected){
					s.close();
				}
					
			}
			
			isWorking = false;
		}
	}
}