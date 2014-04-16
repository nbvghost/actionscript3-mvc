package com.sanbeetle.component
{
	import com.asvital.text.FTETextField;
	import com.asvital.text.TextPadding;
	import com.asvital.text.event.FTEOperationEvent;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.model.AMark;
	import com.sanbeetle.utils.FontNames;
	
	import flash.events.Event;
	import flash.net.URLVariables;
	import flash.text.Font;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;
	
	
	[Event(name="text_link",type="com.sanbeetle.events.ControlEvent")]
	[Event(name="text_link_move",type="com.sanbeetle.events.ControlEvent")]
	[Event(name="text_link_over",type="com.sanbeetle.events.ControlEvent")]
	[Event(name="text_link_out",type="com.sanbeetle.events.ControlEvent")]
	
	[Event(name="change",type="flash.events.Event")]
	[Event(name="font_loaded",type="com.sanbeetle.events.ControlEvent")]
	
	public class ILabel extends UIComponent
	{
		
		
		private var _text:String="default";			
		private var _autoBound:Boolean = false;
		private var _multiline:Boolean =true;			
		
		private var _bold:Boolean =false;
		private var _fontSize:String = "14";			
		private var _color:String="0x333333";	
		private var _paddingBottom:int =0;
		private var _paddingLeft:int=0;
		private var _paddingRight:int=0;
		private var _paddingTop:int=2;
		private var _lineHeight:int=2;
		
		
		private var _scrollText:Boolean =false;		
		private var _showHtml:Boolean = false;	
		
		private var padding:TextPadding = new TextPadding();
		
		private var _dropShadow:Boolean =false;
		
		private var _textAlign:String = "left";
		
		private var _verticalAlign:String="top";
		private var _horizontalAlign:String="left";
		
		private var isTextXML:Boolean = false;
		
		private var _textformat:ElementFormat;
		
		private var fontDescription:FontDescription;
		
		private var _align:String ="left";
		private var _autoSize:String = "none";
		
		private var textField:FTETextField;
		private var _border:Boolean = false;
		private var _blockProgression:String="";
		
		private var _leading:int =0;
		
		private var _maxChars:int =0;
		
		private var _selectable:Boolean = false;
		
		
		private var _gridFitType:String = "";		
		
		private var _currentLinkData:AMark=new AMark();
		public function ILabel()
		{
			super();
			textField = new FTETextField();
			/*	textField.addEventListener(FTEOperationEvent.LinkMouseDown,onLinkMouseDownHandler);
			textField.addEventListener(FTEOperationEvent.LinkMouseOut,onLinkMouseOutHandler);
			textField.addEventListener(FTEOperationEvent.LinkMouseOver,onLinkMouseOverHandler);*/
			textField.styleSheet =component.getStyle();
			
			_textformat  =textField.textFormat.clone();
			fontDescription = _textformat.fontDescription.clone();
			textField.text = _text;
			textField.wordWrap = _multiline;
		}
		
		protected function onLinkMouseOverHandler(event:FTEOperationEvent):void
		{
			var href:String = textField.attributes["href"];			
			if(href!=null){				
				var hrefs:Array = href.split(":");
				if(hrefs.length>1){
					_currentLinkData.target = hrefs[1];
					
					if(textField.attributes["pam"]!=undefined && textField.attributes["pam"]!=""){
						
						_currentLinkData.parameters = new URLVariables(textField.attributes["pam"]);
					}else{
						_currentLinkData.parameters = new URLVariables();
					}					
					this.dispatchEvent(new ControlEvent(ControlEvent.TEXT_LINK_OVER,_currentLinkData));					
				}
			}
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if(textField){
				textField.removeEventListener(FTEOperationEvent.LinkMouseDown,onLinkMouseDownHandler);
				textField.removeEventListener(FTEOperationEvent.LinkMouseOut,onLinkMouseOutHandler);
				textField.removeEventListener(FTEOperationEvent.LinkMouseOver,onLinkMouseOverHandler);
				textField.styleSheet.clear();
				textField.dispose();
			}
			textField =null;
			padding=null;
			_textformat=null;
			fontDescription=null;
			_currentLinkData=null;
			
		}
		
		
		protected function onLinkMouseOutHandler(event:FTEOperationEvent):void
		{
			var href:String = textField.attributes["href"];			
			if(href!=null){				
				var hrefs:Array = href.split(":");
				if(hrefs.length>1){
					_currentLinkData.target = hrefs[1];
					
					if(textField.attributes["pam"]!=undefined && textField.attributes["pam"]!=""){
						
						_currentLinkData.parameters = new URLVariables(textField.attributes["pam"]);
					}else{
						_currentLinkData.parameters = new URLVariables();
					}					
					this.dispatchEvent(new ControlEvent(ControlEvent.TEXT_LINK_OUT,_currentLinkData));					
				}
			}
		}
		
		protected function onLinkMouseDownHandler(event:FTEOperationEvent):void
		{		
			var href:String = textField.attributes["href"];			
			if(href!=null){				
				var hrefs:Array = href.split(":");
				if(hrefs!=null && hrefs.length>1){
					_currentLinkData.target = hrefs[1];
					
					if(textField.attributes["pam"]!=undefined && textField.attributes["pam"]!=""){
						
						_currentLinkData.parameters = new URLVariables(textField.attributes["pam"]);
					}else{
						_currentLinkData.parameters = new URLVariables();
					}					
					this.dispatchEvent(new ControlEvent(ControlEvent.TEXT_LINK,_currentLinkData));					
				}
			}
			
		}
		
		public function get currentLinkData():AMark
		{
			return _currentLinkData;
		}
		
		public function get gridFitType():String
		{
			return _gridFitType;
		}
		[Deprecated]
		public function set gridFitType(value:String):void
		{
			_gridFitType = value;
		}
		
		public function get selectable():Boolean
		{
			return _selectable;
		}
		[Deprecated]
		public function set selectable(value:Boolean):void
		{
			_selectable = value;
		}
		
		public function get maxChars():int
		{
			return _maxChars;
		}
		[Deprecated]
		public function set maxChars(value:int):void
		{
			_maxChars = value;
		}
		
		public function get leading():int
		{
			return _leading;
		}
		[Deprecated]
		public function set leading(value:int):void
		{
			_leading = value;
			lineHeight = _leading;
		}
		//[Inspectable(enumeration = "tb,rl",defaultValue = "tb")]
		public function get blockProgression():String
		{
			return _blockProgression;
		}
		[Deprecated]
		public function set blockProgression(value:String):void
		{
			_blockProgression = value;
		}
		//[Inspectable(enumeration = "center,left,none,right",defaultValue = "none")]
		public function get autoSize():String
		{
			return _autoSize;
		}
		[Deprecated]
		public function set autoSize(value:String):void
		{
			if(_autoSize!=value){
				_autoSize = value;
				if(_autoSize!="none"){
					autoBound = true;
				}else{
					autoBound = false;
				}
			}
			
		}
		//[Inspectable(enumeration = "left,right,center,justify",defaultValue = "left")]
		public function get align():String
		{
			return _align;
		}
		[Deprecated]
		public function set align(value:String):void
		{
			if(_align!=value){
				
				_align = value;
				horizontalAlign = value;
			}
		}
		
		[Inspectable(defaultValue=false)]
		public function get border():Boolean
		{
			return _border;
		}
		
		public function set border(value:Boolean):void
		{
			if(_border!=value){
				_border = value;
				textField.border = _border;
			}
			
		}
		//[Inspectable(enumeration = "center,end,justify,left,right,start",defaultValue = "left")]
		public function get textAlign():String
		{
			return _textAlign;
		}
		[Deprecated]
		public function set textAlign(value:String):void
		{
			if(_textAlign!=value){
				
				_textAlign = value;
				
				horizontalAlign = _textAlign;
			}
		}
		
		public function getTextformat():ElementFormat
		{
			return _textformat;
		}
		
		public function setTextformat(value:ElementFormat):void
		{
			if(_textformat!=value){
				_textformat = value;
				updateUI();
			}
			
		}
		
		[Inspectable(enumeration = "left,right,center",defaultValue = "left")]
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		public function set horizontalAlign(value:String):void
		{
			if(_horizontalAlign!=value){
				_horizontalAlign = value;
				textField.horizontalAlign = _horizontalAlign;
			}
			
		}
		[Inspectable(enumeration = "bottom,middle,top",defaultValue = "top")]
		/**
		 * 垂直 
		 */
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		/**
		 * @private
		 */
		public function set verticalAlign(value:String):void
		{
			if(_verticalAlign!=value){
				
				_verticalAlign = value;
				textField.verticalAlign = _verticalAlign;
			}
		}
		[Inspectable(defaultValue=false)]
		public function get dropShadow():Boolean
		{
			return _dropShadow;
		}
		
		public function set dropShadow(value:Boolean):void
		{
			if(_dropShadow!=value){
				
				_dropShadow = value;
				
				if(this._dropShadow){
					this.cacheAsBitmap =true;
					this.filters=component.ilabelFilters;
				}else{
					this.cacheAsBitmap =false;
					this.filters=null;
				}
			}
			
			
			
		}
		[Inspectable(defaultValue=2)]
		public function get lineHeight():int
		{
			return _lineHeight;
		}
		
		public function set lineHeight(value:int):void
		{
			if(_lineHeight != value){
				
				_lineHeight = value;
				
				updateUI();
			}
		}
		[Inspectable(defaultValue=2)]
		public function get paddingTop():int
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:int):void
		{
			if(_paddingTop!=value){
				
				_paddingTop = value;
				padding.top = value;
				updateUI();
			}
		}
		[Inspectable(defaultValue=0)]
		public function get paddingRight():int
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:int):void
		{
			if(_paddingRight != value){
				
				_paddingRight = value;
				padding.right = _paddingRight;
				updateUI();
			}
		}
		[Inspectable(defaultValue=0)]
		public function get paddingLeft():int
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:int):void
		{
			if(_paddingLeft != value){
				
				_paddingLeft = value;
				padding.left = _paddingLeft;
				updateUI();
			}
		}
		[Inspectable(defaultValue=0)]
		public function get paddingBottom():int
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:int):void
		{
			if(_paddingBottom != value){
				
				_paddingBottom = value;
				
				padding.buttom = _paddingBottom;
				
				updateUI();
			}
		}
		[Inspectable(defaultValue=0x333333)]
		public function get color():String
		{
			return _color;
		}
		
		public function set color(value:String):void
		{
			if(_color != value){
				
				_color = value;
				
				_textformat.color =uint(_color);		
				
				updateUI();
			}
		}
		[Inspectable(defaultValue="14")]
		public function get fontSize():String
		{
			return _fontSize;
		}
		
		public function set fontSize(value:String):void
		{
			if(_fontSize != value){
				
				_fontSize = value;
				
				_textformat.fontSize = Number(_fontSize);
				updateUI();
			}
		}
		[Inspectable(defaultValue=false)]
		public function get bold():Boolean
		{
			return _bold;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set bold(value:Boolean):void
		{
			if(_bold != value){
				
				_bold = value;
				
				if(_bold){
					
					fontDescription.fontWeight = FontWeight.BOLD;
				}else{
					fontDescription.fontWeight = FontWeight.NORMAL;
					
				}
				updateUI();
			}
		}
		
		public function get textXML():String
		{
			return _text;
		}
		
		public function set textXML(value:String):void
		{
			isTextXML = true;	
			if(_text != value){
				
				_text = value;
				//textField.htmlText = _textXML;
				updateUI();
			}
		}
		[Inspectable(defaultValue=true)]
		public function get multiline():Boolean
		{
			return _multiline;
		}
		
		public function set multiline(value:Boolean):void
		{
			if(_multiline != value){
				
				_multiline = value;
				textField.wordWrap = _multiline;
				updateUI();
			}
		}
		[Inspectable(defaultValue=false)]
		public function get autoBound():Boolean
		{
			return _autoBound;
		}
		
		public function set autoBound(value:Boolean):void
		{
			if(_autoBound != value){
				
				_autoBound = value;
				textField.autoSize = _autoBound;
				updateUI();
			}
		}
		[Inspectable(defaultValue="default")]
		public function get text():String
		{
			var xm:XMLList = XML("<t>"+_text+"</t>").descendants();
			var st:String = "";
			for (var j:int = 0; j < xm.length(); j++) 
			{
				//trace(xm[j].localName());
				if(xm[j].localName()==null || xm[j].localName()==undefined){
					//trace(xm[j]);
					st=st+xm[j];
				}
			}
			
			return st;
		}
		
		public function set text(value:String):void
		{
			isTextXML = false;
			if(_text != value){
				
				_text = value;
				//textField.text = _text;
				updateUI();
			}
			
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return textField.height;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return textField.width;
		}
		
		
		override public function updateUI():void
		{
			
			
			var tf:ElementFormat =  _textformat.clone();
			tf.fontDescription =fontDescription.clone();
			
			padding.buttom = paddingBottom;
			padding.left = paddingLeft;
			padding.right = paddingRight;
			padding.top = paddingTop;
			
			textField.padding = padding;
			
			textField.textFormat = tf;
			
			
			
			
			if(trueWidth!=textField.width){
				textField.width = trueWidth;
			}
			if(trueHeight!=textField.height){
				textField.height = trueHeight;
			}
			
			
			textField.lineHeight = _lineHeight;
			
			
			if(isTextXML){
				textField.htmlText = _text;				
			}else{
				textField.text = _text;				
			}
			
			drawBorder(textField.width,textField.height);
			
		}
		override public function onStageHandler(event:Event):void
		{
			textField.addEventListener(FTEOperationEvent.LinkMouseDown,onLinkMouseDownHandler);
			textField.addEventListener(FTEOperationEvent.LinkMouseOut,onLinkMouseOutHandler);
			textField.addEventListener(FTEOperationEvent.LinkMouseOver,onLinkMouseOverHandler);
			
			stage.addEventListener(ControlEvent.FONT_LOADED,onFontLoaderHandler);
			
		}
		override public function createUI():void
		{
			this.addChild(textField);
			
			onFontLoaderHandler(null);
			updateUI();
		}
		
		protected function onFontLoaderHandler(event:Event):void
		{
			//trace(Font.enumerateFonts());
			stage.removeEventListener(ControlEvent.FONT_LOADED,onFontLoaderHandler);
			var fonts:Array = Font.enumerateFonts();
			if(fonts.length>=2){
				var fontName:String = Font(fonts[0]).fontName+Font(fonts[1]).fontName;
				if(fontName.indexOf(FontNames.MS_YaHei_Local)!=-1 && fontName.indexOf(FontNames.MS_YaHei_Local)!=-1){
					//当还没有载入字体时，设置会出错
					fontDescription.fontLookup = FontLookup.EMBEDDED_CFF;
					fontDescription.fontName =FontNames.MS_YaHei_Local;				
					updateUI();
					this.dispatchEvent(new ControlEvent(ControlEvent.FONT_LOADED));
				}
			}
			
			
		}
		
	}
}