package com.game.framework.net {
	import com.asvital.dev.Log;
	import com.game.framework.data.ConfigData;
	import com.game.framework.error.OperateError;
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.ifaces.IAssetItem;
	import com.game.framework.ifaces.IAssetsData;
	import com.game.framework.ifaces.IMultiAssetData;
	
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	[Event(name="complete_load", type="com.game.framework.events.AssetsEvent")]
	/**
	 * 用于程序初始化资源，这个是单例
	 *@author sixf
	 */
	public class InitAssetsLoad extends EventDispatcher implements IAssetsData {
		private var items:Array;
		private var _dataInterface:IMultiAssetData;
		
		private var isLoading:Boolean = false;
		private var datas:Vector.<IAssetItem>;
		
		private var _isComplete:Boolean = false;
		private var currentLoadItem:IAssetItem;
		private static var initAssetsLoad:InitAssetsLoad;
		private var _count:int = 0;
		public function InitAssetsLoad() {
			
			if(initAssetsLoad!=null){
				throw new OperateError("initAssetsLoad 是 单例");
			}
			items = new Array();
			datas = new Vector.<IAssetItem>();
			//this.datainterface = datainterface;
			_dataInterface = new MultiAssetData();			
		}
		
		public function set dataInterface(value:IMultiAssetData):void
		{
			if(value!=null){				
				_dataInterface = value;
			}
		}
		
		public function get isComplete():Boolean
		{
			return _isComplete;
		}
		
		public static function get Instance():InitAssetsLoad{
			if(initAssetsLoad==null){
				initAssetsLoad = new InitAssetsLoad();
			}			
			return initAssetsLoad;
		}
		
		public function dispose():void
		{
			items.splice(0,items.length);
			
			datas.splice(0,datas.length);
			
			_dataInterface.dispose();
			
			_dataInterface=null;
		}
		
		public function get count():int{
			
			return _count;
		}
		public function put(assetitem:IAssetItem):void {
			if (isLoading == false) {
				var ishave:Boolean = false;
				for each (var ia:IAssetItem in items) 
				{
					if(ia.url.url==assetitem.url.url){
						ishave = true;
						break;
					}
				}
				if(ishave==false){
					assetitem.setDatainterface = this;
					items.push(assetitem);
					_count = items.length;
				}
			}
		}
		
		public function asssetAllComplete(data:IAssetItem):void {
			// TODO Auto Generated method stub
			
		}		
		private function deleteArrItem(uid:String):void {
			for (var i:int = 0; i < items.length; i++) {
				if (IAssetItem(items[i]).UID == uid) {
					items.splice(i, 1);
				}
			}
			//_count = items.length;
			
		}
		
		public function netError(event:IOErrorEvent, data:IAssetItem):void {
			//trace(event);
			deleteArrItem(data.UID);
			_dataInterface.netError(event, data);
			
			if(data.loadCount<=ConfigData.MaxLoadCount){
				items.push(currentLoadItem);	
				//_count = items.length;
			}else{
				Log.error("文件【"+data.url.url+"】加载出错，并重试了"+ConfigData.MaxLoadCount+"次，仍无法加载成功！");				
			}
			begin();
			//trace("加载次数："+data.loadCount);
			
		}
		
		public function progress(event:ProgressEvent, data:IAssetItem):void {
			//trace(event);
			_dataInterface.progress(event, data);
		}
		
		public function begin():void {
			isLoading = true;
			/*for each(var ai:IAssetItem in items) {
			ai.initView();
			}*/
			
			if (items.length <= 0) {
				loadOver();
				
			}else{
				currentLoadItem = items.shift();
				if(currentLoadItem){
				currentLoadItem.initView();
					
				}
				
				/*currentLoadItem = items.shift();	
				if(currentLoadItem)
				currentLoadItem.initView();*/
			}
			
		}
		public function get loadIndex():int{
			return _count-items.length;
		}
		private function loadOver():void{
			isLoading = false;
			_isComplete = true;
			_dataInterface.asssetMultiComplete(datas);
			this.dispatchEvent(new AssetsEvent(AssetsEvent.COMPLETE_LOAD));
		}
		public function asssetComplete(data:IAssetItem):void {
			_dataInterface.asssetComplete(data);
			datas.push(data);
			//deleteArrItem(data.UID);			
			
			var event:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS,false,false,data.bytesLoaded,data.bytesTotal);
			_dataInterface.progress(event, data);
			
			if (items.length <= 0) {
				loadOver();
			}else{
				begin();
			}
		}
		
	}
}