package com.sanbeetle.component.child{
	
	import com.asvital.dev.Log;
	import com.sanbeetle.component.List;
	import com.sanbeetle.core.CacheDispaly;
	import com.sanbeetle.core.DisplayItem;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.LineCollectionItem;
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.events.DataChangeEvent;
	import com.sanbeetle.interfaces.ICellRenderer;
	import com.sanbeetle.interfaces.IDisplayItem;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.model.DisplayItemAction;
	import com.sanbeetle.model.ItemRendererTarget;
	import com.sanbeetle.model.LocationRect;
	import com.sanbeetle.renderer.SimpleListCellRenderer;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	
	/**
	 * 
	 * 项发生改变时
	 * 
	 */	
	[Event(name="change",type="com.sanbeetle.events.ControlEvent")]	
	/**
	 * 鼠标滑过项时 
	 */	
	[Event(name="item_over",type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 * 鼠标移出项时 
	 */	
	[Event(name="item_out",type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 * 项里面的内容 的事件 
	 */	
	[Event(name="item_renderer_select",type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 * 选中 项  与  change 不同的时，事件数据不一样。
	 */	
	[Event(name="item_select", type="com.sanbeetle.events.ControlEvent")]
	
	public class IListBox extends UIComponent {
		
		private var _dataProvider:DataProvider=new DataProvider;
		private var itemArr:Array=new Array();
		private var _listWidth:int = 120;	
		protected var _currentItem:IDisplayItem;
		
		
		protected var _selectedIndex:int =-1;
		private var _selectColumn:uint=0;
		
		private var _autoSize:Boolean = false;
		
		private var total:int=0;
		
		private var _paddingRect:LocationRect;
		
		private var _content:Sprite;
		
		
		//private var _parentItem:IDisplayItem;
		
		
		private var ItemCellRenderClass:Class;
		private var isNewItemCellrender:Boolean = false;
		
		private var _column:uint = 0;
		
		protected var _minWidth:int = -1;
		
		protected var _itemMaxwidth:int = -1;
		
		private var _parentList:List;
		public function IListBox(parentList:List=null) {
			
			_content =new Sprite();		
			this._parentList = parentList;
			
			
			ItemCellRenderClass = SimpleListCellRenderer;
			
			_paddingRect =new LocationRect(0,0,0,0);		
			this.addChild(_content);				
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseDownHandler);			
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);	
			
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			if(_dataProvider){
				_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE,onDataChangeHandler);
				_dataProvider.removeAll();
			}
			
			
			cleanUp();
			
			itemcellrenderArr.splice(0,itemcellrenderArr.length);
			
			this.removeEventListener(MouseEvent.MOUSE_UP,onMouseDownHandler);			
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);	
		}
		
		
		public function get parentList():List
		{
			return _parentList;
		}
		
		public function set parentList(value:List):void
		{
			_parentList = value;
		}
		
		private function onMouseOutHandler(event:MouseEvent):void
		{
			var ite:IDisplayItem =  event.target as IDisplayItem;
			
			if(ite){
				_currentItem= ite;
				//Log.out(_currentItem.y,"listbox");
				_selectedIndex = ite.listData.row;
				_selectColumn = ite.listData.column;
				ite.mouseOut(event);
				event.updateAfterEvent();
				this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_OUT,ite.data).setMouseEvent(event));
			}
			event.updateAfterEvent();
		}
		/**
		 *  所有项的最大宽度值 
		 * @return 
		 * 
		 */		
		public function get itemMaxwidth():int
		{
			return _itemMaxwidth;
		}
		
		public function get selectColumn():uint
		{
			return _selectColumn;
		}
		
		public function get column():uint
		{
			return _column;
		}
		
		public function set column(value:uint):void
		{
			_column = value;
		}
		
		public function set ItemCellRender(value:Class):void
		{
			if(ItemCellRenderClass !== value && value!=null){
				ItemCellRenderClass = value;
				isNewItemCellrender = true;
				itemcellrenderArr.splice(0,itemcellrenderArr.length);
				this.upDisplayList();
			}
			
		}
		
		public function get ItemCellRender():Class
		{
			return ItemCellRenderClass;
		}
		public function getMinWidth():int{		
			return _minWidth;
		}
		public function setMinWidth(w:int=-1):void{
			if(this._minWidth != w){
				this._minWidth = w;
				reDrawLayout();
			}			
		}
		
		/**
		 *  项容器 
		 * @return 
		 * 
		 */
		public function get content():DisplayObjectContainer
		{
			return _content;
		}	
		/**
		 * 内补订 
		 */
		public function get paddingRect():LocationRect
		{
			return _paddingRect;
		}
		
		/**
		 * @private
		 */
		public function set paddingRect(value:LocationRect):void
		{
			_paddingRect = value;
			this.updateUI();
		}
		
		[Inspectable(defaultValue = false)]
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		
		override protected function createUI():void
		{
			//renderData();
			//updateUI();
		}
		
		
		public function set autoSize(value:Boolean):void
		{
			if(_autoSize!=value){
				_autoSize = value;
				this.updateUI();
			}
			
		}
		
		private function onMouseOverHandler(event:MouseEvent):void
		{			
			var ite:IDisplayItem =  event.target as IDisplayItem;
			if(ite){
				_currentItem= ite;
				//Log.out(_currentItem.y,"listbox");
				_selectedIndex = ite.listData.row;
				_selectColumn = ite.listData.column;
				ite.mouseOver(event);
				//event.updateAfterEvent();
				this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_OVER,ite.data).setMouseEvent(event));
			}
			event.updateAfterEvent();
		}
		
		public function get currentItem():IDisplayItem
		{
			return _currentItem;
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		override protected function onAddStage():void
		{
			
			super.onAddStage();
			this.upDisplayList();
		}
		
		override protected function onRemoveStage():void
		{
			
			super.onRemoveStage();
			this.cleanUp();
		}
		
		
		private function onMouseDownHandler(event:MouseEvent):void
		{
			
			var itemdis:IDisplayItem = event.target as IDisplayItem;
			if(itemdis){
				_currentItem= itemdis;
				_selectedIndex = _currentItem.listData.row;
				_selectColumn = _currentItem.listData.column;
				
				itemdis.mouseOut(event);
				_currentItem.doAction(DisplayItemAction.SelectAction,selectactionOver,["dds"]);
				
			}else{
				var irt:ItemRendererTarget = new ItemRendererTarget();				
				
				irt.target = event.target as DisplayObject;
				var targ:DisplayObject = event.target as DisplayObject;
				while(targ!=null){
					
					if(targ is IDisplayItem){
						
						break;
					}else{
						targ = targ.parent;
					}
				}
				
				if(targ!=null){
					irt.listData=(targ as IDisplayItem).listData;	
					(targ as IDisplayItem).mouseOut(event);
					this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_RENDERER_SELECT,irt).setMouseEvent(event));
				}
				
			}
			
		}		
		public function cleanUp():void{
			var itemcellrenderer:ICellRenderer;
			
			var item:DisplayItem;			
			
			//var cache:Object = CacheDispaly.cachePool;
			
			for(var o:int=0;o<itemArr.length;o++){
				
				itemcellrenderer = ICellRenderer(itemArr[o]);
				if(itemcellrenderer){
					
					item = itemcellrenderer.getItem();
					if(item){						
						if(item.parent!=null){
							item.parent.removeChild(item);
						}
						//item.removeFromStage();
					}
					item.setStage(false);
					//如果是线的话，就删除了
					if(item.data is LineCollectionItem){						
						
					}					
				}			
				
			}
			itemArr.splice(0,itemArr.length);
			item =null;
		}
		private function selectactionOver(...age):void
		{
			this.dispatchEvent(new ControlEvent(ControlEvent.CHANGE,_currentItem.data));
			this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_SELECT,_currentItem));
		}
		[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}
		private var itemcellrenderArr:Array=[];
		private function getRenderereByIndex(index:int):ICellRenderer 
		{
			if(itemcellrenderArr[index]==null){
				itemcellrenderArr[index] =new ItemCellRenderClass();
			}
			
			return itemcellrenderArr[index];
		}
		private function renderData():void{
			
			//-------------
			
			var itemcellrenderer:ICellRenderer;			
			var item:DisplayItem;
			
			cleanUp();
			
			
			var h:Number=_paddingRect.top;
			var itemData:IFListItem;
			
			var listdata:ListData;
			
			if(_dataProvider!=null){
				
				for(var i:int=0;i<_dataProvider.length;i++){
					var t:Number =getTimer();
					//Console.out("components"+"components"+"---");
					itemData = _dataProvider.getItemAt(i) as IFListItem;
					
					//itemcellrenderer = itemArr[i];
					//itemcellrenderer = CacheDispaly.getTarget(getQualifiedClassName(ItemCellRenderClass)) as ICellRenderer;
					//itemcellrenderer = new ItemCellRenderClass();
					itemcellrenderer=getRenderereByIndex(i);
					
					if((getTimer()-t)>0){
						total=total+(getTimer()-t);
					}
					
					//传 父的  list
					if(_parentList!=null){
						if(_parentList.currentItem!=null){
							listdata = new ListData(itemData,this._column,i,_parentList.currentItem.listData);
						}else{
							listdata = new ListData(itemData,this._column,i,null);
						}
					}else{
						listdata = new ListData(itemData,this._column,i,null);
					}	
					
					
					if(itemcellrenderer.getItem()){
						itemcellrenderer.upData(itemData,listdata);
						item = itemcellrenderer.getItem();
						//Log.info("renderDataa",(getTimer()-t));
					}else{
						item = itemcellrenderer.createItem(itemData,listdata);
						//Log.info("renderDatab",(getTimer()-t));
					}								
					
					item.setSize(this.trueWidth-_paddingRect.right,item.contentHeight,_autoSize);
					
					if(item.contentWidth>_itemMaxwidth){
						_itemMaxwidth = item.contentWidth;
					}			
					item.y = h;	
					item.x = _paddingRect.left;
					
					h =h+item.contentHeight;
					
					
					
					content.addChild(item);
					itemArr.push(itemcellrenderer);						
					//Log.info("renderDatad",(getTimer()-t));
					
				}				
				//Log.info("renderData-----",total);
			}
			//--------------------
			
			
		}
		override public function upDisplayList():void{
			
			renderData();
			updateUI();
		}
		public function set dataProvider(value:DataProvider):void
		{
			if(_dataProvider != value && value!=null){
				
				if(_dataProvider){
					_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE,onDataChangeHandler);
					
				}
				_dataProvider = value;
				_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE,onDataChangeHandler);				
				
				if(this.stage){
					onDataChangeHandler(null);
				}				
			}
		}
		
		private function onDataChangeHandler(event:DataChangeEvent):void
		{
			//this.clearn();
			renderData();
			updateUI();
		}
		
		override public function set height(value:Number):void
		{
			Log.error("对 IListBox height 设置无效");
		}		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return _content.height;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return _content.width;
		}
		
		private function reDrawLayout():void{
			
			var t:Number = getTimer();
			
			var dite:IDisplayItem;
			var f:int=0;
			
			
			
			
			if(_autoSize==false){
				for(f=0;f<itemArr.length;f++){	
					dite = ICellRenderer(itemArr[f]).getItem();
					//dite.setSize((maxwithd-_paddingRect.right)+50,dite.contentHeight);
					//dite.setSize(_itemMaxwidth,dite.contentHeight,false);
					//dite.setSize(this.trueWidth,dite.contentHeight,false);
					
					if(this._minWidth>trueWidth){
						dite.setSize((_minWidth-_paddingRect.right),dite.contentHeight,false);	
					}else{
						dite.setSize(trueWidth-_paddingRect.right,dite.contentHeight,false);
					}
					
					if(trueWidth==0){
						Log.info(" IListBox:","autoSize:"+_autoSize,"trueWidth:"+trueWidth);
					}
				}
				
			}else{			
				
				for(f=0;f<itemArr.length;f++){	
					dite = ICellRenderer(itemArr[f]).getItem();
					if(this._minWidth>_itemMaxwidth){
						dite.setSize((_minWidth-_paddingRect.right),dite.contentHeight,false);	
					}else{
						dite.setSize((_itemMaxwidth-_paddingRect.right),dite.contentHeight,false);
					}
					
				}								
			}	
			
			_content.graphics.clear();
			
			if(_dataProvider.length<=0){
				_content.graphics.beginFill(0xff0000,0);
				_content.graphics.drawRect(0,0,_minWidth,30);
				_content.graphics.endFill();			
				drawBorder(_content.width,_content.height);
			}else{
				_content.graphics.beginFill(0xff0000,0);
				_content.graphics.drawRect(0,0,_content.width,_content.height);
				_content.graphics.endFill();			
				drawBorder(_content.width,_content.height);
				
			}
			
			
			
			
		}		
		override protected function updateUI():void
		{
			reDrawLayout();
		}
		
	}
	
}
