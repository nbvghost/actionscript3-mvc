package com.sanbeetle.component.child{
	
	import com.asvital.dev.Console;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.model.LocationRect;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

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
	public class IListBox extends UIComponent {
		
		private var _dataProvider:DataProvider;
		private var itemArr:Array=new Array();
		private var _listWidth:int = 120;	
		private var _currentItem:IListBoxItem;
		
		private var textMaxWidth:int=-1;		
		private var _selectedIndex:int =-1;
		
		private var _autoWidth:Boolean = false;
		
		protected var _background:DisplayObjectContainer;
		
		private var _paddingRect:LocationRect;
		
		private var _content:DisplayObjectContainer;
		
		private var _itemEnableDel:Boolean = false;
		
		protected var _itemColor:String="";
		protected var _itemOverColor:String="";
		
		public function IListBox(_background:DisplayObjectContainer) {
		
			content =new Sprite();			
			
			_paddingRect =new LocationRect(8,2,8,1);
			this._background =_background;
			this.addChild(this._background);
			this.addChild(content);
			//this._background.width = _listWidth;
			this._background.mouseEnabled = false;			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
		}		
		[Inspectable(defaultValue = false)]
		public function get itemEnableDel():Boolean
		{
			return _itemEnableDel;
		}		
		
		public function set itemEnableDel(value:Boolean):void
		{
			_itemEnableDel = value;
			this.updateUI();
		}
		
		[Inspectable(defaultValue="")]
		/**
		 *  如果 itemOverColor 为 null 将使用 项数据（IFListItem 接口的） 进行设置
		 */
		public function get itemOverColor():String
		{
			return _itemOverColor;
		}

		/**
		 * @private
		 */
		public function set itemOverColor(value:String):void
		{
			if(_itemOverColor!=value){
				_itemOverColor = value;
				this.updateUI();
			}
			
		}
		[Inspectable(defaultValue="")]
		/**
		 *  如果 itemColor 为 null 将使用 项数据（IFListItem 接口的） 进行设置
		 */
		public function get itemColor():String
		{
			return _itemColor;
		}

		/**
		 * @private
		 */
		public function set itemColor(value:String):void
		{
			if(_itemColor!=value){
				_itemColor = value;
				this.updateUI();
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

		public function set content(value:DisplayObjectContainer):void
		{
			_content = value;
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
		public function get autoWidth():Boolean
		{
			return _autoWidth;
		}
		
		override protected function createUI():void
		{
			updateUI();
		}
		
		
		public function set autoWidth(value:Boolean):void
		{
			if(_autoWidth!=value){
				_autoWidth = value;
				this.updateUI();
			}
			
		}

		private function onMouseOverHandler(event:MouseEvent):void
		{			
			if(event.target is IListBoxItem){
				_currentItem= IListBoxItem(event.target);
				this._selectedIndex = IListBoxItem(event.target).index;
				this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_OVER,IListBoxItem(event.target).data));
			}
		}
		
		public function get currentItem():IListBoxItem
		{
			return _currentItem;
		}

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		[Inspectable(defaultValue = 120)]
		public function get listWidth():int
		{
			return _listWidth;
		}

		public function set listWidth(value:int):void
		{
			_listWidth = value;
			this._background.width = value;
			updateUI();
		}

		protected function onMouseDownHandler(event:MouseEvent):void
		{
			//Console.out("components"+"components"+"dsfds",event.target);
			if(event.target is IListBoxItem){
				_currentItem= IListBoxItem(event.target);
				_selectedIndex = _currentItem.index;
				_currentItem.bg.gotoAndStop(1);
				
				var timer:Timer =new Timer(this.component.LIST_HIDE_TIME,2);
				timer.addEventListener(TimerEvent.TIMER,ontimerhandelr);
				timer.start();
				//this.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				//this.dispatchEvent(new ControlEvent(ControlEvent.CHANGE,_currentItem.data));
			}
		}		
		private function ontimerhandelr(e:TimerEvent):void
		{
			if(_currentItem.bg.currentFrame==1){
				_currentItem.bg.gotoAndStop(2);	
			}else{	
				
				//_currentItem.bg.gotoAndStop(1);
				this.dispatchEvent(new ControlEvent(ControlEvent.CHANGE,_currentItem.data));
				//this.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				_currentItem.bg.gotoAndStop(1);
			}
			
		}
		[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}

		public function set dataProvider(value:DataProvider):void
		{
			_dataProvider = value;	
			
			updateUI();
		}
		
		override protected function updateUI():void
		{
			//Console.out("components"+trueWidth);
			_background.width =this.trueWidth;
			//_background.height = this.trueHeight;
			
			
			for(var o:int=0;o<itemArr.length;o++){
				content.removeChild(itemArr[o]);
				
			}
			
			itemArr.splice(0,itemArr.length);
			
			if(_dataProvider==null){
				return;
			}			
			
			var h:Number=0;
			var itemData:IFListItem;
			var item:IListBoxItem;
			var maxwithd:int =0;
			for(var i:int=0;i<_dataProvider.length;i++){
				Console.out("components"+"components"+"---");
				itemData = getDataProviderItem(_dataProvider.getItemAt(i) as IFListItem);
				item = listBoxItem();
				item.width = (this.trueWidth-_paddingRect.right);
				//item.width = 50;	
				//item.height = 50;
				item.index = i;
				if(itemData is IFListItem){
					
					if(_itemColor!=null && _itemColor!=""){
						itemData.itemColor = _itemColor;
						//Console.out("components"+_itemColor,_itemOverColor,"5454545");
					}
					if(_itemOverColor!=null && _itemOverColor!=""){
						itemData.itemOverColor = _itemOverColor;
						//Console.out("components"+_itemColor,_itemOverColor,"5454545");
					}
					
					item.data = itemData;	
				}else {					
					Console.out("components"+itemData+" 不是相关类型的 IFListItem,List 的数据项必须是相关的 IFListItem 对象、 SimpleCollectionItem 类或是其子类。");
					return;
				}
				if(item.textWidth>maxwithd){
					maxwithd = item.textWidth;
				}			
				item.y =item.y = h;				
				
				h =h+item.height;
				
				content.addChild(item);
				itemArr.push(item);				
			}
			
			content.x = _paddingRect.left;
			content.y= _paddingRect.top;
			_background.height=h+_paddingRect.top+_paddingRect.buttom;

			if(_autoWidth){
				for(var f:int=0;f<itemArr.length;f++){
				
					IListBoxItem(itemArr[f]).width = (maxwithd-_paddingRect.right)+50;					
				
				}				
				
				_background.width =  maxwithd+50;
			}		
			
			drawBorder(this.trueWidth,this.trueHeight);
		}
		protected function getDataProviderItem(item:IFListItem):IFListItem{
			return item;
		}
		/**
		 * 重写。得到不同的 IListBoxItem.可以扩展 IListBoxItem
		 * @return 
		 * 
		 */
		protected function listBoxItem():IListBoxItem{
			
			
			return new IListBoxItem();
		}	
		
	}
	
}
