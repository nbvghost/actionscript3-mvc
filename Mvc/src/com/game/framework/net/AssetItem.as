package com.game.framework.net {
	import com.asvital.dev.Log;
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
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	/**
	 *
	 *@author sixf
	 */
	public class AssetItem extends UIComponent implements IAssetItem {
		private var _datainterface:IAssetsData;
		private var _url:IURL;
		protected var _content:Object;
		protected var _type:String = LoadContentType.MEDIA_CONTENT;		
		private var loader:Loader;
		private var _loadType:String = LoadType.CurrentApplicationDomain;
		private var _loadCount:int = 0;		
		private var _isLoading:Boolean = false;		
		protected var _loaderContext:LoaderContext = new LoaderContext();
		
		private var _data:ByteArray;
		
		/**
		 *
		 * @param url 加载的IURL
		 * @param currentDomain 使用当前域？
		 *
		 */
		public function AssetItem(url:IURL, loadType:String,contentType:String=LoadContentType.MEDIA_CONTENT) {		
			
			this.name = url.url;
			_url = url;
			this._loadType = loadType;
			
			_type = contentType;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandlerPrivate);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandlerPrivate);	
			
			//loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,function(e:HTTPStatusEvent):void{trace(e);});
			
			
			loader.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaughtErrorHandler);
			loader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaughtErrorHandler);
			
			
			
			_loaderContext.allowCodeImport = true;
			//_loaderContext.checkPolicyFile = true;
			
		}
		private var uid:String = RPCUID.createUID();
		
		
		
		public function get data():ByteArray
		{
			return _data;
		}

		public function set data(value:ByteArray):void
		{
			_data = value;
		}

		public function get loaderContext():LoaderContext
		{
			return _loaderContext;
		}
		
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
			trace(event.toString());
			_isLoading =false;
			appStage.dispatchEvent(new GlobalErrorEvent(GlobalErrorEvent.UNCAUGHT_ERROR,event));
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
			
			if(_loadCount<=ConfigData.MaxLoadCount){
				loadBytes();
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
		private function onProgressHandlerPrivate(event:ProgressEvent):void {
			onProgressHandler(event);
		}
		
		public function dispose():void {
			
			this.removeChildren();
			
			if(loader){
				
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandlerPrivate);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandlerPrivate);			
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
				
				if(_loaderContext!=null && _loaderContext.applicationDomain){
					_loaderContext.applicationDomain =null;
					_loaderContext=null;
				}
			}
			if (this.parent != null) {
				this.parent.removeChild(this);
				//Log.out(this.parent,this.parent.contains(this));
				
			}		
			
			_datainterface = null;
			_content = null;
			
			
			
		}		
		private function loadBytes():void{
			//trace(ApplicationDomain.currentDomain.getQualifiedDefinitionNames());
			switch(_loadType){
				case LoadType.ChildApplicationDomain:
					_loaderContext.applicationDomain =  new ApplicationDomain(ApplicationDomain.currentDomain);
					//loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain)));
					break;
				case LoadType.CurrentApplicationDomain:
					_loaderContext.applicationDomain =  ApplicationDomain.currentDomain;
					//loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, ApplicationDomain.currentDomain));
					break;
				case LoadType.NewApplicationDomain:
					_loaderContext.applicationDomain =  new ApplicationDomain();
					//loader.loadBytes(CacheData.getSwfByteArray(url), new LoaderContext(false, new ApplicationDomain()));
					break;
				case LoadType.NoneApplicationDomain:
					
					break;
				default:
					throw new OperateError("指定的 loadType 不是 LoadType 成员！",this);
					return;
			}
			
			if(_type==LoadContentType.MEDIA_CONTENT_BY_BYTEARRAY){
				if(_data==null){
					
					throw new OperateError("data 不能为空！");
					return;
				}
				loader.loadBytes(_data,_loaderContext);
			}else{
				
				loader.load(new URLRequest(url.url),_loaderContext);
			}
			
			
		}		
		
		public function initView(notify:INotifyData = null):void {
			
			
			if(!_isLoading){
				_isLoading = true;
				loadBytes();
			}			
			_loadCount++;
		}	
		
	}
}