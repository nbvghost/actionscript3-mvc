package com.sanbeetle.skin {
	
	import com.sanbeetle.component.ILabel;
	
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	import fl.data.SimpleCollectionItem;
	
	
	public class IListBoxItem extends MovieClip {
		
		private var label:ILabel;
		private var bg:IListBoxItemBg;
		
		private var _data:SimpleCollectionItem;
		
		public function IListBoxItem() {
			this.buttonMode =true;
			label = new ILabel();
			bg = new IListBoxItemBg();
			this.addChild(bg);
			bg.mouseEnabled = false;
			bg.mouseChildren =false;
			label.mouseChildren = false;
			label.mouseEnabled = false;
			
			label.align = TextFormatAlign.LEFT;
			
			label.autoSize = TextFieldAutoSize.LEFT;
			//trace("iladel"+iladel.width);
			label.fontSize = "12";
			label.height=20;
			label.mouseEnabled =false;
			label.mouseChildren = false;
			//iladel.border =true;
			label.x = 8;
					
			this.addChild(label);
			this.width = 100;
			this.height =20;
			
			this.addEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,onOverHandler);
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
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return bg.width;
		}
		
		
		public function get data():SimpleCollectionItem
		{
			return _data;
		}

		public function set data(value:SimpleCollectionItem):void
		{
			_data = value;		
			if(value.label=="-" || value.data=="-"){
				this.removeChild(label);
				this.removeChild(bg);
						
				this.height = 9;
				
				this.graphics.clear();
				this.graphics.lineStyle(1,0x000000,0.24,false,LineScaleMode.VERTICAL,CapsStyle.NONE);
				this.graphics.moveTo(0,4);
				this.graphics.lineTo(this.width,4);
				
				
				return;
			}
			label.text = _data.label;
		}	

		protected function onOverHandler(event:MouseEvent):void
		{
			bg.gotoAndStop(2);
			label.color = "0xffffff";
		}
		
		protected function onOutHandler(event:MouseEvent):void
		{
			bg.gotoAndStop(1);
			label.color = "0x333333";
		}
		
	}
	
}
