package com.game.framework.net {
	import com.asvital.dev.Log;
	import com.game.framework.data.CacheData;
	import com.game.framework.data.ConfigData;
	import com.game.framework.display.UIComponent;
	import com.game.framework.error.OperateError;
	import com.game.framework.events.GlobalErrorEvent;
	import com.game.framework.ifaces.IAssetItem;
	import com.game.framework.ifaces.IAssetsData;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IURL;
	import com.game.framework.utils.RPCUID;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 *
	 *@author sixf
	 */
	public class AssetItem extends UIComponent implements IAssetItem {
		private var _datainterface:IAssetsData;
		private var _url:IURL;
		protected var _content:Object;
		protected var _type:String = LoadContentType.MEDIA_CONTENT;
		protected var _isinitView:Boolean = false;
		private var loader:Loader;
		private var _loadType:String = LoadType.CurrentApplicationDomain;
		private var _loadCount:int = 0;
		private var swfUrlloader:URLLoader;
		
		private var _isLoading:Boolean = false;
		
		protected var loaderContext:LoaderContext = new LoaderContext();
		
		
		/**
		 *
		 * @param url 加载的IURL
		 * @param currentDomain 使用当前域？
		 *
		 */
		public function AssetItem(url:IURL, loadType:String) {		
			
			this.name = url.url;
			_url = url;
			this._loadType = loadType;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandlerPrivate);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			//loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			
			loader.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaughtErrorHandler);
			loader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaughtErrorHandler);
			
						
			swfUrlloader = new URLLoader();
			swfUrlloader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			swfUrlloader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			swfUrlloader.dataFormat = URLLoaderDataFormat.BINARY;
			
		}
		private var uid:String = RPCUID.createUID();
		
		

		public function get isLoading():Boolean
		{
			return _isLoading;
		}

		public function set isLoading(value:Boolean):void
		{
			_isLoading = value;
		}

		public function get UID():String
		{
			// TODO Auto Generated method stub
			return uid;
		}
		
		public function get loadCount():int
		{
			// TODO Auto Generated method stub
			return _loadCount;
		}
		
		
		public function get bytesLoaded():uint
		{
			// TODO Auto Generated method stub
			return loader.contentLoaderInfo.bytesLoaded;
		}
		
		public function get bytesTotal():uint
		{
			// TODO Auto Generated method stub
			return loader.contentLoaderInfo.bytesTotal;
		}
		
		
		public function get contentLoaderInfo():LoaderInfo {
			return loader.contentLoaderInfo;
		}
		
		private function onCompleteHandlerPrivate(event:Event):void {
			_isLoading = false;
			this._content = loader.content;
			this.onCompleteHandler(event);
			_loadCount = 0;
		}
		
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void {
			_isLoading =false;
			appStage.dispatchEvent(new GlobalErrorEvent(GlobalErrorEvent.UNCAUGHT_ERROR,event));
		}
		
		/**
		 * 是否正在初始化视图
		 * @return
		 *
		 */
		public function get isinitView():Boolean {
			return _isinitView;
		}
		
		/**
		 * 加载类型
		 * @return
		 *
		 */
		public function get type():String {
			return _type;
		}
		
		/**
		 * url=MediaURL.fromUIView(MediaURL.SKIN.LoginViewSkin)
		 * @return
		 *
		 */
		public function get url():IURL {
			return _url;
		}
		
		public function set url(value:IURL):void {
			_url = value;
		}
		
		public function get content():Object {
			return _content;
		}
		
		public function get getDatainterface():IAssetsData {
			return _datainterface;
		}
		
		public function set setDatainterface(value:IAssetsData):void {
			_datainterface = value;
		}
		public function onCompleteHandler(event:Event):void {		
		
			if(_datainterface==null){			
				
			}else{
				_datainterface.asssetComplete(this);
				_datainterface.asssetAllComplete(this);
			}    
		}
		public function onIOErrorHandler(event:IOErrorEvent):void {
			// TODO Auto Generated method stub
			//Log.out(event);
			
			swfUrlloader.removeEventListener(Event.COMPLETE,onSwfFileCompleteHandler);
			
			if(loadCount<=ConfigData.MaxLoadCount){
				swfUrlloader.addEventListener(Event.COMPLETE,onSwfFileCompleteHandler);
				swfUrlloader.load(new URLRequest(url.url));
				_loadCount++;
			}else{
				Log.info("加载出错："+event);
				_isLoading =false;
				_datainterface.netError(event, this);
				//throw new OperateError("加载出错："+event+ this.url.url,this);
			}
			
			
		}
		
		public function onProgressHandler(event:ProgressEvent):void {
			_datainterface.progress(event, this);
		}
		
		public function dispose():void {
			
			this.removeChildren();
			
			if(loader){
				
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandlerPrivate);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);			
				loader.contentLoaderInfo.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaughtErrorHandler);
				loader.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaughtErrorHandler);
				
				try{
					loader.close();
				}catch(e:Error){
					//Log.out(e.getStackTrace());
				}			
				loader.unloadAndStop();
				loader.unload();
				
				
				loader = null;
			}
			if (this.parent != null) {
				this.parent.removeChild(this);
				//Log.out(this.parent,this.parent.contains(this));
				
			}		
			
			
			_datainterface = null;
			_content = null;
			
			swfUrlloader =null;
			
		}
		
		private function loadBytes():void{
			//trace(ApplicationDomain.currentDomain.getQualifiedDefinitionNames());
			switch(_loadType){
				case LoadType.ChildApplicationDomain:
					loaderContext.applicationDomain =  new ApplicationDomain(ApplicationDomain.currentDomain);
					//loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain)));
					break;
				case LoadType.CurrentApplicationDomain:
					loaderContext.applicationDomain =  ApplicationDomain.currentDomain;
					//loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, ApplicationDomain.currentDomain));
					break;
				case LoadType.NewApplicationDomain:
					loaderContext.applicationDomain =  new ApplicationDomain();
					//loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, new ApplicationDomain()));
					break;
				case LoadType.NoneApplicationDomain:
					
					break;
				default:
					throw new OperateError("指定的 loadType 不是 LoadType 成员！",this);
					return;
			}
			
			loader.loadBytes(CacheData.getSwfByteArray(url),loaderContext);
			/*if (_loadType) {
				//loader.load(new URLRequest(url.url), new LoaderContext(false, ApplicationDomain.currentDomain));
				//trace(ApplicationDomain.currentDomain.getQualifiedDefinitionNames());
				loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, ApplicationDomain.currentDomain));
				//loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain)));	
			} else {				
				//loader.load(new URLRequest(url.url), new LoaderContext(false, new ApplicationDomain()));
				loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false,new ApplicationDomain()));
			}*/
		}
		
		public function initView(notify:INotifyData = null):void {
			
			
			if(CacheData.getSwfByteArray(url)!=null){
				loadBytes();
			}else{
				if(!_isLoading){
					_isLoading = true;
					swfUrlloader.addEventListener(Event.COMPLETE,onSwfFileCompleteHandler);
					swfUrlloader.load(new URLRequest(url.url));
				}				
			}
			_loadCount++;
		}
		
		protected function onSwfFileCompleteHandler(event:Event):void
		{
			_loadCount=0;
			swfUrlloader.removeEventListener(Event.COMPLETE,onSwfFileCompleteHandler);
			CacheData.writeByteArray(url,swfUrlloader.data);
			loadBytes();
		}
	}
}