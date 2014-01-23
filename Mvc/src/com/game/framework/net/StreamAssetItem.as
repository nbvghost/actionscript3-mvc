package com.game.framework.net {
	import com.asvital.dev.Log;
	import com.game.framework.ifaces.IAssetItem;
	import com.game.framework.ifaces.IAssetsData;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IURL;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	/**
	 *
	 *@author sixf
	 */
	public class StreamAssetItem implements IAssetItem {
		private var urlloaer:URLLoader;
		private var _dataFormat:String = URLLoaderDataFormat.TEXT;
		private var _content:Object;
		private var assetsData:IAssetsData;
		private var _url:IURL;
		
		/**
		 *
		 * @param url
		 * @param assetsdata 如不传值将不会自动加载，但可以通过 load 方法加载
		 *
		 */
		public function StreamAssetItem(url:IURL, assetsdata:IAssetsData = null, dataFormat:String = URLLoaderDataFormat.TEXT) {
			_url = url;
			
			urlloaer = new URLLoader();
			urlloaer.dataFormat = dataFormat;
			urlloaer.addEventListener(Event.COMPLETE, onCompleteHandler);
			urlloaer.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			urlloaer.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			
			this.setDatainterface = assetsdata;
			if (assetsdata != null) {
				
				initView();
			}
			
		}
		
		public function get bytesLoaded():uint
		{
			// TODO Auto Generated method stub
			return urlloaer.bytesLoaded;
		}
		
		public function get bytesTotal():uint
		{
			// TODO Auto Generated method stub
			return urlloaer.bytesTotal;
		}
		
		
		public function get contentLoaderInfo():LoaderInfo {
			Log.out("流对象加载时，为null," + this);
			return null;
		}
		
		
		public function onCompleteHandler(event:Event):void {
			// TODO Auto Generated method stub
			this._content = urlloaer.data;
			this.getDatainterface.asssetComplete(this);
			
		}
		
		public function onIOErrorHandler(event:IOErrorEvent):void {
			// TODO Auto Generated method stub
			Log.out(event.toString());
			assetsData.netError(event, this);
		}
		
		public function onProgressHandler(event:ProgressEvent):void {
			// TODO Auto Generated method stub
			//Log.out(event.toString());
			assetsData.progress(event, this);
		}
		
		
		public function get dataFormat():String {
			return _dataFormat;
		}
		
		/**
		 *URLLoaderDataFormat
		 * @param value
		 *
		 */
		public function set dataFormat(value:String):void {
			_dataFormat = value;
			urlloaer.dataFormat = _dataFormat;
		}
		
		public function initView(notify:INotifyData = null):void {
			urlloaer.load(new URLRequest(url.url));
		}
		
		public function get content():Object {
			// TODO Auto Generated method stub
			return _content;
		}
		
		public function dispose():void {
			// TODO Auto Generated method stub
			
		}
		
		public function get getDatainterface():IAssetsData {
			// TODO Auto Generated method stub
			return assetsData;
		}
		
		public function set setDatainterface(value:IAssetsData):void {
			
			this.assetsData = value;
		}
		
		public function get type():String {
			// TODO Auto Generated method stub
			return LoadType.STREAM_CONTENT;
		}
		
		public function get url():IURL {
			// TODO Auto Generated method stub
			return _url;
		}
		
		public function set url(value:IURL):void {
			this._url = value;
			
		}
		
		
	}
}