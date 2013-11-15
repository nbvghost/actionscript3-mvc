package com.sanbeetle.component
{

	import com.sanbeetle.component.child.LeftLibelButton;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.ComboBox_downSkin;
	import com.sanbeetle.skin.ComboBox_overSkin;
	import com.sanbeetle.skin.ComboBox_upSkin;
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
	public class ComboBox extends UIComponent
	{

		private var _dataProvider:DataProvider;

		private var btnUp:ComboBox_upSkin;
		private var btnOver:ComboBox_overSkin;
		private var btnDown:ComboBox_downSkin;

		private var _selectedIndex:int = -1;
		private var _selectedItem:Object = null;

		private var btn:LeftLibelButton;
		private var list:List;
		
		private var _label:String="下拉框";
		
		private var _listHeight:int = 100;
		

		public function ComboBox ()
		{
			btnUp = new ComboBox_upSkin();
			btnOver = new ComboBox_overSkin();
			btnDown = new ComboBox_downSkin();

			btn = new LeftLibelButton(btnUp,btnOver,btnDown);
			//btn.mouseChildren = false;
			btn.addEventListener (MouseEvent.CLICK,onMouseListHandler);
			/*btn.autoSize = TextFieldAutoSize.NONE;
			btn.align = TextFormatAlign.LEFT;
			btn.label="dsfds";*/
			list= new List();
			list.visible = false;
			//addEventListener (Event.CHANGE,onChangeHandler);
			list.addEventListener(ControlEvent.CHANGE,onChangeHandler);
		}
		[Inspectable(defaultValue = 100)]
		public function get listHeight():int
		{
			return _listHeight;
		}

		public function set listHeight(value:int):void
		{
			if(_listHeight!=value){
				_listHeight = value;
				this.updateUI();
			}			
		}

		[Inspectable(defaultValue = "下拉框")]
		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			if(_label!=value){
				_label = value;
				this.updateUI();
			}
			
		}

		private function onChangeHandler (event:ControlEvent):void
		{
			_selectedIndex = list.selectedIndex;
			selectedIndex = _selectedIndex;
			list.visible = false;
			this.dispatchEvent(new ControlEvent(event.type,event.data));
		}

		/**
		 * 下拉的 List 实例 
		 * @see com.sanbeetle.component.List
		 * @return 
		 * 
		 */
		public function get dropdown ():List
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
		[Inspectable(defaultValue = -1)]
		/**
		 * 选中的索引号， 如果为 -1 时，没有选中，默认为 数据的第0元素
		 * @return 
		 * 
		 */
		public function get selectedIndex ():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex (value:int):void
		{
			_selectedIndex = value;		
			this.updateUI();
		}
		private function onMouseListHandler (event:MouseEvent):void
		{
			if (list.visible)
			{
				return;
			}
			list.visible = true;
			list.x = 0;
			list.y = this.trueHeight;
			this.addChild (list);
			var point:Point = this.localToGlobal(new Point(list.x,list.y));
			stage.addChild (list);
			list.x = point.x;
			list.y = point.y;
			stage.addEventListener (MouseEvent.MOUSE_DOWN,onStageDownHandler);
		}

		private function onStageDownHandler (event:MouseEvent):void
		{
			if(!Utils.isChild(list,DisplayObject(event.target)) && !Utils.isChild(this,DisplayObject(event.target))){
				
				stage.removeEventListener (MouseEvent.MOUSE_DOWN,onStageDownHandler);
				list.visible = false;
			}
			/*if (!(event.target is IListBoxItem) && !(event.target is NonePaddinIListBox) &&
			!(event.target is IVScrollBarSkin_top)&& 
			!(event.target is IVScrollBarSkin_bar)&& 
			!(event.target is SimpleButton)&& 
			!(event.target is IListBoxBgB)&&
			!(event.target is IVScrollBarSkin_buttom))
			{
				
			}*/

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
			_dataProvider = value;
			this.updateUI ();
		}


		override protected function createUI ():void
		{
			this.addChild (btn);
			updateUI ();
		}

		override protected function updateUI ():void
		{
			btn.width = this.trueWidth;
			btn.height = this.trueHeight;

			list.width = this.trueWidth;
			list.height =_listHeight;

			this.list.dataProvider = this.dataProvider;			
			
			btn.label = _label;
			
			if (dataProvider!=null)
			{
				if (dataProvider.length < 1)
				{
					return;
				}
				
				if(_selectedIndex==-1){
					return;
				}
				if (_selectedIndex>dataProvider.length)
				{
					_selectedIndex = dataProvider.length - 1;
				}
				
				_selectedItem = this.dataProvider.getItemAt(_selectedIndex);
				if (_selectedItem==null)
				{
					btn.label = "";
				}
				else
				{
					btn.label = _selectedItem.label;
				}				
			}

		}


	}

}