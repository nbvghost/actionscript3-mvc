package com.sanbeetle.component
{
	
	import com.sanbeetle.component.child.ComboBoxBar;
	import com.sanbeetle.core.DisplayItem;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.ICellRenderer;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.utils.Utils;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 *  
	 * 当项发生改变时。调度
	 * 
	 */	
	[Event(name="change",type="com.sanbeetle.events.ControlEvent")]	
	/**
	 * 项里面的内容 的事件 
	 */	
	[Event(name="item_renderer_select",type="com.sanbeetle.events.ControlEvent")]
	public class ComboBox extends UIComponent
	{
		
		private var _dataProvider:DataProvider=new DataProvider();
		
		private var _selectedIndex:int = -1;
		private var _selectedItem:IFListItem = null;
		
		private var _listData:ListData;
		
		private var _fontSize:String = "10";
		private var _fontColor:String ="0xffffff";
		
		
		private var list:ListChild;
		
		private var _label:String="default label";
		
		
		
		/**
		 * 默认背景
		 */
		public static const background_default:String="background_default";
		/**
		 *  没有背景
		 */
		public static const background_none:String="background_none";
		/**
		 * 有背景，但只有鼠标滑过的时候有
		 */
		public static const background_over:String="background_over";
		
		/**
		 * 有背景，并且右边有一个小按钮
		 */
		public static const backround_rb:String="backround_rb";
		
		
		private var _backgroundType:String=background_default;
		
		
		private var cbbar:ComboBoxBar;
		
		private var _ilable:ILabel;
		
		private var ItemCellRenaderer:Class;	
		
		
		public function ComboBox ()
		{
			
			
			cbbar = new ComboBoxBar();
			//cbbar.fontColor = _fontColor;
			//cbbar.fontSize = _fontSize;
			cbbar.backgroundType = this._backgroundType;
			
			
			cbbar.addEventListener(ControlEvent.SELECT,onBarSelectHandler);
			
			
			
			cbbar.defaultLabel = _label;
			
			//_maxHeight = this.component.getMaxListHeight();
			
			list= new ListChild();
			
			
			list.visible = false;
			//addEventListener (Event.CHANGE,onChangeHandler);
			list.addEventListener(ControlEvent.CHANGE,onChangeHandler);
			list.addEventListener(ControlEvent.ITEM_RENDERER_SELECT,onItemRenderereHandler);
			
		}
		
		override public function dispose():void
		{
			if(list){
				if(list.parent){
					list.parent.removeChild(list);
				}
			}
			list.removeEventListener(ControlEvent.CHANGE,onChangeHandler);
			list.removeEventListener(ControlEvent.ITEM_RENDERER_SELECT,onItemRenderereHandler);
			cbbar.removeEventListener(ControlEvent.SELECT,onBarSelectHandler);
			if (stage) 
			{
				
				stage.removeEventListener (MouseEvent.MOUSE_DOWN,onStageDownHandler);
			}
			
			
			super.dispose();
		}
		
		private var _maxHeight:int =-1;
		
		public function get itemCellRenaderer():Class
		{
			if(list.itemCellRenaderer){
				return list.itemCellRenaderer;
			}
			return ItemCellRenaderer;
		}
		
		public function setMaxHeight(h:int=-1):void{
			if(_maxHeight != h){
				_maxHeight = h;					
				this.updateUI();
			}
			
		}
		private function onItemRenderereHandler(event:ControlEvent):void
		{
			this.dispatchEvent(event.cloneEvent());
		}
		
		public function set itemCellRenaderer(value:Class):void
		{
			if(ItemCellRenaderer != value){
				ItemCellRenaderer = value;
				this.updateUI();
			}
			
		}
		
		public function get listData():ListData
		{
			return _listData;
		}
		
		/**
		 * ILabel  的引用  
		 * @return 
		 * 
		 */
		/*public function get ilable():ILabel
		{
		return cbbar.labelTxt;
		}*/
		
		
		
		[Inspectable(enumeration="background_default,background_none,background_over,backround_rb",defaultValue="background_default")]
		/**
		 * 背景类型 
		 */
		public function get backgroundType():String
		{
			return _backgroundType;
		}
		
		/**
		 * @private
		 */
		public function set backgroundType(value:String):void
		{
			if(_backgroundType!=value){
				_backgroundType = value;				
				cbbar.backgroundType = _backgroundType;
			}			
		}
		
		/*public function set selectedItem(value:IFListItem):void
		{
		_selectedItem = value;
		}*/	
		
		[Inspectable(defaultValue ="default label")]
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if(_label!=value){
				_label = value;
				
				this.cbbar.defaultLabel = _label;
				//this.updateUI();
			}
			
		}
		
		
		[Inspectable(defaultValue="0xffffff")]
		public function get fontColor():String
		{
			return _fontColor;
		}
		
		public function set fontColor(value:String):void
		{
			
			_fontColor = value;
			cbbar.fontColor = _fontColor;
		}
		[Inspectable(defaultValue="10")]
		public function get fontSize():String
		{
			return _fontSize;
		}
		
		public function set fontSize(value:String):void
		{
			_fontSize = value;
			//cbbar.fontSize = _fontSize;
		}
		
		private function onChangeHandler (event:ControlEvent):void
		{
			
			//Console.out(list,list.currentList,list.currentList.currentItem,list.currentList.currentItem.data,list.currentList.currentItem.data.label);
			_selectedIndex = list.currentList.selectedIndex;			
			_selectedItem= list.currentList.currentItem.data;
			
			_listData = list.currentList.currentItem.listData;
			
			//this.label = list.currentList.currentItem.data.label;
			//selectedIndex = _selectedIndex;
			
			if(_selectedItem){				
				//cbbar.label = _selectedItem.label;				
			}			
			//Log.out(list.currentList.currentItem is DisplayItem);
			
			this.cbbar.displayItem = list.currentList.currentItem as DisplayItem;
			
			if(!component.listDropNotHide){				
				list.visible = false;
			}
			
			
			this.dispatchEvent(event.cloneEvent());
			
		}
		
		/**
		 * 下拉的 List 实例 
		 * @see com.sanbeetle.component.List
		 * @return 
		 * 
		 */
		public function get dropdown ():ListChild
		{
			return list;
		}
		/**
		 * 当前选择的项 
		 * @return 
		 * 
		 */
		public function get selectedItem ():Object
		{
			return _selectedItem;
		}		
		/**
		 * 选中的索引号， 如果为 -1 时，没有选中，默认为 数据的第0元素
		 * @return 
		 * 
		 */
		[Inspectable(defaultValue=-1)]
		public function get selectedIndex ():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex (value:int):void
		{
			if(_selectedIndex!==value){
				_selectedIndex = value;		
				this.updateUI();
			}
			
		}
		private function onBarSelectHandler (event:ControlEvent):void
		{
			
			if (list.visible)
			{
				if(!component.listDropNotHide){
					list.visible = false;
					if(list.parent){
						list.parent.removeChild(list);
					}
					list.cleanUp();
				}				
				return;
			}
			
			list.visible = true;
			list.x = cbbar.cx;
			list.y = this.trueHeight+4;
			//this.addChild (list);
			var point:Point = this.localToGlobal(new Point(list.x,list.y));
			list.x = point.x;
			list.y = point.y;
			stage.addChild (list);		
			
			stage.addEventListener (MouseEvent.MOUSE_DOWN,onStageDownHandler);
			
			
			
		}
		
		private function onStageDownHandler (event:MouseEvent):void
		{
			if(this.component.listDropNotHide){
				
			}else{
				if(!Utils.isChild(list,DisplayObject(event.target)) && !Utils.isChild(this,DisplayObject(event.target))){
					if(stage){
						stage.removeEventListener (MouseEvent.MOUSE_DOWN,onStageDownHandler);
					}
					
					list.visible = false;
					if(list.parent){
						list.parent.removeChild(list);
					}
					list.cleanUp();
				}		
			}
		}
		[Collection(collectionClass = "com.sanbeetle.data.DataProvider",identifier = "item",collectionItem = "com.sanbeetle.data.SimpleCollectionItem")]
		/**
		 * 数据，元素  com.sanbeetle.data.SimpleCollectionItem
		 * @see com.sanbeetle.data.SimpleCollectionItem
		 * @see com.sanbeetle.data.DataProvider
		 */
		public function get dataProvider ():DataProvider
		{
			return _dataProvider;
		}
		
		public function set dataProvider (value:DataProvider):void
		{
			
			if(_dataProvider != value && _dataProvider!=null){
				_dataProvider = value;
				this.updateUI ();
			}
			
		}		
		override public function createUI ():void
		{
			this.addChild (cbbar);			
			
			list.setMinWidth(trueWidth);
			list.y = 4;	
			
			updateUI ();
		}
		
		override protected function updateUI ():void
		{
			//list.width = 100;
			
			//list.height = 50;
			
			
			list.setMaxHeight(_maxHeight);
			
			
			//list.setMaxHeight(50);
			
			cbbar.width = this.trueWidth;
			cbbar.height = this.trueHeight;
			
			
			
			
			//list.width = this.trueWidth;
			
			if(ItemCellRenaderer!=null){
				list.itemCellRenaderer = ItemCellRenaderer;
			}
			
			this.list.dataProvider = this._dataProvider;
			
			
			
			
			//list.width = 500;
			
			if (dataProvider!=null)
			{
				if (dataProvider.length < 1)
				{
					return;
				}
				
				if(_selectedIndex==-1){
					return;
				}
				if (_selectedIndex>dataProvider.length-1)
				{
					_selectedIndex = dataProvider.length - 1;
				}	
				
				_selectedItem = this.dataProvider.getItemAt(_selectedIndex) as IFListItem;
				if (_selectedItem==null)
				{
					//cbbar.label = _label;
					//btn.label = "";
					//Log.out(this.itemCellRenaderer,0);
					cbbar.defaultLabel = _label;
				}
				else
				{
					if(itemCellRenaderer!=null){
						var te:ICellRenderer = new itemCellRenaderer();
						
						//te.data = _selectedItem as IFListItem;
						cbbar.displayItem = te.createItem(_selectedItem,new ListData(_selectedItem,0,_selectedIndex,null)) as DisplayItem;
						
						//Log.out(this.itemCellRenaderer,1);
						//cbbar.label = _selectedItem.label;
					}
					
				}				
			}
			
		}
		
		
	}
	
}