package com.sanbeetle.component
{
	import com.sanbeetle.core.UIComponent;
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


	/**
	 *
	 *@author sixf
	 */
	public class ITabButton extends UIComponent
	{
		private var _data:Array = ["left","center","right"];
		private var left:ExtendButton;
		private var right:ExtendButton;
		private var _fontColor:String = "0x000000";
		private var _backgroundColor:String = "";

		private var btnArr:Array=new Array();

		public function ITabButton()
		{
			super();
			

		}
		[Inspectable]
		public function get backgroundColor():String
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:String):void
		{
			_backgroundColor = value;
			this.updateUI();
		}
		[Inspectable]
		public function get fontColor():String
		{
			return _fontColor;
		}

		public function set fontColor(value:String):void
		{
			_fontColor = value;
			this.updateUI();
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

		private function getSkinObject(name:String):DisplayObject
		{
			var Skin:Class = this.loaderInfo.applicationDomain.getDefinition(name) as Class;
			
			return new Skin();
		}
		override protected function createUI():void
		{			
						
			updateUI();
			
		}		
		override protected function updateUI():void
		{
			
			for each(var btn:ExtendButton in  btnArr){
				if(btn.parent!=null){
					btn.parent.removeChild(btn);
				}
			}
			
			btnArr.splice(0,btnArr.length);		
			if(data.length==0){
				return;
			}
			
			var w:Number = 0;
			var itew:Number = this.trueWidth / data.length;
			
			
			left = new ExtendButton(new TabButton_left_up_gray(),new TabButton_left_over_gray,new TabButton_left_down_gray);
			
					
			left.width = itew;			
			left.height = this.trueHeight;		
			left.label = _data[0];	
			left.color = _fontColor;
			left.backgroundColor = _backgroundColor;		
			this.addChild(left);			
			
			w = left.width;
			btnArr.push(left);						
			
			if(data.length==2){
				
				right = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);
				
				
				right.width = itew;
				right.height = this.trueHeight;	
				right.label = _data[1];		
				right.color = _fontColor;
				right.backgroundColor = _backgroundColor;
				this.addChild(right);
				right.y = 0;
				right.x = w;
				btnArr.push(right);
				return;
			}
			for(var i:int=1;i<data.length-1;i++){
				
				var mid:ExtendButton = new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);
				
				mid.width = itew;
				mid.height = trueHeight;	
				mid.label = data[i];
				mid.color = _fontColor;
				mid.backgroundColor = _backgroundColor;
				this.addChild(mid);
				mid.x = w;
				//mid.y =50;
				w +=  mid.width;
				btnArr.push(mid);
				
			}					
			//trace("-----------------------"+_data.length);			
			if(data.length>0){
				
				right = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);
						
				right.width = itew;
				right.height = this.trueHeight;		
				right.label = _data[data.length-1];		
				right.color = _fontColor;
				right.backgroundColor = _backgroundColor;
				this.addChild(right);
				right.y = 0;
				right.x = w;
				btnArr.push(right);
			}
		}
		
		
		override public function setSize(w:Number,h:Number):void
		{

			trueWidth = w;
			trueHeight = h;
	
			this.updateUI();
			
		}
	}
}