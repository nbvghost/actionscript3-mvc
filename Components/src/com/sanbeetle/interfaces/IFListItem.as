package com.sanbeetle.interfaces
{
	

	/**
	 *
	 *@author sixf
	 */
	public interface IFListItem
	{
		function get label():String;
		function set label(value:String):void;
		
		function get data():Object;
		function set data(value:Object):void;
		
		function get type():String;
		function set type(value:String):void;
		
		function get itemColor():String;	
		function set itemColor(value:String):void;
		
		function get itemOverColor():String;
		function set itemOverColor(value:String):void;
	
		function get enable():Boolean;		
		function set enable(value:Boolean):void;
	}
}