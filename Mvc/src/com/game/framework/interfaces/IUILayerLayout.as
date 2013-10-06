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
		function addChildView(child:MediaAssetItem):MediaAssetItem;
		function addChildViewTop(child:MediaAssetItem):MediaAssetItem;
		function getViewByName(name:String):MediaAssetItem;
		function getViewByNameTop(name:String):MediaAssetItem;
		function removeChild(child:DisplayObject):DisplayObject;
		function removeChildAt(index:int):DisplayObject;
	}
}