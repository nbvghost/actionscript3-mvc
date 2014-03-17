package com.game.framework.events
{
	import com.game.framework.data.AlertDialogBuilder;
	
	import flash.events.Event;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class DialogEvent extends Event
	{
		/**
		 *  现在关闭 
		 */
		public static const DISMISSING:String="dismissing";
		/**
		 * 关半完成 
		 */
		public static const DISMISS:String="dismiss";
		/**
		 * 窗口被打开
		 */
		public static const SHOW:String ="show";
		/**
		 * 点了关闭窗口按钮 
		 */
		public static const CLOSE_DIALOG:String="close_dialog";
		
		
		public var dialogBuilder:AlertDialogBuilder;
		public function DialogEvent(type:String,dialogBuilder:AlertDialogBuilder)
		{
			super(type);
			this.dialogBuilder = dialogBuilder;
		}
	}
}