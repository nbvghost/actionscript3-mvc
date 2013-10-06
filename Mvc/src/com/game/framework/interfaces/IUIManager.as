package com.game.framework.interfaces
{
	/**
	 *
	 *@author sixf
	 */
	import com.game.framework.display.AppStage;
	import com.game.framework.net.MediaAssetItem;
	
	import flash.geom.Rectangle;

	/**
	 * UIManager 接口，对 UIManager 的访问
	 * @author Administrator
	 * 
	 */
	public interface IUIManager
	{
		
		function addMediaView(media:MediaAssetItem,isoverride:Boolean=false):MediaAssetItem;
		function addMediaViewTop(media:MediaAssetItem):MediaAssetItem;		
		function removeMediaView(SwfURL:String):void;
		function addTopView(media:MediaAssetItem,isoverride:Boolean=false):MediaAssetItem;
		function getLayerRect():Rectangle;
		function get appStage():AppStage;
		
	}
}