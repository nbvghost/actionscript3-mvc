package com.game.framework.interfaces
{
	

	/**
	*
	*@author sixf
	*/
	public interface ICommand
	{		
		/**
		 *  当 Command 实例被触发时，响应这个方法
		 * @param notify
		 * @see com.game.framework.command.Command
		 */
		function execute(notify:INotifyData):void;
	}
}