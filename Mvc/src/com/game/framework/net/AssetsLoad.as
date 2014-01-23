package com.game.framework.net {
	import com.game.framework.ifaces.IAssetItem;
	import com.game.framework.ifaces.IAssetsData;
	import com.game.framework.ifaces.IMultiAssetData;
	import com.game.framework.ifaces.IURL;
	
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 *
	 *@author sixf
	 */
	public class AssetsLoad implements IAssetsData {
		private var items:Array;
		private var datainterface:IMultiAssetData;
		
		private var isLoading:Boolean = false;
		private var datas:Vector.<IAssetItem>;
		
		public function AssetsLoad(datainterface:IMultiAssetData) {
			items = new Array();
			datas = new Vector.<IAssetItem>();
			//this.datainterface = datainterface;
			this.datainterface = datainterface;
			
		}
		
		public function dispose():void
		{
			items.splice(0,items.length);
			
			datas.splice(0,datas.length);
			
			datainterface.dispose();
			
			datainterface=null;
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
					
				}
			}
		}
		
		public function asssetAllComplete(data:IAssetItem):void {
			// TODO Auto Generated method stub
			
		}
		
		private function deleteArrItem(url:IURL):void {
			for (var i:int = 0; i < items.length; i++) {
				if (IAssetItem(items[i]).url.url == url.url) {
					items.splice(i, 1);
				}
			}
		}
		
		public function netError(event:IOErrorEvent, data:IAssetItem):void {
			deleteArrItem(data.url);
			datainterface.netError(event, data);
		}
		
		public function progress(event:ProgressEvent, data:IAssetItem):void {
			// TODO Auto Generated method stub
			
			datainterface.progress(event, data);
		}
		
		public function begin():void {
			isLoading = true;
			for each(var ai:IAssetItem in items) {
				ai.initView();
			}
		}
		
		public function asssetComplete(data:IAssetItem):void {
			datainterface.asssetComplete(data);
			datas.push(data);
			deleteArrItem(data.url);			
			
			
			var event:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS,false,false,data.bytesLoaded,data.bytesTotal);
			datainterface.progress(event, data);
			
			if (items.length <= 0) {
				isLoading = false;
				datainterface.asssetMultiComplete(datas);
			}
		}
		
	}
}