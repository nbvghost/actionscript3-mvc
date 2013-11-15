package com.game.framework.ifaces
{
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.views.AlertDialog;

	/**
	 *
	 *@author sixf
	 */
	public interface IDialogData 
	{
		/**
		 * 返回   AlertDialogBuilder 对象 ，用于 AlertDialog 实例使用。
		 * @return 
		 * 
		 */
		function getDialogBuilder():AlertDialogBuilder;	
		/**
		 * 得天一个  AlertDialog 实例 
		 * @param value
		 * 
		 */
		function setAlertDialog(value:AlertDialog):void;
	}
}