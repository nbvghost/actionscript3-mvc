package com.sanbeetle.component
{
	import com.asvital.dev.Console;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.model.AMark;
	import com.sanbeetle.utils.FontNames;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.GridFitType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	[Event(name="text_link",type="com.sanbeetle.events.ControlEvent")]
	[Event(name="textInput",type="flash.events.TextEvent")]
	[Event(name="change",type="flash.events.Event")]
	/**
	 * 显示文本，输入框 ，多行文本，html文本
	 *@author sixf
	 */
	public class ILabel extends UIComponent
	{
		
		protected var textfield:TextField;
		protected var _text:String = "标签组件";
		private var _align:String = "left";
		private var _wordWrap:Boolean=false;	
		
		private var _dropShadow:Boolean = false;
		
		private var textFormat:TextFormat;
		private var _gridFitType:String=GridFitType.NONE;
		
		private var fontLoader:Loader;
		
		private var _fontSize:String = "14";
		private var _color:String = "0x000000";
		
		private var _bold:Boolean = false;
		
		private var aMarkData:Object = new Object;
		private var _selectable:Boolean = false;
		
		private var _leading:Number =6;
		private var _multiline:Boolean = true;
		
		private var _border:Boolean=false;
		
		private var _showHtml:Boolean = false;
		
		private var _autoSize:String="none";
		private var styleSheet:StyleSheet = new StyleSheet();
		
		public function ILabel()
		{
			textFormat = new TextFormat(FontNames.MS_YaHei,this.fontSize);	
			textFormat.leading = _leading;
			textfield = new TextField();	
			
			textfield.width = this.trueWidth;
			textfield.height = this.trueHeight;
			
			textfield.antiAliasType = AntiAliasType.ADVANCED;
			textfield.selectable = selectable;	
			textfield.defaultTextFormat = textFormat;
			textfield.addEventListener(Event.CHANGE,onTextFieldChangeHandler);
			textfield.addEventListener(TextEvent.TEXT_INPUT,onTextFieldHandler);
			
		}	
		[Inspectable(defaultValue = false)]
		public function get dropShadow():Boolean
		{
			return _dropShadow;
		}
		
		public function set dropShadow(value:Boolean):void
		{
			if(_dropShadow!=value){
				_dropShadow = value;
				this.updateUI();
			}
			
		}
		
		[Inspectable(enumeration="subpixel,none,pixel",defaultValue = "none")]
		public function get gridFitType():String
		{
			return _gridFitType;
		}
		
		public function set gridFitType(value:String):void
		{
			if(_gridFitType!=value){
				_gridFitType = value;
				textfield.gridFitType = _gridFitType;
				this.updateUI();
			}			
		}
		
		/**
		 * 是否多行 
		 * @return 
		 * 
		 */
		public function get multiline():Boolean
		{
			return _multiline;
		}
		
		public function set multiline(value:Boolean):void
		{
			if(_multiline!=value){
				_multiline = value;
				textfield.multiline = _multiline;			
				this.updateUI();
			}		
		}
		
		[Inspectable(defaultValue = 6)]
		/**
		 * 行高
		 */
		public function get leading():Number
		{
			return _leading;
		}
		
		public function set leading(value:Number):void
		{
			if(_leading != value){
				_leading = value;
				if(_multiline==false){
					textFormat.leading = 0;
				}else{
					textFormat.leading = _leading;
				}	
				updateUI();
			}
			
		}
		
		[Inspectable(defaultValue =false)]
		public function get selectable():Boolean
		{
			
			
			return _selectable;
		}
		
		/**
		 * 文本可选则？ 
		 * @param value
		 * 
		 */
		public function set selectable(value:Boolean):void
		{
			if(_selectable != value){
				_selectable = value;
				textfield.selectable = _selectable;	
				updateUI();
			}			
		}
		
		[Inspectable(defaultValue = false)]
		/**
		 * 是否显示成html 
		 */
		public function get showHtml():Boolean
		{
			return _showHtml;
		}
		
		public function set showHtml(value:Boolean):void
		{	
			
			if(_showHtml != value){
				_showHtml = value;
				//this._text = "<p>"+this._text+"</p>"
				if(_showHtml){				
					
					styleSheet.parseCSS(component.Style);				
					
					this.textfield.addEventListener(TextEvent.LINK,onTextFieldLinkHandler);
					
				}else{
					this.textfield.styleSheet = null;
					this.textfield.removeEventListener(TextEvent.LINK,onTextFieldLinkHandler);
				}
				this.updateUI();
			}			
		}
		
		protected function onTextFieldLinkHandler(event:TextEvent):void
		{		
			//Console.out("components"+aMarkData[event.text]);
			this.dispatchEvent(new ControlEvent(ControlEvent.TEXT_LINK,aMarkData[event.text]));
		}
		
		[Inspectable(enumeration = "center,left,none,right",defaultValue = "none")]
		/**
		 * 自动尺寸 
		 */
		public function get autoSize():String
		{
			return _autoSize;
		}
		
		public function set autoSize(value:String):void
		{
			if(_autoSize!= value){
				_autoSize = value;
				textfield.autoSize = _autoSize;
				this.updateUI();
			}	
			
			
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			if(stage!=null){
				stage.removeEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
			}
			
		}	
		
		/*override public function get height():Number
		{
		// TODO Auto Generated method stub
		
		return textfield.height;
		}
		
		override public function set height(value:Number):void
		{
		// TODO Auto Generated method stub
		textfield.height = value;
		this.updateUI();
		}
		
		override public function get width():Number
		{
		// TODO Auto Generated method stub
		return textfield.width;
		}
		
		override public function set width(value:Number):void
		{
		// TODO Auto Generated method stub
		textfield.width = value;
		this.updateUI();
		}
		*/
		
		//private var ww:int =0;
		//private var hh:int = 0;
		
		override protected function updateUI():void
		{
			
			textfield.width = this.trueWidth;
			textfield.height = this.trueHeight;
			
			textfield.x = 0;
			textfield.y = 0;	
			
			
			if(this.autoSize!="none"){
				//this.textfield.width = this.trueWidth;	
			}else{
				//this.textfield.height = this.trueHeight;
			}
			
			//<p align="left"><font face="microsoft yahei" size="10" color="#000000" letterspacing="0" kerning="0"><a href="event:dsf" target=""><b>dsfds</b></a></font>54545454545</p>
			for(var key:String in aMarkData){
				delete aMarkData[key];
			}
			//textfield.background = true;
			
			if(showHtml){
				//Console.out("components"+textfield.htmlText);
				
				//textfield.styleSheet = styleSheet;
				
				if(textfield.type ==TextFieldType.DYNAMIC){
					textfield.styleSheet = styleSheet;
				}else{
					textfield.styleSheet = null;
				}
				
				//textfield.defaultTextFormat = textFormat;
				//Console.out("components"+textfield.htmlText);
				textfield.htmlText = this._text;
				//textfield.htmlText ='<p align="left"><font face="microsoft yahei" size="10" color="#ff0000" letterspacing="0" kerning="0"><a href="event:dsf" target=""><b>dsfds</b></a></font>54545454545</p>';
				
				//textfield.htmlText='<HTML><BODY><P ALIGN="left"><FONT FACE="Microsoft yahei" SIZE="12" COLOR="#000000" LETTERSPACING="0" KERNING="1"><FONT FACE="微软雅黑" SIZE="15" COLOR="#0033ff" LETTERSPACING="0.000000%">dsfdsfds s f</FONT><FONT FACE="微软雅黑" SIZE="27" COLOR="#0033ff" LETTERSPACING="0.000000%">ds fd</FONT><FONT FACE="微软雅黑" SIZE="27" LETTERSPACING="0.000000%">s fds fd</FONT><FONT FACE="微软雅黑" SIZE="15" LETTERSPACING="0.000000%">sf dsfdsf dsfds f</FONT><FONT FACE="微软雅黑" SIZE="15" COLOR="#0033ff" LETTERSPACING="0.000000%">dsfdsf dsdsf ds</FONT></FONT></P></BODY></HTML>';
				
				//Console.out("components"+textfield.htmlText);
				var xml:XMLList = XMLList(textfield.htmlText.toLocaleLowerCase());
				var list:XMLList=xml.descendants("a");
				//Console.out("components"+list.length());
				
				for(var i:int=0;i<list.length();i++){
					var href:String = list[i].@href;
					if(href!="" || href!=null){
						var amark:AMark = new AMark();
						if(href.split(":").length>=2){
							amark.type = AMark.EVENT;
							amark.target = href.split(":")[1];
						}else{
							amark.type = AMark.URL;
							amark.target = href;
						}
						var obj:Object = new Object();
						for(var o:int=0;o<list[i].attributes().length();o++){
							
							obj[list[i].attributes()[o].localName()]=list[i].attributes()[o];
							
						}
						amark.data = obj;
						aMarkData[amark.target] = amark;
					}else{
						continue;
					}
					
				}				
				
			}else{
				textfield.defaultTextFormat = textFormat;
				textfield.text =this._text;	
			}
			
			if(this._dropShadow){
				textfield.cacheAsBitmap =true;
				textfield.filters=component.ilabelFilters;
			}else{
				textfield.cacheAsBitmap =false;
				textfield.filters=null;
			}						
			
			//this.width = this.textfield.width;
			//this.height = this.textfield.height;
			
			//this.trueWidth=textfield.width;
			
			//Console.out("components"+textfield.type);
			//Console.out("components"+this.width);
			//Console.out("components"+textfield.width,textfield.height);
			drawBorder(textfield.width,textfield.height);
		}	
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return textfield.height;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return textfield.width;
		}
		
		protected function onTextFieldChangeHandler(event:Event):void
		{
			this._text = textfield.text;
			this.dispatchEvent(event.clone());
		}
		
		private function onTextFieldHandler(event:TextEvent):void
		{
			this._text = textfield.text;
			this.dispatchEvent(event.clone());
			
		}
		[Inspectable(defaultValue = false)]
		public function get bold():Boolean
		{
			return _bold;
		}
		
		public function set bold(value:Boolean):void
		{
			if(_bold!= value){
				_bold = value;
				if (_bold)
				{
					if (textfield.embedFonts)
					{
						textFormat.font = FontNames.MS_YaHeiBold;
						textFormat.bold = true;
						//Console.out("components"+"components"+"a");
					}
					else
					{
						textFormat.font = FontNames.MS_YaHei;
						textFormat.bold = true;
						//Console.out("components"+"components"+"b");
					}
					
				}
				else
				{
					if (textfield.embedFonts)
					{
						textFormat.font = FontNames.MS_YaHei;
						textFormat.bold = false;
						//Console.out("components"+"components"+"e");
					}
					else
					{
						textFormat.font = FontNames.MS_YaHei;
						textFormat.bold = false;
						//Console.out("components"+"components"+"c");
					}			
				}		
				this.updateUI();
			}		
			
		}		
		override protected function createUI():void
		{	
			
			//this.ww = this.trueWidth;
			//this.hh = this.trueHeight;	
			
			//Console.out("components"+this.trueWidth);			
			this.addChild(textfield);			
			updateUI();
			
		}
		override protected function onStageHandler(event:Event):void
		{
			//Console.out("components"+"components"+"---------------");
			stage.addEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
			onYaheiFontLoadedHandelr(null);
		}
		
		protected function onYaheiFontLoadedHandelr(event:Event):void
		{
			
			//Console.out("components"+"components"+"字体被加载，现在使用嵌入字体！");			
			
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
			//Console.out("components"+"components"+"A");
			if (isHaveFont)
			{
				//Console.out("components"+Font.enumerateFonts());
				textfield.embedFonts = true;
				updateUI();
				//this.bold = this._bold;
				//stage.removeEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
				//Console.out("components"+"components"+"找到嵌入的字体！");
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
			if(_color!= value){
				_color = value;
				textFormat.color = this.color;	
				this.updateUI();
			}	
			
		}			
		[Inspectable(defaultValue = false)]
		public function get border():Boolean
		{
			return _border;
		}
		
		public function set border(value:Boolean):void
		{
			
			if(_border!= value){
				_border = value;
				textfield.border = _border;
				this.updateUI();
			}	
			
		}		
		[Inspectable(defaultValue = false)]
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			if(_wordWrap!= value){
				_wordWrap = value;				
				textfield.wordWrap = _wordWrap;		
				
				this.updateUI();
			}
			
		}
		[Inspectable(defaultValue = "14")]
		public function get fontSize():String
		{
			return _fontSize;
		}
		public function set fontSize(value:String):void
		{
			if(_fontSize!= value){
				Console.out("ilabel fontSize:"+value);
				_fontSize = value;
				textFormat.size = this.fontSize;
				updateUI();
			}			
			
		}
		public function get align():String
		{
			
			return _align;
		}
		[Inspectable(enumeration = "left,right,center,justify",defaultValue = "left")]
		public function set align(value:String):void
		{			
			if(_align!= value){
				_align = value;
				textFormat.align = this.align;
				this.updateUI();
			}		
			
		}		
		/*public function get textHeight():Number{
		return this.textfield.height;
		}
		public function get textWidth():Number{
		return this.textfield.width;
		}*/		
		public function set text(value:String):void
		{
			if(_text!= value){
				if(value==null){
					value="";
				}
				_text = value;	
				updateUI();	
			}		
			
		}
		[Inspectable(defaultValue = "标签组件")]
		/**
		 *@default TextFieldAutoSize.NONE
		 */
		public function get text():String
		{
			
			return this.textfield.text;
			
		}
		
	}
	
}