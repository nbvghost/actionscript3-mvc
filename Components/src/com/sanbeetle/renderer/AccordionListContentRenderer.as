package com.sanbeetle.renderer
{
	import com.sanbeetle.component.child.IListBox;
	import com.sanbeetle.data.ListChildItem;
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.IDisplayItem;
	import com.sanbeetle.interfaces.IFListItem;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
		
	[Event(name="item_select", type="com.sanbeetle.events.ControlEvent")]
	
	public class AccordionListContentRenderer extends Sprite implements IDisplayItem
	{
		private var _listChild:IListBox;
		private var _data:IFListItem;
		private var _listData:ListData;
		private var _selected:Boolean = false;
		
		public function AccordionListContentRenderer()
		{
			super();
			
			_listChild = new IListBox();
			this.addChild(_listChild);
			
			_listChild.addEventListener(ControlEvent.ITEM_SELECT,onitemSelecthandler);
			
			_listChild.ItemCellRender = getItemCellRender();
			
			this.graphics.clear();
			this.graphics.beginFill(0xff0000);
			this.graphics.drawRect(0,0,this.contentWidth,this.contentHeight);
			this.graphics.endFill();
			
		}
		
		protected function onitemSelecthandler(event:ControlEvent):void
		{
			
			this.dispatchEvent(event.cloneEvent());
			
		}
		
		protected function getItemCellRender():Class{
			return SimpleListCellRenderer;
		}
		
		public function get listChild():IListBox
		{
			return _listChild;
		}
		
		public function get data():IFListItem
		{
			return _data;
		}
		
		public function set data(value:IFListItem):void
		{
			this._data = value;
			
			var lci:ListChildItem =  ListChildItem(value);
			
			if(lci==null){
				throw new Error("数据项不是相关类型的 ListChildItem.");
			}
			
			_listChild.dataProvider = ListChildItem(value).childs;
			
			
		}
		
		public function get contentWidth():Number
		{
			return _listChild.width;
		}
		
		public function get contentHeight():Number
		{
			return _listChild.height;
		}
		
		public function get listData():ListData
		{
			return _listData;
		}
		
		public function set listData(value:ListData):void
		{
			this._listData = value;
		}
		
		public function setSize(_width:Number, _height:Number, autoLayOut:Boolean=false, index:int=-1):void
		{
			_listChild.width = _width;
			_listChild.height = _height;			
		}
		
		public function mouseOut(event:MouseEvent):void
		{
		}
		
		public function mouseOver(event:MouseEvent):void
		{
		}
		
		public function mouseDown(event:MouseEvent):void
		{
		}
		
		public function doAction(actionType:String, actionComplete:Function, actionPar:Array=null):void
		{
			
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		public function get haveStage():Boolean
		{
			return false;
		}
		
		public function setStage(value:Boolean):void
		{
		}
	}
}