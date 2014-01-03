package com.sanbeetle.interfaces
{
	import com.sanbeetle.data.ListData;

	public interface IDisplayItem extends IStage
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
		
		function setSize(width:Number,height:Number,autoLayOut:Boolean=false):void;
		
		
		function mouseOut():void;
		function mouseOver():void;		
		
		function doAction(actionType:String,actionComplete:Function,actionPar:Array=null):void;
		
		
		
	}
}