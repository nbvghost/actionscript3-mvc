package com.sanbeetle.component
{
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.ListChildItem;
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.IDisplayItem;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.renderer.AccordionItemBarRenderer;
	import com.sanbeetle.renderer.AccordionListContentRenderer;
	import com.sanbeetle.utils.Utils;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[Event(name="change_size", type="com.sanbeetle.events.ControlEvent")]	
	[Event(name="select", type="com.sanbeetle.events.ControlEvent")]
	[Event(name="item_select", type="com.sanbeetle.events.ControlEvent")]
	public class IAccordion extends UIComponent
	{
		
		private var _dataProvider:DataProvider = new DataProvider;
		
		
		private var itemS:Array = [];
		
		//private var _listChild:IListBox;
		
		private var _selectIndex:int = -1;
		
		
		private var _vspace:int = 0;
		
		
		private var _accordionItemBarRenderer:Class;
		private var _accordionListRenderer:Class;
		
		private var contentHeight:Number = 0;
		
		//private var _scrollBar:ScrollBar;
		
		
		private var content:Sprite;
		private var ivscr:IVScrollBar;
		
		private var contentArr:Array = [];
		
		private var currentContent:DisplayObject;
		
		private var _accordionItemBarCell:Function;
		private var _accordionListCell:Function;
		
		private var _isFloatScrollBar:Boolean = false;
		
		
		private var _autoHeight:Boolean = false;
		
		private var scrollBarPosition:Number=0;
		
		
		public function IAccordion()
		{
			super();
			
			content=new Sprite();
			content.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			content.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			content.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			this.addChild(content);
			
			ivscr = new IVScrollBar();
			
			//ivscr.visible = false;
			this.addChild(ivscr);
			
			
			ivscr.source = content;
			
			//_listChild= new IListBox();			
			_accordionItemBarRenderer = AccordionItemBarRenderer;
			//_accordionListRenderer = SimpleListCellRenderer;
			_accordionListRenderer = AccordionListContentRenderer;
			
		}
		public function get contentContainer():DisplayObjectContainer{
			
			return content;
		}
		public function get autoHeight():Boolean
		{
			return _autoHeight;
		}
		
		public function set autoHeight(value:Boolean):void
		{
			if(_autoHeight!=value){				
				_autoHeight = value;	
				if(_autoHeight){
					ivscr.dispose();
					if(ivscr.parent){
						ivscr.parent.removeChild(ivscr);
					}
					ivscr.source = null;
					this.content.y = 0;
				}else{					
					this.addChild(ivscr);
					ivscr.source = content;
				}
				updateUI();
			}
		}
		override public function dispose():void
		{		
			
			_accordionItemBarCell=null;
			_accordionListCell=null;
			_dataProvider.removeAll();
			contentArr.splice(0,contentArr.length);
			
			itemS.splice(0,itemS.length);
			
			content.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			content.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			content.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			ivscr.dispose();
			
			super.dispose();
		}
		
		
		/**
		 *  当前选择的内容项
		 * @return 
		 * 
		 */		
		public function get selectedContent():DisplayObject
		{
			return currentContent;
		}
		/**
		 * 滚动条是否浮动上层 
		 * @return 
		 * 
		 */		
		public function get isFloatScrollBar():Boolean
		{
			return _isFloatScrollBar;
		}
		
		public function set isFloatScrollBar(value:Boolean):void
		{
			if(_isFloatScrollBar != value){
				_isFloatScrollBar = value;
				
				ivscr.isFloat = _isFloatScrollBar;
				this.updateUI();
			}
			
			
		}
		/**
		 * 项内容的回调函数,参数两个，（当前项的显示对象，索引号） 
		 * @param value
		 * 
		 */		
		public function set accordionListCell(value:Function):void
		{
			_accordionListCell = value;
		}
		/**
		 * 根项的回调函数,参数两个，（当前项的显示对象，索引号）  
		 * @param value
		 * 
		 */		
		public function set accordionItemBarCell(value:Function):void
		{
			_accordionItemBarCell = value;
		}
		/**
		 * 滚动条 
		 * @return 
		 * 
		 */		
		public function get VScrollBar():IVScrollBar{
			
			return ivscr;
		}
		
		private function callCotentFunc(item:DisplayObject,index:int):void{
			
			
			if(_accordionListCell!=null){
				if(_accordionListCell.length>=2){
					_accordionListCell.apply(this,[item,index]);
				}else{
					throw new Error("accordionItemBarCell 参数个数不对，应该 有 2 个，当前"+_accordionListCell.length+"个！");
				}
			}
			
			
		}
		/**
		 * 根项的上下间距 
		 * @return 
		 * 
		 */		
		[Inspectable(defaultValue="0")]
		public function get vspace():int
		{
			return _vspace;
		}
		
		override public function get height():Number
		{
			if(autoHeight){
				return content.height;
				
			}else{
				if(this.ivscr.visible){
					return trueHeight;
				}else{
					return content.height;
				}
				
			}
		}
		
		
		public function set vspace(value:int):void
		{
			_vspace = value;
			
			
		}
		/**
		 * 内容项的 渲染器 
		 * @return 
		 * 
		 */		
		public function get accordionListRenderer():Class
		{
			return _accordionListRenderer;
		}
		
		public function set accordionListRenderer(value:Class):void
		{
			_accordionListRenderer = value;
			
			//_listChild.ItemCellRender = _accordionListRenderer;
		}
		
		private function getContentWidth():Number{
			
			if(_autoHeight){
				return trueWidth;
			}else{
				if(_isFloatScrollBar){
					return trueWidth;
				}else{
					return trueWidth-ivscr.width;
				}
			}
		}
		/**
		 * 默认 AccordionItemBarRenderer 根项渲染器
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
		private function getContentByIndex(index:int):DisplayObject{
			if(currentContent){
				if(currentContent.parent){
					currentContent.parent.removeChild(currentContent);
				}
				//IDisplayItem(currentContent).listData = null;
			}
			
			
			if(contentArr[index]==null){
				contentArr[index] = new _accordionListRenderer();
				
				InteractiveObject(contentArr[index]).addEventListener(ControlEvent.ITEM_SELECT,onItemSelectHandler);
				var item:ListChildItem;				
				if(_dataProvider.length-1>=index){
					item = this._dataProvider.getItemAt(index) as ListChildItem;
				}
				
				var listdatap:ListData = new ListData(item,index,0,null);
				var listdata:ListData = new ListData(item,index,0,listdatap);
				
				IDisplayItem(contentArr[index]).listData=listdata;
			}
			
			return contentArr[index];
		}
		
		protected function onItemSelectHandler(event:ControlEvent):void
		{
			this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_SELECT,currentContent));
		}
		[Inspectable(defaultValue="-1")]
		public function get selectIndex():int
		{
			return _selectIndex;
		}
		
		[Inspectable(defaultValue="-1")]
		public function set selectIndex(value:int):void
		{
			scrollBarPosition = 0;
			
			if(_selectIndex==value){
				return;
			}
			
			if(_selectIndex!=-1){
				this.getParBar(_selectIndex).selected =false;
			}
			
			_selectIndex = value;
			if(_selectIndex<0){
				if(currentContent){
					IDisplayItem(currentContent).selected = false;
				}
				_selectIndex=-1
			}else{
				if(_selectIndex<=itemS.length-1){
					
					if(currentContent){
						IDisplayItem(currentContent).selected = false;
					}
					
					currentContent  = this.getContentByIndex(_selectIndex);
					content.addChild(currentContent);
					this.ivscr.upDisplayList();
					var itemdata:ListChildItem = (_dataProvider.getItemAt(_selectIndex) as ListChildItem);
					
					if(itemdata){			
						
						IDisplayItem(currentContent).data = itemdata;
						
						IDisplayItem(currentContent).setSize(getContentWidth(),currentContent.height,false,_selectIndex);
						
						currentContent.y = itemS[_selectIndex].y+itemS[_selectIndex].contentHeight;
						
						callCotentFunc(currentContent,_selectIndex);
						
						
						
						//itemS[_selectIndex].selected = true;
						IDisplayItem(currentContent).selected = true;
						
						this.getParBar(_selectIndex).selected =true;
						
					}else{
						IDisplayItem(currentContent).selected = false;
						_selectIndex=-1
					}				
				}else{
					if(currentContent){
						IDisplayItem(currentContent).selected = false;
					}
					_selectIndex = -1;
				}
				
				
			}
			
			this.updateUI();
		}
		private function getParBar(index:int):IDisplayItem{
			
			if(itemS[index]==null){
				itemS[index] = new _accordionItemBarRenderer();
				
				var item:ListChildItem;
				
				if(_dataProvider.length-1>=index){
					item=this._dataProvider.getItemAt(index) as ListChildItem;
				}
				
				var listdata:ListData = new ListData(item,index,0,null);
				
				IDisplayItem(itemS[index]).listData=listdata;
				
			}
			return itemS[index];
		}
		
		override public function upDisplayList():void
		{
			
			this.updateUI();
			
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			//trace(event.target,event.currentTarget);
			var combar:IDisplayItem =Utils.isChildTypeof(_accordionItemBarRenderer,this.content,event.target as DisplayObject) as IDisplayItem;	
			
			
			var itemCidlData:ListChildItem;
			if(combar){
				
				scrollBarPosition = combar.y;
				
				itemCidlData = _dataProvider.getItemAt(uint(combar.name)) as ListChildItem;
				if(itemCidlData){	
					
					_selectIndex = uint(combar.name);
					
					
					
					currentContent  = this.getContentByIndex(_selectIndex);
					
					
					
					content.addChild(currentContent);
					
					IDisplayItem(currentContent).data = itemCidlData;
					IDisplayItem(currentContent).setSize(getContentWidth(),IDisplayItem(currentContent).contentHeight,false,_selectIndex);
					
					this.ivscr.upDisplayList();
					
					
					
					//currentContent.y = combar.y+combar.contentHeight;
					
					callCotentFunc(currentContent,_selectIndex);
					
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
							//_selectIndex = -1;
						}
					}
					combar.mouseDown(event);
					this.dispatchEvent(new ControlEvent(ControlEvent.SELECT,this.currentContent));
					
				}
				updateUI();
			}
			
			var comcont:IDisplayItem =Utils.isChildTypeof(_accordionListRenderer,this.content,event.target as DisplayObject) as IDisplayItem;
			if(comcont){
				//currentContent  = this.getContentByIndex(_selectIndex);
				comcont.mouseDown(event);
				//this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_SELECT,currentContent));
			}
			
		}
		//[Collection(collectionClass = "com.sanbeetle.data.DataProvider",identifier = "item",collectionItem = "com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}
		
		override protected function createUI():void
		{
			
			this.graphics.beginFill(0xff0000,0);
			this.graphics.drawRect(0,0,trueWidth,trueHeight);
			this.graphics.endFill();
			
		}
		/**
		 * 必须是 ListChildItem 对象， 
		 * @param value
		 * 
		 */		
		public function set dataProvider(value:DataProvider):void
		{
			scrollBarPosition = 0;
			if(_dataProvider!=value){	
				
				_dataProvider=value;
				
				
				while(content.numChildren>0){
					content.removeChildAt(0);
				}
				
				this.ivscr.upDisplayList();				
				//itemS.splice(0,itemS.length);				
				
				for (var i:int = 0; i < _dataProvider.length; i++) 
				{
					if(i==0){
						currentContent  = this.getContentByIndex(0);
						IDisplayItem(currentContent).data = (_dataProvider.getItemAt(i) as IFListItem);
					}
					
					var item:DisplayObject =getParBar(i) as DisplayObject;
					
					IDisplayItem(item).data = (_dataProvider.getItemAt(i) as IFListItem);
					IDisplayItem(item).setSize(getContentWidth(),item.height);
					
					//item.backgroundType = ComboBox.background_default;
					//item.width = trueWidth;
					//item.height = trueHeight;
					//item.defaultLabel = (_dataProvider.getItemAt(i) as IFListItem).label;
					item.name = i+"";
					
					/*item.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
					item.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
					item.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);*/
					
					//item.displayItem = 
					
					//item.y = IDisplayItem(item).contentHeight*i;
					content.addChild(item);
					
					
					if(_accordionItemBarCell!=null){
						if(_accordionItemBarCell.length>=2){
							_accordionItemBarCell.apply(this,[item,i]);
						}else{
							throw new Error("accordionItemBarCell 参数个数不对，应该 有 2 个，当前"+_accordionItemBarCell.length+"个！");
						}
					}
					
				}	
				
				updateUI();
			}
			
		}
		
		protected function onMouseOverHandler(event:MouseEvent):void
		{
			
			var combar:IDisplayItem =Utils.isChildTypeof(IDisplayItem,this.content,event.target as DisplayObject) as IDisplayItem;
			if(combar){
				combar.mouseOver(event);
			}
		}
		
		protected function onMouseOutHandler(event:MouseEvent):void
		{
			var combar:IDisplayItem =Utils.isChildTypeof(IDisplayItem,this.content,event.target as DisplayObject) as IDisplayItem;
			if(combar){
				combar.mouseOut(event);
			}
			
		}
		
		override protected function updateUI():void
		{
			
			ivscr.height = trueHeight;
			
			if(this._isFloatScrollBar){
				ivscr.x = trueWidth-ivscr.width;
			}else{
				
				ivscr.x = getContentWidth();
			}
			
			if(currentContent==null){
				
				return;
			}
			
			
			
			var listExtHeight:int = 0;
			var theight:Number = 0;
			for (var j:int = 0; j < _dataProvider.length; j++) 
			{
				
				var pitem:DisplayObject =getParBar(j) as DisplayObject;
				
				IDisplayItem(pitem).setSize(getContentWidth(),pitem.height);
				
				
				pitem.y = theight;
							
				
				if(j==_selectIndex){
					
					theight = theight+vspace;
					
					IDisplayItem(currentContent).data =  (_dataProvider.getItemAt(j) as IFListItem);
					IDisplayItem(currentContent).setSize(getContentWidth(),IDisplayItem(currentContent).contentHeight);
					
					currentContent.y = theight+IDisplayItem(pitem).contentHeight;
					
					content.addChild(currentContent);
					
					//currentContent.y = pitem.y+IDisplayItem(pitem).contentHeight+vspace;
					//listExtHeight=currentContent.y+IDisplayItem(currentContent).contentHeight;
					
					theight = theight+IDisplayItem(currentContent).contentHeight;
				}
				if(j>_selectIndex && _selectIndex!=-1){
					
					
					//pitem.y = theight;
					//theight = theight+_vspace;
					
					//pitem.y = listExtHeight+_vspace;			
					
					
					listExtHeight=listExtHeight+IDisplayItem(pitem).contentHeight+_vspace;
				}
				if( _selectIndex==-1){
					
					if(currentContent.parent){						
						currentContent.parent.removeChild(currentContent);
					}
					
				}
				
				theight = theight+(IDisplayItem(pitem).contentHeight+vspace);
				
			}
			
			this.graphics.clear();
			this.graphics.beginFill(0xff0000,0);
			
			if(itemS.length==0){
				this.graphics.drawRect(0,0,trueWidth,trueHeight);
			}else{
				if(_selectIndex==itemS.length-1){
					
					contentHeight = itemS[itemS.length-1].y+itemS[itemS.length-1].contentHeight+IDisplayItem(currentContent).contentHeight+_vspace;
				}else{
					contentHeight = itemS[itemS.length-1].y+itemS[itemS.length-1].contentHeight;
				}
				this.graphics.drawRect(0,0,trueWidth,contentHeight);
			}
			this.graphics.endFill();
			
			//this.graphics.clear();
			//var posion:Number = ivscr.getScrollBarPosition();
			
			//ivscr.upDisplayList();
			
			
			
			//ivscr.setVScrollBarPosition(posion);
			
			
			//trace(this.content.height,ivscr.height);
			content.graphics.clear();
			content.graphics.beginFill(0xffff00,0);
			content.graphics.drawRect(0,0,content.width,content.height);
			content.graphics.endFill();
			
			
			ivscr.upDisplayList();
			
			
			ivscr.setVScrollBarPosition(scrollBarPosition/content.height);
		}
		
		
	}
}