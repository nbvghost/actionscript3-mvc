package com.game.framework.interfaces
{
	/**
	 *
	 *@author sixf
	 */
	import com.game.framework.net.MediaAssetItem;
	
	import flash.display.DisplayObject;

	public interface IUILayerLayout
	{
		function addChildAtBackground(child:MediaAssetItem,index:int=-1):MediaAssetItem;
		function addChildAtMiddle(child:MediaAssetItem,index:int=-1):MediaAssetItem;
		function addChildAtTop(child:MediaAssetItem,index:int=-1):MediaAssetItem;
		
		function getBackgroundChildByName():MediaAssetItem;
		function getMiddleChildByName():MediaAssetItem;
		function getTopChildByName():MediaAssetItem;
		
		function removeBackgroundChild
		
		function addChildView(child:MediaAssetItem):MediaAssetItem;
		function addChildViewTop(child:MediaAssetItem):MediaAssetItem;
		function getViewByName(name:String):MediaAssetItem;
		function getViewByNameTop(name:String):MediaAssetItem;
		function removeChild(child:DisplayObject):DisplayObject;
		function removeChildAt(index:int):DisplayObject;
	}
}