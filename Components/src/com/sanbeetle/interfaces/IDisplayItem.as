package com.sanbeetle.interfaces
{
	import com.sanbeetle.data.ListData;
	
	import flash.events.MouseEvent;

	public interface IDisplayItem
	{
		function get data():IFListItem;
		function set data(value:IFListItem):void;
		
		function get contentWidth():Number;
		function get contentHeight():Number;
		
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		function get listData():ListData;
		function set listData(value:ListData):void;		
		
		function setSize(_width:Number,_height:Number,autoLayOut:Boolean=false,index:int=-1):void;		
		
		function mouseOut(event:MouseEvent):void;
		function mouseOver(event:MouseEvent):void;		
		function mouseDown(event:MouseEvent):void;
		
		function doAction(actionType:String,actionComplete:Function,actionPar:Array=null):void;
		
		function get name():String;
		
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		
		
	}
}