package com.sanbeetle.component
{
	import com.asvital.debug.Console;
	import com.sanbeetle.component.child.ExtendButton;
	import com.sanbeetle.component.child.IListBoxItem;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.ListChildItem;
	import com.sanbeetle.events.ChangeIndexEvent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.TabButton_left_down_gray;
	import com.sanbeetle.skin.TabButton_left_over_gray;
	import com.sanbeetle.skin.TabButton_left_up_gray;
	import com.sanbeetle.skin.TabButton_mid_down_gray;
	import com.sanbeetle.skin.TabButton_mid_over_gray;
	import com.sanbeetle.skin.TabButton_mid_up_gray;
	import com.sanbeetle.skin.TabButton_right_down_gray;
	import com.sanbeetle.skin.TabButton_right_over_gray;
	import com.sanbeetle.skin.TabButton_right_up_gray;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * 
	 * 二级菜单发生改变时
	 * 
	 */	
	[Event(name="change",type="com.sanbeetle.events.ControlEvent")]	
	
	[Event(name="change_index",type="com.sanbeetle.events.ChangeIndexEvent")]
	/**
	 *
	 *@author sixf
	 */
	public class ITabButton extends UIComponent
	{
		protected var _data:Array = ["left","center","right"];
		//private var _data:Array;		
		
		private const left:String="left";
		private const mid:String="mid";
		private const right:String="right";
		
		private var _fontColor:String = "0xffffff";
		private var _backgroundColor:String = "0x000000";
		
		private var _selectIndex:int=-1;
		private var _fontSize:String="10";
		
		protected var btnArr:Array=new Array();
		private var _oldButton:ExtendButton;
		
		private var _childData:Array=[];
		
		private var list:List;
		
		private var childList:List;
		
		private var ListClass:Class;
		

		private var _bold:Boolean = true;
		private var _requestSelect:Boolean = true;
		
		public function ITabButton()
		{
			super();
			
			list=new List();
			childList = new List();
			childList.addEventListener(ControlEvent.CHANGE,onChildListChangeHandler);
			list.addEventListener(ControlEvent.CHANGE,onListChangeHandler);
			list.addEventListener(ControlEvent.ITEM_OVER,onItemOverHandler);
		}
		[Inspectable(defaultValue=true)]
		public function get requestSelect():Boolean
		{
			return _requestSelect;
		}

		public function set requestSelect(value:Boolean):void
		{
			if(_requestSelect!=value){
				_requestSelect = value;
				this.updateUI();
			}
			
		}

		[Inspectable(defaultValue=true)]		
		public function get bold():Boolean
		{
			return _bold;
		}

		public function set bold(value:Boolean):void
		{
			if(_bold!=value){
				_bold = value;
				this.updateUI();
			}
			
		}

		protected function onChildListChangeHandler(event:ControlEvent):void
		{
			this.list.visible =false;
			this.childList.visible =false;
			this.dispatchEvent(new ControlEvent(event.type,event.data));
		}
		
		protected function onListChangeHandler(event:ControlEvent):void
		{
			this.list.visible =false;
			this.childList.visible =false;
			this.dispatchEvent(new ControlEvent(event.type,event.data));
		}
		
		private function onItemOverHandler(event:ControlEvent):void
		{
			var item:IListBoxItem = list.currentItem;
			
			var cu:Point = item.parent.localToGlobal(new Point(item.x,item.y));
			
			var listChildItem:ListChildItem = list.currentItem.data as ListChildItem;
			if(listChildItem!=null){
				
				if(listChildItem.childs!=null){
					/*childList.x = cu.x+list.width;
					childList.y = cu.y;	*/
					childList.x =list.x+list.width;
					childList.y = cu.y;	
					
					childList.dataProvider = listChildItem.childs;
					childList.visible =true;
					stage.addChild(childList);
				}else{
					if(childList.parent){
						childList.parent.removeChild(childList);
					}
					
				}
				
				
			}
			
			
		}
		//[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.ListChildItem")]
		public function get childData():Array
		{
			return _childData;
		}
		public function set childData(value:Array):void
		{
			if(_childData!=value){
				_childData = value;
				this.updateUI();
			}			
		}
		
		[Inspectable(defaultValue = "-1")]		
		public function get selectIndex():int
		{
			return _selectIndex;
		}
		
		public function set selectIndex(value:int):void
		{
			_selectIndex = value;
			
			this.updateUI();
		}
		
		[Inspectable(defaultValue="10")]
		public function get fontSize():String
		{
			return _fontSize;
		}
		
		public function set fontSize(value:String):void
		{
			_fontSize = value;
			this.updateUI();
		}
		
		private function onClickHandle(event:MouseEvent):void
		{
			var oldIndex:int=-1;
			
			var item:ExtendButton = event.currentTarget as ExtendButton;
			if(item){	
				if(_oldButton!=null){
					if(_oldButton!=item){
						_oldButton.select =false;
						
					}					
					oldIndex = _oldButton.index;
				}
				if(_requestSelect){
					item.select =true;
				}				
				showList(item);
				_selectIndex = item.index;			
				
				this.dispatchEvent(new ChangeIndexEvent(ChangeIndexEvent.CHANGE_INDEX,_selectIndex,oldIndex));				
				
				if(_oldButton!=item){						
					
					//index = item.index;
					_oldButton= item;
				}			
				
			}
		}
		
		private function showList(current:ExtendButton):void
		{
			
			if(_childData==null){
				return;
			}else{
				
				this.list.visible =false;
				this.childList.visible =false;
			}
			var dataProvider:DataProvider =_childData[current.index];	
			
			if(dataProvider==null){
				this.list.visible =false;
				this.childList.visible =false;
				return;
			}	
			this.list.dataProvider = dataProvider;
			list.width = current.width*2;
			list.y = current.height;
			list.x = current.x;
			this.addChild(list);
			var cu:Point = this.localToGlobal(new Point(list.x,list.y));
			list.x = cu.x;
			list.y = cu.y;
			stage.addChild(list);
			list.visible =true;
			
			
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDoaneHadnler);				
			
		}		
		/**
		 * 
		 
		 
		 var cu:Point = content.globalToLocal(new Point(stage.mouseX,stage.mouseY));
		 if(content.hitTestPoint(cu.x,cu.y,true)){
		 return;
		 }
		 cu = (new Point(stage.mouseX,stage.mouseY));
		 if(list.hitTestPoint(cu.x,cu.y,true)){
		 return;
		 }else{
		 cu = (new Point(stage.mouseX,stage.mouseY));
		 if(childList.hitTestPoint(cu.x,cu.y,true)){
		 
		 }else{
		 list.visible =false;
		 childList.visible =false;
		 }
		 
		 
		 }		 
		 * @param event
		 * 
		 */
		private function onMouseDoaneHadnler(event:MouseEvent):void
		{	
			
			var tie:DisplayObject = event.target as DisplayObject;
			while(tie.parent){
				if(tie is ITabButton || tie is List){
					return;
				}else{
					tie = tie.parent;
				}
			}			
			
			list.visible =false;
			childList.visible =false;
			stage.removeEventListener(MouseEvent.MOUSE_OUT,onMouseDoaneHadnler);
		}
		[Inspectable(defaultValue="0x000000")]
		public function get backgroundColor():String
		{
			return _backgroundColor;
		}
		
		public function set backgroundColor(value:String):void
		{
			_backgroundColor = value;
			this.updateUI();
		}
		[Inspectable(defaultValue="0xffffff")]
		public function get fontColor():String
		{
			return _fontColor;
		}
		
		public function set fontColor(value:String):void
		{
			_fontColor = value;
			
			this.updateUI();
		}
		
		override protected function createUI():void
		{		
			
			
			
			updateUI();
			
			
			
			/*var list:List = new List();
			this.addChild(list);*/
			
		}	
		
		override protected function updateUI():void
		{
			
			for each(var btn:ExtendButton in  btnArr){
				if(btn.parent!=null){
					btn.parent.removeChild(btn);
				}
			}
			
			btnArr.splice(0,btnArr.length);		
			if(_data.length==0){
				return;
			}
			
			var w:Number = 0;
			var itew:Number = this.trueWidth / _data.length;		
			
			
			if(_data.length==1){
				//var one:ExtendButton = new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);
				var one:ExtendButton = createMidButton();
				one.width = itew;			
				one.height = this.trueHeight;	
				one.label = _data[0];
				
				addChild(one);
				btnArr.push(one);
				setButonStyle(one);
				return;
			}else{
				//var left:ExtendButton = new ExtendButton(new TabButton_left_up_gray(),new TabButton_left_over_gray,new TabButton_left_down_gray);		
				var left:ExtendButton = createLeftButton();
				left.width = itew;			
				left.height = this.trueHeight;		
				left.label = _data[0];	
				Console.out("components"+this.trueHeight);
				addChild(left);			
				left.index = 0;
				w = left.width-1;
				btnArr.push(left);
				setButonStyle(left);
			}	
			
			
			
			if(data.length==2){
				
				//var right:ExtendButton = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);
				var right:ExtendButton =  createRightButton();
				
				right.width = itew;
				right.height = this.trueHeight;	
				right.label = _data[1];		
				
				addChild(right);
				right.y = 0;
				right.x = w;
				right.index=1;
				btnArr.push(right);
				setButonStyle(right);
				return;
			}
			for(var i:int=1;i<data.length-1;i++){
				
				//var mid:ExtendButton = new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);	
				var mid:ExtendButton = createMidButton();
				mid.width = itew;
				mid.height = trueHeight;	
				mid.label = data[i];
				
				mid.index = i;				
				addChild(mid);
				mid.x = w;
				//mid.y =50;
				w +=  mid.width-1;
				btnArr.push(mid);
				setButonStyle(mid);
				
			}					
			//Console.out("components"+"components"+"-----------------------"+_data.length);			
			if(data.length>0){
				
				//var right_a:ExtendButton = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);		
				var right_a:ExtendButton =  createRightButton();
				right_a.width = itew;
				right_a.height = this.trueHeight;		
				right_a.label = _data[data.length-1];		
				
				addChild(right_a);
				right_a.y = 0;
				right_a.x = w;
				right_a.index = data.length-1;
				btnArr.push(right_a);	
				setButonStyle(right_a);
			}
		}
		
		protected function createLeftButton():ExtendButton{
			return new ExtendButton(new TabButton_left_up_gray,new TabButton_left_over_gray,new TabButton_left_down_gray);
			/*switch(sideType){
				case SIDE_BUTTOM:
				case SIDE_TOP:
					
					break;
				case SIDE_RIGHT:
				case SIDE_LEFT:
					return new ExtendButton(new TabButton_left_left_up,new TabButton_left_left_over,new TabButton_left_left_down);
					break;
			}
			return null;*/
		}
		protected function createMidButton():ExtendButton{
			return new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);
			/*switch(sideType){
				case SIDE_BUTTOM:
				case SIDE_TOP:
					
					break;
				case SIDE_RIGHT:
				case SIDE_LEFT:
					return new ExtendButton(new TabButton_left_mid_up,new TabButton_left_mid_over,new TabButton_left_mid_down);
					break;
			}
			return null;*/
		}
		protected function createRightButton():ExtendButton{
			return new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);
			/*switch(sideType){
				case SIDE_BUTTOM:
				case SIDE_TOP:
					
					break;
				case SIDE_RIGHT:
				case SIDE_LEFT:
					return new ExtendButton(new TabButton_left_right_up,new TabButton_left_right_over,new TabButton_left_right_down);
					break;
			}
			return null;*/
		}
	
		protected function setButonStyle(btn:ExtendButton):void{	
			btn.addEventListener(MouseEvent.MOUSE_DOWN,onClickHandle);	
			btn.color = _fontColor;		
			btn.fontSize = _fontSize;			
			btn.backgroundColor = _backgroundColor;
			btn.bold =bold;
			if(requestSelect){
				if(btn.index==this._selectIndex){
					if(this._oldButton!=null){
						_oldButton.select =false;
					}
					btn.select=true;				
					_oldButton = btn;
					
				}else{
					btn.select =false;
				}
			}else{
				
			}
			
			
		}
		[Inspectable(type = "Array",defaultValue = "left,center,right")]		
		public function get data():Array
		{
			return _data;
		}
		public function set data(value:Array):void
		{			
			this._data = value;		
			updateUI();
		}
		
	}
}