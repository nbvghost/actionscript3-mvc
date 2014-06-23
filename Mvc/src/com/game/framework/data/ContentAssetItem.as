package com.game.framework.data
{
	import com.game.framework.ifaces.IAssetItem;
	import com.game.framework.ifaces.IAssetsData;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IURL;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * @author sixf
	 * 日期：2014-6-10 下午7:29:25 2014
	 * Administrator
	 */
	public class ContentAssetItem implements IAssetItem
	{
		private var _type:String;
		private var _url:IURL;
		private var _UID:String;
		private var _content:Object;
		
		public function ContentAssetItem(_url:IURL,_UID:String,type:String,_content:Object)
		{
			this._type = type;
			this._UID = _UID;
			this._content = _content;
			this._url = _url;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get url():IURL
		{
			return _url;
		}
		
		public function set url(value:IURL):void
		{
			_url = value;
		}
		
		public function get UID():String
		{
			return _UID;
		}
		
		public function get content():Object
		{
			return _content;
		}
		
		public function get bytesLoaded():uint
		{
			return 0;
		}
		
		public function get bytesTotal():uint
		{
			return 0;
		}
		
		public function get contentLoaderInfo():LoaderInfo
		{
			return null;
		}
		
		public function get getDatainterface():IAssetsData
		{
			return null;
		}
		
		public function set setDatainterface(value:IAssetsData):void
		{
		}
		
		public function initView(notify:INotifyData=null):void
		{
		}
		
		public function dispose():void
		{
		}
		
		public function get loadCount():int
		{
			return 0;
		}
		
		public function onCompleteHandler(event:Event):void
		{
		}
		
		public function onProgressHandler(event:ProgressEvent):void
		{
		}
		
		public function onIOErrorHandler(event:IOErrorEvent):void
		{
		}
	}
}