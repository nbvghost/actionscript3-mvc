package com.sanbeetle.component
{
	import com.sanbeetle.component.child.IListBox;
	import com.sanbeetle.core.DisplayItem;
	import com.sanbeetle.core.ScrollBar;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.ListChildItem;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.renderer.AccordionItemBarRenderer;
	import com.sanbeetle.renderer.SimpleListCellRenderer;
	
	import flash.events.MouseEvent;
	
	[Event(name="change_size", type="com.sanbeetle.events.ControlEvent")]	
	public class IAccordion extends UIComponent
	{
		
		private var _dataProvider:DataProvider = new DataProvider;
		
		
		private var itemS:Vector.<DisplayItem> = new Vector.<DisplayItem>();
		
		private var _listChild:IListBox;
		
		private var _selectIndex:int = -1;
		
		
		private var _vspace:int = 0;
		
		
		private var _accordionItemBarRenderer:Class;
		private var _accordionListRenderer:Class;
		
		private var contentHeight:Number = 0;
		
		private var _scrollBar:ScrollBar;
		private var _scrollBarName:String = "";
		
		public function IAccordion()
		{
			super();
			
			_listChild= new IListBox();			
			_accordionItemBarRenderer = AccordionItemBarRenderer;
			_accordionListRenderer = SimpleListCellRenderer;
			
			
		}
		[Inspectable(defaultValue="")]
		public function get scrollBarName():String
		{
			if(_scrollBar){
				return _scrollBar.name;
			}else{
				return "";
			}
			
		}
		
		public function set scrollBarName(value:String):void
		{
			if(_scrollBarName!=value){
				_scrollBarName = value;
				if(value!="" && value!=null){
					
					if(this.parent){
						_scrollBar = this.parent.getChildByName(value) as ScrollBar;
						updateUI();
					}				
				}
				//trace("_scrollBar",_scrollBar);
			}			
		}
		
		[Inspectable(defaultValue="0")]
		public function get vspace():int
		{
			return _vspace;
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return contentHeight;
		}
		
		
		public function set vspace(value:int):void
		{
			_vspace = value;
			
			updateUI();
		}
		
		public function get listChild():IListBox
		{
			return _listChild;
		}
		
		public function get accordionListRenderer():Class
		{
			return _accordionListRenderer;
		}
		
		public function set accordionListRenderer(value:Class):void
		{
			_accordionListRenderer = value;
			
			_listChild.ItemCellRender = _accordionListRenderer;
		}
		
		/**
		 * 默认 AccordionItemBarRenderer 
		 */
		public function get accordionItemBarRenderer():Class
		{
			return _accordionItemBarRenderer;
		}
		
		/**
		 * @private
		 */
		public function set accordionItemBarRenderer(value:Class):void
		{
			_accordionItemBarRenderer = value;
		}
		
		[Inspectable(defaultValue="-1")]
		public function get selectIndex():int
		{
			return _selectIndex;
		}
		[Inspectable(defaultValue="-1")]
		public function set selectIndex(value:int):void
		{
			_selectIndex = value;
			
			if(_selectIndex<0){
				_selectIndex=-1
			}else{
				this.addChild(_listChild);
				var itemdata:ListChildItem = (_dataProvider.getItemAt(_selectIndex) as ListChildItem);
				
				if(itemdata){					
					_listChild.dataProvider = itemdata.childs;
					_listChild.y = itemS[_selectIndex].y+itemS[_selectIndex].contentHeight
					itemS[_selectIndex].selected = true;
				}else{
					_selectIndex=-1
				}
				
				
			}
			updateUI();
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			//trace(event.target,event.currentTarget);
			var combar:DisplayItem = event.currentTarget as DisplayItem;
			var itemCidlData:ListChildItem;
			if(combar){
				
				itemCidlData = _dataProvider.getItemAt(uint(combar.name)) as ListChildItem;
				if(itemCidlData){					
					this.addChild(_listChild);
					_listChild.dataProvider = itemCidlData.childs;
					
					_listChild.y = combar.y+combar.contentHeight
					
					_selectIndex = uint(combar.name);
					
					//trace(uint(combar.name));
					//listChild.x = 50;
					
					for (var i:int = 0; i < itemS.length; i++) 
					{
						combar = itemS[i];
						if(i==_selectIndex){
							if(combar.selected){
								combar.selected= false;
								_selectIndex = -1;
							}else{
								combar.selected= true;
								//_selectIndex = -1;
							}
							
						}else{
							combar.selected= false;
						}
					}
					
					updateUI();
					
				}
			}
			
		}
		[Collection(collectionClass = "com.sanbeetle.data.DataProvider",identifier = "item",collectionItem = "com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}
		
		override public function createUI():void
		{
			
			this.graphics.beginFill(0xff0000,0);
			this.graphics.drawRect(0,0,trueWidth,trueHeight);
			this.graphics.endFill();
			
			if(_scrollBar==null){
				this.scrollBarName ="";
				this.scrollBarName = this._scrollBarName;
			}
			
		}
		
		public function set dataProvider(value:DataProvider):void
		{
			
			if(_dataProvider!=value){
				
				
				
				_dataProvider = value;
				
				for (var j:int = 0; j < itemS.length; j++) 
				{
					itemS[j].removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
					itemS[j].removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
					itemS[j].removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
					if(itemS[j].parent){
						
						itemS[j].parent.removeChild(itemS[j]);
						itemS[j].setStage(false);
					}
				}
				
				
				itemS.splice(0,itemS.length);
				
				
				for (var i:int = 0; i < _dataProvider.length; i++) 
				{
					
					var item:DisplayItem = new _accordionItemBarRenderer();
					item.data = (_dataProvider.getItemAt(i) as IFListItem);
					item.setSize(trueWidth,trueHeight);
					
					//item.backgroundType = ComboBox.background_default;
					//item.width = trueWidth;
					//item.height = trueHeight;
					//item.defaultLabel = (_dataProvider.getItemAt(i) as IFListItem).label;
					item.name = i+"";
					
					item.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
					item.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
					item.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
					
					//item.displayItem = 
					
					item.y = item.contentHeight*i;
					this.addChild(item);
					item.setStage(true);
					
					itemS.push(item);
				}				
				
				updateUI();
			}
		}
		
		protected function onMouseOverHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var combar:DisplayItem = event.currentTarget as DisplayItem;
			if(combar){
				combar.mouseOver(event);
			}
		}
		
		protected function onMouseOutHandler(event:MouseEvent):void
		{
			var combar:DisplayItem = event.currentTarget as DisplayItem;
			if(combar){
				combar.mouseOut(event);
			}
			
		}
		
		override public function updateUI():void
		{
			
			_listChild.width = trueWidth;
			
			
			var listExtHeight:int = 0;
			for (var j:int = 0; j < itemS.length; j++) 
			{
				
				itemS[j].setSize(trueWidth,trueHeight);	
				
				itemS[j].y = (itemS[j].contentHeight+vspace)*j;
				
				
				if(j==_selectIndex){
					_listChild.y = itemS[j].y+itemS[j].contentHeight+vspace;
					listExtHeight=_listChild.y+_listChild.height;
					
					_listChild.visible = true;
					//this.addChild(listChild);
				}
				if(j>_selectIndex && _selectIndex!=-1){
					
					
					itemS[j].y = listExtHeight+_vspace;
					
					listExtHeight=listExtHeight+itemS[j].contentHeight+_vspace;
				}
				if( _selectIndex==-1){
					/*if(listChild.parent){
					listChild.parent.removeChild(listChild);
					}*/
					//listChild.cleanUp();
					if(_listChild.parent){						
						this.setChildIndex(_listChild,0);
					}
					_listChild.visible = false;
				}
			}
			this.graphics.clear();
			this.graphics.beginFill(0xff0000,0);
			if(itemS.length==0){
				this.graphics.drawRect(0,0,trueWidth,trueHeight);
			}else{
				if(_selectIndex==itemS.length-1){
					
					contentHeight = itemS[itemS.length-1].y+itemS[itemS.length-1].contentHeight+_listChild.height+_vspace;
				}else{
					contentHeight = itemS[itemS.length-1].y+itemS[itemS.length-1].contentHeight;
				}
				this.graphics.drawRect(0,0,trueWidth,contentHeight);
			}
			this.graphics.endFill();
			
			
			
			if(_scrollBar){
				var posion:Number = _scrollBar.getScrollBarPosition();
				
				_scrollBar.upDisplayList();
				_scrollBar.setVScrollBarPosition(posion);
				//trace(_scrollBar);
			}
			
		}
		
		
	}
}