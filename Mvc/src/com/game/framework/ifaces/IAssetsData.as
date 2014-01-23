package com.game.framework.ifaces {
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 *
	 *@author sixf
	 */
	public interface IAssetsData {
		/**
		 * AssetItem 子类的回调接口
		 * View 层加载完成
		 * @param data
		 * @see com.game.net.MediaAssetItem
		 * @see com.game.net.StreamAssetItem
		 */
		function asssetComplete(data:IAssetItem):void;
		
		/**
		 * 发生错误时
		 * @param event
		 * @param data
		 *
		 */
		function netError(event:IOErrorEvent, data:IAssetItem):void;
		
		/**
		 * 加载进度
		 * @param event
		 * @param data
		 *
		 */
		function progress(event:ProgressEvent, data:IAssetItem):void;
		
		/**
		 * Skin 加载完成，等于，所有的资源都加载完成
		 * @param data
		 *
		 */
		function asssetAllComplete(data:IAssetItem):void;
		function dispose():void;
	}
}