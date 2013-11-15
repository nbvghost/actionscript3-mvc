package com.sanbeetle.events
{
	import flash.events.Event;


	/**
	 *
	 *@author sixf
	 */
	public class ControlEvent extends Event
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
		public static const ITEM_OVER:String="item_over";
		/**
		 * ILabel 文本 a 标签 event:eventType 事件 
		 */
		public static const TEXT_LINK:String="text_link";

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