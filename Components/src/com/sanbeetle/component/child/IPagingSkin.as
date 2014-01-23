package com.sanbeetle.component.child {
	
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.component.ITextInput;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.RegExpType;
	import com.sanbeetle.skin.IPagingSkinContral;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import flashx.textLayout.formats.TextAlign;
	
	
	public class IPagingSkin extends UIComponent {
		
		
		public var djy_txt:ILabel;
		public var pageindex_txt:ITextInput;
		private var txt:ILabel;
		
		public var controlBar:IPagingSkinContral;
		
		private var _color:String="0x373B40";
		private var _colorOver:String="0x373B40";
		
		
		
		public function IPagingSkin() {
			
			controlBar = new IPagingSkinContral();
			this.addChild(controlBar);
			
			djy_txt = new ILabel();
			djy_txt.bold =true;
			djy_txt.color =color;
			djy_txt.fontSize ="10";		
			djy_txt.height = 17;
			djy_txt.width = 90;
			
			//djy_txt.border =false;
			//djy_txt.align =TextFormatAlign.RIGHT;
			djy_txt.textAlign = TextAlign.RIGHT;
			this.addChild(djy_txt);
			
			txt = new ILabel();
			//txt.selectable =true;
			txt.color = djy_txt.color;
			txt.x =  94;
			txt.fontSize = djy_txt.fontSize;
			txt.bold = djy_txt.bold;
			//txt.border = djy_txt.border;
			txt.height = djy_txt.height;
			txt.width = 24;
			txt.text="转到";
			//txt.align = TextFormatAlign.LEFT;
			txt.textAlign = TextAlign.LEFT;
			this.addChild(txt);
			
			pageindex_txt = new ITextInput();
			pageindex_txt.selectable =true;
			pageindex_txt.text = "0";
			pageindex_txt.color = djy_txt.color;
			pageindex_txt.multiline =false;
			pageindex_txt.maxChars = 5;
			//pageindex_txt.x = txt.x+txt.textWidth+10;
			pageindex_txt.fontSize = djy_txt.fontSize;
			pageindex_txt.bold = djy_txt.bold;
			//pageindex_txt.border = djy_txt.border;
			pageindex_txt.height = djy_txt.height;
			pageindex_txt.width = 46;
			pageindex_txt.x =124;
			pageindex_txt.regExp = RegExpType.INT;
			//pageindex_txt.align = TextFormatAlign.CENTER;
			pageindex_txt.textAlign = TextAlign.CENTER;
			//pageindex_txt.leading = 0;
			addChild(pageindex_txt);	
			
			
			
			
			controlBar.per_mc.addEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.per_mc.addEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
			
			controlBar.top_mc.addEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.top_mc.addEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
			
			controlBar.last_mc.addEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.last_mc.addEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
		
			controlBar.next_mc.addEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.next_mc.addEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
			
			//per_mc.stop();
			//top_mc.stop();
			//last_mc.stop();
			//next_mc.stop();	
			
			
			
			controlBar.per_mc.mouseChildren = false;
			controlBar.top_mc.mouseChildren = false;
			controlBar.last_mc.mouseChildren = false;
			controlBar.next_mc.mouseChildren = false;
			
			
			controlBar.y=9;
			controlBar.x =pageindex_txt.x+pageindex_txt.width+11;
			
			//per_mc.y = 9;
			//top_mc.y = per_mc.y;
			//last_mc.y = per_mc.y;
			//next_mc.y = per_mc.y;			
			
			//addChild(per_mc);
			//addChild(top_mc);
			//addChild(last_mc);
			//addChild(next_mc);
			
			//top_mc.x = 180;
			//per_mc.x =204;
			//next_mc.x = 229;
			//last_mc.x =251;			
			
			//cunt.x =pageindex_txt.x+pageindex_txt.textWidth+20;
			//cunt.y = 8;
			
			color = _color;
			
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			controlBar.per_mc.removeEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.per_mc.removeEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
			
			controlBar.top_mc.removeEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.top_mc.removeEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
			
			controlBar.last_mc.removeEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.last_mc.removeEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
			
			controlBar.next_mc.removeEventListener(MouseEvent.MOUSE_OVER,onIcoOverHandler);
			controlBar.next_mc.removeEventListener(MouseEvent.MOUSE_OUT,onIcoOutHandler);
			
		}
		
		
		protected function onIcoOutHandler(event:MouseEvent):void
		{
			var target:DisplayObject = event.target as DisplayObject;
			target.scaleX =target.scaleY = 1;
			// TODO Auto-generated method stub
			this.changeColor(this._color,target);
		}
		
		protected function onIcoOverHandler(event:MouseEvent):void
		{
			
			var target:DisplayObject = event.target as DisplayObject;
			target.scaleX =target.scaleY = 1.5;
			// TODO Auto-generated method stub
			this.changeColor(this._colorOver,target);		
			
			
		}
		private function changeColor(color:String,target:DisplayObject):void{
			var col:uint = uint(color);
			var colort:ColorTransform = target.transform.colorTransform;
			
			colort.color = col;
			
			target.transform.colorTransform = colort;
			
		}

		public function get colorOver():String
		{
			return _colorOver;
		}

		public function set colorOver(value:String):void
		{
			_colorOver = value;
		}

		public function get color():String
		{
			return _color;
		}

		public function set color(value:String):void
		{
			_color = value;
			djy_txt.color =_color;
			txt.color =_color;			
			
			changeColor(_color,controlBar.per_mc);
			changeColor(_color,controlBar.top_mc);
			changeColor(_color,controlBar.last_mc);
			changeColor(_color,controlBar.next_mc);
		}

	}
	
}
