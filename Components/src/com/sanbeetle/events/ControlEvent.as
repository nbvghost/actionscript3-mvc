package com.sanbeetle.events
{
	import fl.events.ComponentEvent;


	/**
	 *
	 *@author sixf
	 */
	public class ControlEvent extends fl.events.ComponentEvent
	{
		/**
		 * 时间完成事件 
		 */
		public static const TIME_COMPLETE:String = "time_complete";
		/**
		 * 分页事件 
		 */
		public static const PAGE_PAGING_EVENT:String = "page_paging_event";
		
		/**
		 * 修改 
		 */
		public static const CHANGE:String = "change";

		/**
		 * 字体加载完成 
		 */
		public static const FONT_LOADED:String="font_loaded";
		
		public var data:Object;
		public function ControlEvent(type:String,data:Object=null)
		{		
			super(type);
			this.data = data;		
			
		}
	}
}