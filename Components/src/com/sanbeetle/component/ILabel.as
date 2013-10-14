package com.sanbeetle.component
{
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.utils.FontNames;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class ILabel extends UIComponent
	{
		
		private var textfield:TextField;
		protected var _text:String = "标签组件";
		private var _align:String = "left";
		private var _wordWrap:Boolean=false;
		
		private var textFormat:TextFormat;
		
		private var fontLoader:Loader;
		
		private var _fontSize:String = "14";
		private var _color:String = "0x000000";
		
		private var _bold:Boolean = false;
		
		
		private var _border:Boolean=false;
		
		private var _autoSize:String="none";
		
		[Inspectable(enumeration = "center,left,none,right",defaultValue = "none")]
		public function get autoSize():String
		{
			return _autoSize;
		}

		public function set autoSize(value:String):void
		{
			_autoSize = value;
			this.updateUI();
		}

		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			if(stage!=null){
				stage.removeEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
			}
			
		}
		
		override protected function updateUI():void
		{			
			textFormat.color = this.color;
			textFormat.size = this.fontSize;	
			textFormat.align = this.align;
			
			textfield.selectable = false;
			textfield.wordWrap = _wordWrap;
			textfield.multiline = true;			
			textfield.selectable = false;
			
			textfield.autoSize = this.autoSize;
			textfield.antiAliasType = AntiAliasType.ADVANCED;
			
			
			if (_bold)
			{
				if (textfield.embedFonts)
				{
					textFormat.font = FontNames.MS_YaHeiBold;
					textFormat.bold = true;
					//trace("a");
				}
				else
				{
					textFormat.font = FontNames.MS_YaHei;
					textFormat.bold = true;
					//trace("b");
				}
				
			}
			else
			{
				if (textfield.embedFonts)
				{
					textFormat.font = FontNames.MS_YaHei;
					textFormat.bold = false;
					//trace("e");
				}
				else
				{
					textFormat.font = FontNames.MS_YaHei;
					textFormat.bold = false;
					//trace("c");
				}			
			}	
			textfield.border = this.border;
			textfield.defaultTextFormat = textFormat;
			
			
			textfield.text =this.text;
			
			if (trueWidth!=0||trueHeight!=0)
			{
				textfield.width = this.trueWidth;
				textfield.height = this.trueHeight;
			}
			
			
		}
		
		public function ILabel()
		{
			textFormat = new TextFormat(FontNames.MS_YaHei,this.fontSize);			
			textfield = new TextField();
			
			
			
		}
		[Inspectable(defaultValue = false)]
		public function get bold():Boolean
		{
			return _bold;
		}
		
		public function set bold(value:Boolean):void
		{
			_bold = value;
			
			updateUI();
			
			
		}		
		override protected function createUI():void
		{				
			
			this.addChild(textfield);
			
			
		}
		override protected function onStageHandler(event:Event):void
		{
			//trace("---------------");
			stage.addEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
			onYaheiFontLoadedHandelr(null);
		}
		
		protected function onYaheiFontLoadedHandelr(event:Event):void
		{
			
			
			//trace("字体被加载，现在使用嵌入字体！");
			
			
			var isHaveFont:Boolean = false;
			var fontArr:Array = Font.enumerateFonts();
			for each (var f:Font in fontArr)
			{
				
				if (f.fontName == FontNames.MS_YaHei)
				{
					isHaveFont = true;
					break;
				}
			}
			//trace("A");
			if (isHaveFont)
			{
				trace(Font.enumerateFonts());
				textfield.embedFonts = true;
				this.updateUI();
				//this.bold = this._bold;
				//stage.removeEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
				//trace("找到嵌入的字体！");
			}
			else
			{
				
			}	
			
			
		}
		
		[Inspectable(defaultValue = 0x000000)]
		public function get color():String
		{
			return _color;
		}
		
		public function set color(value:String):void
		{
			_color = value;
			updateUI();
			//textFormat.color = _color;
			
		//	textfield.setTextFormat(textFormat);
			//textfield.defaultTextFormat = textFormat;
			//trace("font color:"+value);
		}			
		[Inspectable(defaultValue = false)]
		public function get border():Boolean
		{
			return _border;
		}
		
		public function set border(value:Boolean):void
		{
			_border = value;
			this.updateUI();
		}
		
		private function onResizehnaler(e:Event):void
		{
			//trace(e);
		}
		[Inspectable(defaultValue = false)]
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			_wordWrap = value;			
			this.updateUI();
		}
		[Inspectable(defaultValue = "14")]
		public function get fontSize():String
		{
			return this._fontSize;
		}
		public function set fontSize(value:String):void
		{
			_fontSize = value;
			this.updateUI();
			
		}
		public function get align():String
		{
			
			return _align;
		}
		[Inspectable(enumeration = "left,right,center,justify",defaultValue = "left")]
		public function set align(value:String):void
		{
			//border =true;			
			_align = value;
			updateUI();
			
			//textFormat.align = _align;
			//textfield.setTextFormat(textFormat);
			//textfield.defaultTextFormat = textFormat;
			//textfield.autoSize = value;
			//trace(value);
		}
		override public function get height():Number
		{
		
		return this.trueHeight;
		
		}
		public function get textHeight():Number{
			return this.textfield.height;
		}
		public function get textWidth():Number{
			return this.textfield.width;
		}
		
		override public function set height(value:Number):void
		{
			
			trueHeight = value;
			updateUI();
		}
		
		override public function get width():Number
		{
		
		return this.trueWidth;
		
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub			
			trueWidth = value;
			updateUI();
		}
		
		
		
		public function set text(str:String):void
		{
			if(str==null){
				str="";
			}
			_text = str;
			
			updateUI();
			//textfield.setTextFormat(textFormat);
			
			
		}
		[Inspectable(defaultValue = "标签组件")]
		/**
		 *@default TextFieldAutoSize.NONE
		 */
		public function get text():String
		{
			
			return _text;
			
		}
		override public function setSize(width:Number,height:Number):void
		{
			this.trueWidth = width;
			this.trueHeight = height;
			
			updateUI();
			
			this.dispatchEvent(new Event(Event.RESIZE));		
			
			///trace(width,height);
		}
		
	}
	
}