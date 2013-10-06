package com.game.framework.interfaces
{
	import com.game.framework.Launcher;
	/**
	 *
	 *@author sixf
	 */
	public interface IProxy extends IObtain
	{
		function get name():String;
		function get launcher():Launcher;	
		function initProxy():void;		
	}
}