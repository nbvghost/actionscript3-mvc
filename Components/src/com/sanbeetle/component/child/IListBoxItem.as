package com.sanbeetle.component.child {
	
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.skin.IListBoxItemBg;
	
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	
	public class IListBoxItem extends MovieClip {
		
		private var label:ILabel;
		private var _bg:IListBoxItemBg;
		
		private var _data:IFListItem;
		
		private var _index:int =-1;	
		
		private var _textWidth:int =0;
		
		public function IListBoxItem() {
			this.buttonMode =true;
			label = new ILabel();
			
			_bg = ItemBg;
			this.addChild(bg);
			bg.mouseEnabled = false;
			bg.mouseChildren =false;
			label.mouseChildren = false;
			label.mouseEnabled = false;
			label.leading = 0;
			//label.border =true;
			label.autoSize = TextFieldAutoSize.LEFT;
			//label.color = color;
			
			//label.width = 100;
			//label.align = TextFormatAlign.LEFT;			
			//label.autoSize = TextFieldAutoSize.LEFT;
			//Console.out("components"+"components"+"iladel"+iladel.width);
			label.fontSize = "12";			
			
			label.height=20;			
			label.mouseEnabled =false;
			label.mouseChildren = false;
			//iladel.border =true;
			label.x = 8;
			
			this.addChild(label);
			//this.width = 100;
			//this.height =20;
			
			this.addEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,onOverHandler);
		}
		
		
		
		public function get bg():IListBoxItemBg
		{
			return _bg;
		}

		public function get textWidth():int
		{
			return this.label.width;
		}		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		protected function get ItemBg():IListBoxItemBg{
			
			return new IListBoxItemBg();
		}
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return bg.height;
		}
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			bg.height = value;
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			bg.width = value;
			//label.width =value;
			drawLine();
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return bg.width;
		}
		
		
		public function get data():IFListItem
		{
			return _data;
		}
		
		public function set data(value:IFListItem):void
		{
			_data = value;		
			
			drawLine();	
			
			this.mouseEnabled = value.enable;
			//Console.out("components"+value.itemColor);
			label.color=_data.itemColor;
			//label.color = "0xffffff";
			label.text = _data.label;
			
			
			//Console.out("components"+textMaxWidth);
		}
		private function drawLine():void{			
			if(_data==null){
				return;
			}
			if(_data.label=="-" || _data.data=="-"){
				if(label.parent){
					label.parent.removeChild(label);
				}
				if(bg.parent){
					bg.parent.removeChild(bg);
				}			
				
				bg.height = 9;
				
				this.graphics.clear();
				this.graphics.lineStyle(1,0x000000,0.24,false,LineScaleMode.VERTICAL,CapsStyle.NONE);
				this.graphics.moveTo(0,4);
				this.graphics.lineTo(this.width,4);
				
			}else{
				
				return;
			}
			
		}
		/**
		 * 项的字体颜色
		 * @param value
		 * @return 
		 * 
		 */
		protected function itemColor(value:IFListItem):String{
			return value.itemColor;
		}
		protected function itemOverColor(value:IFListItem):String{
			return value.itemOverColor;
		}
		private function onOverHandler(event:MouseEvent):void
		{
			bg.gotoAndStop(2);
			label.color = itemOverColor(_data);
		}
		
		private function onOutHandler(event:MouseEvent):void
		{
			bg.gotoAndStop(1);
			label.color = itemColor(_data);
		}
		
	}
	
}
