package com.game.framework.interfaces
{
	import com.game.framework.view.Mediator;
	/**
	 * 描述  swf 文件 Mediator 层的接口
	 *@author sixf
	 */
	public interface ISwfFile
	{
		/**
		 * 获取 swf 文件的 Mediator 对象  
		 * @return 
		 * 
		 */
		function get getMediator():Mediator;
	}
}