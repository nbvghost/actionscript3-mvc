package com.sanbeetle.skin {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	
	import flash.events.MouseEvent;
	
	import fl.data.DataProvider;
	import fl.data.SimpleCollectionItem;
	
	[Event(name="change",type="com.sanbeetle.events.ControlEvent")]	
	public class IListBox extends UIComponent {
		
		private var bg:IListBoxBg=new IListBoxBg();
		private var _dataProvider:DataProvider;
		private var itemArr:Array=new Array();
		private var _boxWidth:int = 120;
		public function IListBox() {
		
			this.addChild(bg);
			bg.width = 100;
			bg.mouseEnabled = false;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			
			
			
			/*this.dataProvider =new DataProvider();
			this.dataProvider.addItem(new SimpleCollectionItem("sdf","dsfds"));
			this.dataProvider.addItem(new SimpleCollectionItem("sdf","dsfds"));
			this.dataProvider.addItem(new SimpleCollectionItem("-","dsfds"));
			this.dataProvider.addItem(new SimpleCollectionItem("sdf","dsfds"));
			this.dataProvider.addItem(new SimpleCollectionItem("sdf","dsfds"));
			this.dataProvider.addItem(new SimpleCollectionItem("sdf","-"));
			this.dataProvider.addItem(new SimpleCollectionItem("sdf","dsfds"));
			this.dataProvider.addItem(new SimpleCollectionItem("sdf","dsfds"));
			dataProvider = dataProvider;*/
		}
		[Inspectable(defaultValue = 120)]
		public function get boxWidth():int
		{
			return _boxWidth;
		}

		public function set boxWidth(value:int):void
		{
			_boxWidth = value;
			this.bg.width = value;
		}

		protected function onMouseDownHandler(event:MouseEvent):void
		{
			//trace("dsfds",event.target);
			if(event.target is IListBoxItem){
				this.dispatchEvent(new ControlEvent(ControlEvent.CHANGE,IListBoxItem(event.target).data));
			}
		}
		[Collection(collectionClass="fl.data.DataProvider", identifier="item", collectionItem="fl.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}

		public function set dataProvider(value:DataProvider):void
		{
			_dataProvider = value;
			if(_dataProvider==null){
				return;
			}
			for(var o:int=0;o<itemArr.length;o++){
				this.removeChild(itemArr[o]);
				
			}
			itemArr.splice(0,itemArr.length);
			var h:Number=0;
			for(var i:int=0;i<_dataProvider.length;i++){
				var item:IListBoxItem = new IListBoxItem();
				item.width = this.width;
				item.data = SimpleCollectionItem(_dataProvider.getItemAt(i));
				
				item.y = h+9;
				this.addChild(item);
				itemArr.push(item);
				h =h+item.height;
			}
			bg.height=h+18;
			
		}

		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			//super.height = value;
			//bg.height = value;
			
			
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return bg.height;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return bg.width;
		}
		
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			//super.width = value;
			bg.width = value;
		}
		
	}
	
}
