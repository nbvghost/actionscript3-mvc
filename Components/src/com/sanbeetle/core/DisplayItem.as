package com.sanbeetle.core
{
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.interfaces.IDisplayItem;
	import com.sanbeetle.interfaces.IFListItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DisplayItem extends Sprite implements IDisplayItem
	{
		
		private var _data:IFListItem;
		private var _contentWidth:Number=-1;
		private var _contentHeight:Number = -1;
		private var _listData:ListData;
		private var isInstage:Boolean =false;
		private var oh:Number = 0;
		private var ow:Number = 0;
		private var autoLayout:Boolean = false;
		public function DisplayItem()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,onStageHandler);
		}
		
		private function onStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onremoveStageHandler);
			isInstage = true;
			//trace("on stage");
		}		
		
		private function onremoveStageHandler(event:Event):void
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onStageHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onremoveStageHandler);
			isInstage = false;
			//trace("remove stage");
		}
		
		public function get inStage():Boolean
		{
			return isInstage;
			
		}		
		public function get data():IFListItem
		{
			return _data;
		}
		
		public function set data(value:IFListItem):void
		{			
			_data = value;
			createUI();
		}
		
		public function get contentWidth():Number
		{
			throw new Error("重写 contentWidth 方法,类"+this);
			return _contentWidth;
		}		
		public function get contentHeight():Number
		{
			throw new Error("重写 contentHeight 方法,类"+this);
			return _contentHeight;
		}
		
		public function get listData():ListData
		{
			return _listData;
		}
		
		public function set listData(value:ListData):void
		{
			_listData = value;
		}
		public function setSize(width:Number, height:Number,autoLayOut:Boolean=false):void
		{
			if(ow!=width || oh!=height || autoLayout!=autoLayOut){
				ow = width;
				oh = height;
				autoLayout= autoLayOut;
				drawLayout(width,height,autoLayOut);
			}
			
		}
		/**
		 * 重新布局 ，
		 * @param cw
		 * @param ch
		 * @param autoLayOut  如果为  true 时，item 的宽度，是自己本身的宽度，而不读取  cw 的值
		 */	
		protected function drawLayout(cw:Number,ch:Number,autoLayOut:Boolean=false):void{
			
		}
		/**
		 *  在 data 之后 
		 * 
		 */
		protected function createUI():void{
			
		}
		public function mouseOut():void
		{
		}
		
		public function mouseOver():void
		{
		}
		
		public function doAction(actionType:String, actionComplete:Function, actionPar:Array=null):void
		{
			throw new Error("重写 doAction 方法,类"+this);
		}
	}
}