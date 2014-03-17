﻿package com.sanbeetle.events
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
		public static const ITEM_OUT:String = "item_out";
		public static const CLOSE:String="close";
		public static const SELECT:String="select";
		
		public static const CHANGE_SIZE:String = "change_size";
		
		/**
		 * 组件所在的视图被 被释放 
		 */
		public static const VIEW_DISPOSE:String="view_dispose";
		
		public static const ITEM_SELECT:String="item_select";
		
		/**
		 * 项选择 
		 */
		public static const ITEM_RENDERER_SELECT:String="item_renderer_select";
		
		/**
		 * ILabel 文本 a 标签 event:eventType 事件  点击事件
		 */
		public static const TEXT_LINK:String="text_link";
		/**
		 * 
		 */
		public static const TEXT_LINK_MOVE:String="text_link_move";
		/**
		 * 
		 */
		public static const TEXT_LINK_OVER:String="text_link_over";
		/**
		 * 
		 */
		public static const TEXT_LINK_OUT:String="text_link_out";

		/**
		 * 字体加载完成 
		 */
		public static const FONT_LOADED:String="font_loaded";
		
		/**
		 * 当组件执行 create 方法时，调度 
		 */
		public static const COMPONENT_CREATE_UI:String="component_create_ui";
		
		public var data:Object;
				
		public function ControlEvent(type:String,data:Object=null)
		{		
			super(type);
			this.data = data;		
			
		}
	}
}