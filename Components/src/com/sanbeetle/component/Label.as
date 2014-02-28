package com.sanbeetle.component
{
	import com.asvital.text.FTETextField;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	
	import flash.events.Event;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontWeight;
	
	public class Label extends UIComponent
	{
		
		
		private var _text:String="default";			
		private var _autoBound:Boolean = false;
		private var _multiline:Boolean =true;			
		
		private var _bold:Boolean =false;
		private var _fontSize:uint = 14;			
		private var _color:String="0x333333";	
		private var _paddingBottom:int =0;
		private var _paddingLeft:int=0;
		private var _paddingRight:int=0;
		private var _paddingTop:int=0;
		private var _lineHeight:int=0;
		private var _dropShadow:Boolean =false;
		
		private var _verticalAlign:String="top";
		private var _horizontalAlign:String="left";
		
		private var isTextXML:Boolean = false;
		
		private var _textformat:ElementFormat;
		
		private var textField:FTETextField;
		public function Label()
		{
			super();
			textField = new FTETextField();
			textformat  =textField.textFormat.clone();
			textField.text = _text;
			textField.wordWrap = _multiline;
		}

		public function get textformat():ElementFormat
		{
			return _textformat;
		}

		public function set textformat(value:ElementFormat):void
		{
			_textformat = value;
			updateUI();
		}

		[Inspectable(enumeration = "left,right,center",defaultValue = "left")]
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		public function set horizontalAlign(value:String):void
		{
			_horizontalAlign = value;
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
			_verticalAlign = value;
		}
		[Inspectable(defaultValue="false")]
		public function get dropShadow():Boolean
		{
			return _dropShadow;
		}
		
		public function set dropShadow(value:Boolean):void
		{
			if(_dropShadow!=value){
				
				_dropShadow = value;
			}
		}
		[Inspectable(defaultValue="0")]
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
		[Inspectable(defaultValue="0")]
		public function get paddingTop():int
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:int):void
		{
			_paddingTop = value;
		}
		[Inspectable(defaultValue="0")]
		public function get paddingRight():int
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:int):void
		{
			if(_paddingRight != value){
				
				_paddingRight = value;
			}
		}
		[Inspectable(defaultValue="0")]
		public function get paddingLeft():int
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:int):void
		{
			if(_paddingLeft != value){
				
				_paddingLeft = value;
			}
		}
		[Inspectable(defaultValue="0")]
		public function get paddingBottom():int
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:int):void
		{
			if(_paddingBottom != value){
				
				_paddingBottom = value;
				updateUI();
			}
		}
		[Inspectable(defaultValue="0x333333")]
		public function get color():String
		{
			return _color;
		}
		
		public function set color(value:String):void
		{
			if(_color != value){
				
				_color = value;
				
				textformat.color =uint(_color);		
				
				updateUI();
			}
		}
		[Inspectable(defaultValue="14")]
		public function get fontSize():uint
		{
			return _fontSize;
		}
		
		public function set fontSize(value:uint):void
		{
			if(_fontSize != value){
				
				_fontSize = value;
				
				textformat.fontSize = _fontSize;
				updateUI();
			}
		}
		[Inspectable(defaultValue="false")]
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
					
					textformat.fontDescription.fontWeight = FontWeight.BOLD;
				}else{
					textformat.fontDescription.fontWeight = FontWeight.NORMAL;
					
				}
				updateUI();
			}
		}
		[Inspectable(defaultValue="")]
		public function get textXML():String
		{
			return _text;
		}
		
		public function set textXML(value:String):void
		{
			isTextXML = true;
			if(_text != value && value!=""){
				
				_text = value;
				//textField.htmlText = _textXML;
				updateUI();
			}
		}
		[Inspectable(defaultValue="true")]
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
		[Inspectable(defaultValue="false")]
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
			return _text;
		}
		
		public function set text(value:String):void
		{
			isTextXML = false;
			if(_text != value && value!=""){
				
				_text = value;
				//textField.text = _text;
				updateUI();
			}
			
		}
		
		override public function updateUI():void
		{
			textField.textFormat = textformat.clone();
			
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
			
			
		}
		override public function createUI():void
		{
			this.addChild(textField);
			stage.addEventListener(ControlEvent.FONT_LOADED,onFontLoaderHandler);
			updateUI();
		}
		
		protected function onFontLoaderHandler(event:Event):void
		{
			stage.removeEventListener(ControlEvent.FONT_LOADED,onFontLoaderHandler);
			textField.refreshTextLine();
			
		}
		
	}
}