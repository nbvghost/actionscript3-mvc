package com.game.framework.ifaces {
	import com.game.framework.views.CreateView;
	import com.game.framework.views.Mediator;
	
	/**
	 * 描述  swf 文件 Mediator 层的接口
	 *@author sixf
	 */
	public interface ISwfFile {
		/**
		 * 获取 swf 文件的 Mediator 对象
		 * @return
		 *
		 */
		function get getMediator():Mediator;
		
		/**
		 * 获得视图层
		 * @return
		 *
		 */
		function get getCreateView():CreateView;
		
		/**
		 *  皮肤地址
		 * @return
		 *
		 */
		function get getSkinURL():IURL;
	}
}