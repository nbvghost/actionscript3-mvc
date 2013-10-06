package com.game.framework.net
{
	import com.game.framework.display.UIComponent;
	import com.game.framework.interfaces.IAssetItem;
	import com.game.framework.interfaces.IAssetsData;
	import com.game.framework.interfaces.INotifyData;
	import com.game.framework.interfaces.IURL;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 *
	 *@author sixf
	 */
	public class AssetItem extends UIComponent implements IAssetItem
	{
		private var _datainterface:IAssetsData;
		private var _url:IURL;	
		protected var _content:Object;		
		protected var _type:String=LoadType.MEDIA_CONTENT;		
		protected var _isinitView:Boolean = false;
		private var loader:Loader;
		private var _contentLoaderInfo:LoaderInfo;
		private var _currentDomain:Boolean =true;
		/**
		 *  
		 * @param url 加载的IURL
		 * @param currentDomain 使用当前域？
		 * 
		 */
		public function AssetItem(url:IURL,currentDomain:Boolean)
		{
			
			this.name = url.url;
			_url = url;
			this._currentDomain = currentDomain;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandlerPrivate);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			loader.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
		}	
		
		public function get contentLoaderInfo():LoaderInfo
		{
			return loader.contentLoaderInfo;
		}	
		private function onCompleteHandlerPrivate(event:Event):void
		{
			this._content = loader.content;
			this.onCompleteHandler(event);
		}
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void
		{
			if (event.error is Error)
			{
				var error:Error = event.error as Error;
				trace(error.getStackTrace());
				// do something with the error
			}
			else if (event.error is ErrorEvent)
			{
				var errorEvent:ErrorEvent = event.error as ErrorEvent;
				// do something with the error
				trace(errorEvent.toString());
			}
			else
			{
				trace(event.toString());
				// a non-Error, non-ErrorEvent type was thrown and uncaught
			}
		}
		/**
		 * 是否正在初始化视图 
		 * @return 
		 * 
		 */
		public function get isinitView():Boolean
		{
			return _isinitView;
		}

		/**
		 * 加载类型 
		 * @return 
		 * 
		 */
		public function get type():String
		{
			return _type;
		}
		
		/**
		 * url=MediaURL.fromUIView(MediaURL.SKIN.LoginViewSkin) 
		 * @return 
		 * 
		 */
		public function get url():IURL
		{
			return _url;
		}
		
		public function set url(value:IURL):void
		{
			_url = value;
		}
		
		public function get content():Object
		{
			return _content;
		}	
		
		public function get getDatainterface():IAssetsData
		{
			return _datainterface;
		}
		
		public function set setDatainterface(value:IAssetsData):void
		{
			_datainterface = value;
		}
		
		public function onCompleteHandler(event:Event):void
		{
			// TODO Auto Generated method stub
			_datainterface.asssetComplete(this);
		}
		
		public function onIOErrorHandler(event:IOErrorEvent):void
		{
			// TODO Auto Generated method stub
			//trace(event);
			_datainterface.netError(event,this);
		}
		
		public function onProgressHandler(event:ProgressEvent):void
		{
			_datainterface.progress(event,this);
		}
		
		public function dispose():void
		{
			this.removeChildren();		
			
			if(this.parent!=null){
				this.parent.removeChild(this);
				//trace(this.parent,this.parent.contains(this));
				_datainterface=null;
			}
			_content =null;
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onCompleteHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			loader.contentLoaderInfo.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			
			loader.unloadAndStop();		
			loader=null;			
		}
		public function initView(type:String=null,notify:INotifyData=null):void{
			if(_currentDomain){
				loader.load(new URLRequest(url.url),new LoaderContext(false,ApplicationDomain.currentDomain));	
			}else{
				loader.load(new URLRequest(url.url),new LoaderContext(false,new ApplicationDomain()));	
			}
			
		}
	}
}