package com.game.framework.ifaces
{
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.net.AssetItem;
	import com.game.framework.views.AlertDialog;
	

	/**
	 * 这个接口给 弹出窗口的窗口用的。另一个（IDialogData） 是给窗口里面的内容用的。
	 *@author sixf
	 */
	public interface IDialog
	{
		/**
		 * 可以得到， AssetItem 与 AlertDialog 实例，  frist
		 * @param mediaAssetItem
		 * @param alert
		 * 
		 */
		function setDislogContent(mediaAssetItem:AssetItem,alert:AlertDialog):void;
		/**
		 * 得到  AlertDialogBuilder 对象的引用 second
		 * @param builder
		 * @param dialogContentIF 被调用者
		 */		
		function setAlertDialogBuilder(builder:AlertDialogBuilder,dialogContentIF:IDialogData):void;
		
		/**
		 * 完成设置
		 * 
		 */
		function completeSetup():void;
		
	}
}