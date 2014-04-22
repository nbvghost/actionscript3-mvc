package com.sanbeetle.component
{
	import com.sanbeetle.component.child.ExtendButton;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
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
	import flash.utils.getTimer;
	
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
		
		private var list:ListChild;
		
		//private var childList:List;
		
		//private var ListClass:Class;
		
		
		private var _bold:Boolean = true;
		private var _requestSelect:Boolean = true;
		
		public function ITabButton()
		{
			super();
			
			list=new ListChild();
			
			list.addEventListener(ControlEvent.CHANGE,onListChangeHandler);
			
			
			data = _data;
		}
		
		public function get oldButton():ExtendButton
		{
			return _oldButton;
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
		
		protected function onListChangeHandler(event:ControlEvent):void
		{
			this.list.cleanUp();
			this.list.visible =false;
			if(list.parent){
				list.parent.removeChild(list);
			}
			
			this.dispatchEvent(new ControlEvent(event.type,event.data));
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
			
			
			
			var oldIndex:int = _selectIndex;
			
			_selectIndex = value;
			
			this.updateUI();
			
			this.dispatchEvent(new ChangeIndexEvent(ChangeIndexEvent.CHANGE_INDEX,_selectIndex,oldIndex));	
			
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
		
		protected function onClickHandle(event:MouseEvent):void
		{
			var oldIndex:int=_selectIndex;
			
			var item:ExtendButton = event.currentTarget as ExtendButton;
			if(item){	
				if(_oldButton!=null){
					if(_oldButton!=item){
						_oldButton.select =false;
						
					}		
					if(_oldButton.parent){
						this.setChildIndex(_oldButton,_oldButton.index);
					}
					oldIndex = _oldButton.index;
				}
				if(_requestSelect){
					item.select =true;
				}				
				showList(item);
				_selectIndex = item.index;	
				
				if(item.parent){
					this.setChildIndex(item,this.numChildren-1);
				}
				
				if(_oldButton!=item){						
					
					_oldButton= item;
					
				}			
				this.dispatchEvent(new ChangeIndexEvent(ChangeIndexEvent.CHANGE_INDEX,_selectIndex,oldIndex));				
				
			}
		}
		
		protected function showList(current:ExtendButton):void
		{
			if(list){
				list.cleanUp();
				list.visible =false;
				if(list.parent){
					list.parent.removeChild(list);
					list.setMinWidth(trueWidth);
					list.cleanUp();
				}
			}
			
			if(_childData==null){
				
				return;
			}
			
			var dataProvider:DataProvider =_childData[current.index];	
			
			if(dataProvider==null){
				
				return;
			}	
			
			if(current.width<this.component.getMinListWidth()){
				list.setMinWidth(this.component.getMinListWidth());
			}else{
				list.setMinWidth(current.width);
			}
			//list.setMaxHeight(current.width);
			
			
			this.list.dataProvider = dataProvider;		
			this.list.upDisplayList();
			
			
			
			list.y = current.height+4;
			list.x = current.x;
			//this.addChild(list);
			var cu:Point = this.localToGlobal(new Point(list.x,list.y));
			list.x = cu.x;
			list.y = cu.y;
			stage.addChild(list);
			list.visible =true;	
			
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDoaneHadnler);				
			
		}		
		
		override public function dispose():void
		{
			
			super.dispose();
			
			if(stage){
				
				stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDoaneHadnler);	
			}
			
			for (var i:int = 0; i <this.btnArr.length; i++) 
			{
				btnArr[i].removeEventListener(MouseEvent.MOUSE_DOWN,onClickHandle);	
				btnArr[i].dispose();
			}
			
			if(list){
				
				list.removeEventListener(ControlEvent.CHANGE,onListChangeHandler);
				
				list.dispose();
				list=null;
			}
			
			
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
			if(!component.listDropNotHide){
				var tie:DisplayObject = event.target as DisplayObject;
				if(tie){
					while(tie.parent){
						if(tie is ITabButton || tie is List){
							return;
						}else{
							tie = tie.parent;
						}
					}			
				}
				
				this.list.cleanUp();
				list.visible =false;
				if(list.parent){
					list.parent.removeChild(list);
				}
				
				if(stage){
					stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDoaneHadnler);
				}
			}
			
			
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
		
		override public function createUI():void
		{		
			
			
			
			//updateUI();
			
			
			
			
			
		}	
		protected function selectButton(btn:ExtendButton):Boolean{
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
			return btn.select;
		}
		
		override public function upDisplayList():void
		{
			updateUI();
		}
		
		
		override protected function updateUI():void
		{
			
			
			var w:Number = 0;
			var itew:Number = this.trueWidth / _data.length;		
			
			var currentBtn:ExtendButton;
			
			for (var j:int = 0; j < btnArr.length; j++) 
			{
				currentBtn=btnArr[j];
				currentBtn.width = itew;			
				currentBtn.height = trueHeight;	
				
				currentBtn.y = 0;
				currentBtn.x = w;
				
				w += currentBtn.width-1;	
				
				selectButton(currentBtn);
				
			}
			
			/*if(_data.length==1){
			var one:ExtendButton = createMidButton();
			one.width = itew;			
			one.height = this.trueHeight;	
			one.label = _data[0];
			
			addChild(one);
			btnArr.push(one);
			setButonStyle(one);
			return;
			}else{
			var left:ExtendButton = createLeftButton();
			left.width = itew;			
			left.height = this.trueHeight;		
			left.label = _data[0];	
			addChild(left);			
			left.index = 0;
			w = left.width-1;
			btnArr.push(left);
			setButonStyle(left);
			}	
			
			
			
			if(data.length==2){
			
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
			
			var mid:ExtendButton = createMidButton();
			mid.width = itew;
			mid.height = trueHeight;	
			mid.label = data[i];
			
			mid.index = i;				
			addChild(mid);
			mid.x = w;
			w +=  mid.width-1;
			btnArr.push(mid);
			setButonStyle(mid);
			
			}					
			if(data.length>0){
			
			var right_a:ExtendButton =  createRightButton();
			right_a.width = itew;
			right_a.height = this.trueHeight;		
			right_a.label = _data[data.length-1];		
			
			addChild(right_a);
			right_a.y = 0;
			right_a.x = w;
			right_a.index = data.length-1;
			}*/
		}
		
		protected function createLeftButton():ExtendButton{
			return new ExtendButton(new TabButton_left_up_gray,new TabButton_left_over_gray,new TabButton_left_down_gray);
			
		}
		protected function createMidButton():ExtendButton{
			return new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);
			
		}
		protected function createRightButton():ExtendButton{
			return new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);
			
		}
		
		protected function setButonStyle(btn:ExtendButton):void{	
			btn.addEventListener(MouseEvent.MOUSE_DOWN,onClickHandle);	
			btn.color = _fontColor;		
			btn.fontSize = _fontSize;			
			btn.backgroundColor = _backgroundColor;
			btn.bold =bold;
			
			
			
		}
		[Inspectable(type = "Array",defaultValue = "left,center,right")]		
		public function get data():Array
		{
			return _data;
		}
		protected function removeEvent(btn:ExtendButton):void{
			
			btn.removeEventListener(MouseEvent.MOUSE_DOWN,onClickHandle);	
			if(btn.parent){				
				btn.parent.removeChild(btn);
			}			
		}
		public function set data(value:Array):void
		{			
			
			var t:Number = getTimer();
			
			for each(var btn:ExtendButton in  btnArr){
				if(btn.parent!=null){
					
					removeEvent(btn);					
					//btn.dispose();
				}
			}
			
			btnArr.splice(0,btnArr.length);	
			
			this._data = value;	
			
			if(_data.length==1){
				//var one:ExtendButton = new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);
				var one:ExtendButton = createMidButton();
				one.label = _data[0];
				
				addChild(one);
				btnArr.push(one);
				setButonStyle(one);
				updateUI();
				return;
			}else{
				//var left:ExtendButton = new ExtendButton(new TabButton_left_up_gray(),new TabButton_left_over_gray,new TabButton_left_down_gray);		
				var left:ExtendButton = createLeftButton();
				left.label = _data[0];	
				//Log.out("components"+this.trueHeight);
				addChild(left);			
				left.index = 0;
				btnArr.push(left);
				setButonStyle(left);
			}	
			
			
			
			if(data.length==2){
				
				//var right:ExtendButton = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);
				var right:ExtendButton =  createRightButton();
				right.label = _data[1];		
				addChild(right);
				right.index=1;
				btnArr.push(right);
				setButonStyle(right);
				updateUI();
				return;
			}
			for(var i:int=1;i<data.length-1;i++){
				
				//var mid:ExtendButton = new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);	
				var mid:ExtendButton = createMidButton();
				mid.label = data[i];
				mid.index = i;				
				addChild(mid);
				btnArr.push(mid);
				setButonStyle(mid);
				
			}					
			//Console.out("components"+"components"+"-----------------------"+_data.length);			
			if(data.length>0){
				
				//var right_a:ExtendButton = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);		
				var right_a:ExtendButton =  createRightButton();
				right_a.label = _data[data.length-1];		
				
				addChild(right_a);
				right_a.index = data.length-1;
				btnArr.push(right_a);	
				setButonStyle(right_a);
			}
			
			updateUI();
			
		}
		
	}
}