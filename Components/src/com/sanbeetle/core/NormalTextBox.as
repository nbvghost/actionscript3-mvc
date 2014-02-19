package com.sanbeetle.core
{
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.model.AMark;
	import com.sanbeetle.utils.FontNames;
	
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.net.URLVariables;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.edit.ISelectionManager;
	import flashx.textLayout.edit.SelectionManager;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.events.FlowOperationEvent;
	import flashx.textLayout.formats.BlockProgression;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class NormalTextBox extends UIComponent
	{
		protected var _text:String = "default label";
		private var _align:String = "left";
		private var _wordWrap:Boolean=false;	
		
		private var _dropShadow:Boolean = false;
		
		
		
		private var _fontSize:String = "14";
		private var _color:String = "0x333333";		
		
		private var aMarkData:Object = new Object;		
		
		private var _leading:Number =6;
		private var _border:Boolean=false;			
		private var _autoSize:String="none";
		private var _scrollText:Boolean =false;		
		
		
		
		private var _bold:Boolean = false;
		private var _selectable:Boolean = false;
		private var _showHtml:Boolean = false;	
		private var _multiline:Boolean = false;
		private var _lineHeight:Object;
		private var _paddingBottom:Number=0;
		private var _paddingLeft:Number = 0;
		private var _paddingRight:Number = 0;
		private var _paddingTop:Number = 0;
		
		
		private var _textAlign:String="start";		
		
		
		private var configuration:Configuration;
		private var styleSheet:StyleSheet = new StyleSheet();
		
		private var _autoBound:Boolean = false;		
		
		
		private var ccw:Number;
		private var cch:Number;		
		
		
		private var _verticalAlign:String="inherit";
		
		private var _currentLinkData:AMark;
		
		private var _blockProgression:String =BlockProgression.TB;
		
		private var isXMLText:Boolean = false;	
		
		protected var textField:TextField;
		
		private var isHtml:Boolean = false;
		
		
		private var textFormat:TextFormat;
		
		
		
		public function NormalTextBox()
		{			
			textField = new TextField();
			//textField.border = true;
			textField.antiAliasType=AntiAliasType.ADVANCED;
			//textField.width = 200;
			//textField.height = 200;
			
			//textField.multiline =true;
			//textField.wordWrap = true;
			
			textField.text =_text;
			
			textFormat = new TextFormat(FontNames.MS_YaHei,_fontSize,_color,_bold);
			//textField.setTextFormat(textFormat);
			
		}		
		
		public function get textContainerManager():ExtendsTextContainerManager
		{
			throw new Error("不支持这个属性!");
			return null;
		}
		
		
		/**
		 * 删除文字，焦点不会消失， 
		 * @param operationState
		 * @return 
		 * 
		 */
		public function deleteAllText(operationState:SelectionState=null):String{
			var str:String = this.text;
			
			textField.text = "";
			textField.htmlText = "";
			
			
			
			return str;		
			
		}
		public function get textLayoutFormat():TextLayoutFormat
		{
			return null;
		}
		
		override protected function onAddStage():void
		{
			// TODO Auto Generated method stub
			super.onAddStage();
			
		}
		
		override protected function onRemoveStage():void
		{
			// TODO Auto Generated method stub
			super.onRemoveStage();
		}
		
		[Inspectable(enumeration = "tb,rl",defaultValue = "tb")]
		public function get blockProgression():String
		{
			return _blockProgression;
		}
		
		public function set blockProgression(value:String):void
		{
			if(_blockProgression!==value){
				_blockProgression = value;				
				
				//_textLayoutFormat.blockProgression = _blockProgression;
				
				//textContainerManager.hostFormat =_textLayoutFormat;
				
				
				this.updateUI();
				
				//_textFlow.flowComposer.updateAllControllers();
				//cc.updateContainer();
			}
			
		}
		
		public function get currentLinkData():AMark
		{
			return _currentLinkData;
		}
		
		public function set currentLinkData(value:AMark):void
		{
			_currentLinkData = value;
		}
		
		/**
		 * Constant Defined By </br>
		 * BOTTOM : String = "bottom" </br>
		 * [static] Specifies alignment with the bottom edge of the frame. VerticalAlign  </br>
		 * JUSTIFY : String = "justify" </br>
		 * [static] Specifies vertical line justification within the frame  VerticalAlign  </br>
		 * MIDDLE : String = "middle" </br>
		 * [static] Specifies alignment with the middle of the frame. VerticalAlign  </br>
		 * TOP : String = "top" </br>
		 * [static] Specifies alignment with the top edge of the frame. VerticalAlign  </br>
		 
		 * FormatValue.INHERIT 
		 * @return 
		 * 
		 */		
		[Inspectable(enumeration = "bottom,justify,middle,top,inherit",defaultValue = "inherit")]
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		public function set verticalAlign(value:String):void
		{
			if(_verticalAlign != value){
				_verticalAlign = value;
				
				
				this.updateUI();
			}
			
		}
		public function setFocus():void{
			
			this.textField.setSelection(textField.text.length-1,textField.text.length-1);
			
		}
		protected function addTextFlowEvent():void{
			
			textField.addEventListener(TextEvent.LINK,onLinkHandler);
			textField.addEventListener(TextEvent.TEXT_INPUT,onTextInputHandler);
			
			
		}	
		
		protected function onTextInputHandler(event:TextEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onLinkHandler(event:TextEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function removeTextFlowEvent():void{
			
			
			textField.removeEventListener(TextEvent.LINK,onLinkHandler);
			textField.removeEventListener(TextEvent.TEXT_INPUT,onTextInputHandler);
			
		}		
		protected function onFlowElementOverHandler(event:FlowElementMouseEvent):void
		{
			
			
			
			
		}
		
		protected function onFlowElementOutHandler(event:FlowElementMouseEvent):void
		{
			
			
			
		}
		
		protected function onFlowElementMoveHandler(event:TextEvent):void
		{
			
		}
		
		protected function onFlowOperationEndHandler(event:FlowOperationEvent):void
		{
			
			
		}		
		
		public function get textXML():String{
			
			return this.textField.htmlText;
		}
		private var imagesArr:Array = [];
		private var imgData:Array = [];
		private var imgIndexArr:Array=[];
		
		public function set textXML(value:String):void{		
			
			isHtml = true;			
			imgData.splice(0,imgData.length);
			imgIndexArr.splice(0,imgIndexArr.length);			
			
			value = value.replace(/□/g,"");			
			var imgs:Array = value.split("<img");						
			
			_text= imgs[0];
			
			for(var i:int=1;i<imgs.length;i++){
				var strsA:Array = imgs[i].split("/>");
				var strsB:Array = imgs[i].split("</img>");
				var imgStr:String = "";
				
				if(strsA!=null && strsA.length>1){
					_text = _text+"□"+strsA[1];
					imgStr = String(strsA[0]).replace(/\ /g,"&").replace(/\'/g,"").replace(/\"/g,"");
					
				}else if(strsB!=null && strsB.length>1){
					
					_text = _text+"□"+strsB[1];
					imgStr = String(strsB[0]).replace(/\ /g,"&").replace(/\'/g,"").replace(/\"/g,"");
				}else{
					throw new Error("<img 没有结尾");
					
				}
				if(imgStr.charAt(0)=="&"){
					imgStr = imgStr.substring(1,imgStr.length);
				}
				if(imgStr.charAt(imgStr.length-1)=="&"){
					imgStr = imgStr.substring(0,imgStr.length-1);
				}				
				
				imgData.push(new URLVariables(imgStr));
			}
			
			
			var img:TextImage;
			for(var t:int=0;t<imagesArr.length;t++){
				img = imagesArr[t];
				if(img){
					if(img.parent){
						img.parent.removeChild(img);
					}
				}
			}
			
			this.textField.htmlText = _text;
			
			var tempText:String = textField.text;
			var tempIndex:int = 0;
			while(true){
				tempIndex = tempText.indexOf("□",tempIndex+1);
				if(tempIndex==-1){
					break;
				}else{					
					imgIndexArr.push(tempIndex);
				}
			}
			
			_text = _text.replace(/□/g,"　");
			
			this.updateUI();			
			
			reTextImagesLayout();
		}	
		private function reTextImagesLayout():void{
			
			//var imgIndex:int = 0;
			var rect:Rectangle;
			
			var img:TextImage;
			
			//var index:int = 0;
			
			//var imgEndIndex:int = 0;
			
			
			
			//textField.setTextFormat(new TextFormat(null,18,null,null,null,null,null,null,null,50,0),0,1);
			
			
			for (var i:int = 0; i < imgIndexArr.length; i++) 
			{
				rect =textField.getCharBoundaries(imgIndexArr[i]);
				img = imagesArr[i];	
				
				if(img==null){
					img = new TextImage();					
					imagesArr.push(img);
					
					img.setImageData(imgData[i]);
				}
				
				img.setBoundaries(rect);
				img.x = rect.x+textField.x;
				img.y = rect.y+textField.y;
				this.addChild(img);
				
				
				
			}
			
			
			
			
			
			
			
			
			
		}
		protected function onFlowElementMouseDownHandler(event:FlowElementMouseEvent):void
		{			
			
		}
		
		private function disTextEvent(lin:LinkElement,eventType:String):void{
			_currentLinkData = new AMark();
			
			if(lin.href){
				var tarte:Array = lin.href.split(":");
				if(tarte.length>=2){
					_currentLinkData.target=tarte[1];
				}		
				if(lin.styles!=null){
					if(lin.styles["pam"]==undefined){
						_currentLinkData.parameters =new URLVariables();
					}else{
						_currentLinkData.parameters = new URLVariables(String(lin.styles["pam"]));
					}
				}else{
					_currentLinkData.parameters =new URLVariables();
				}
				
				
				
			}else{
				_currentLinkData.parameters = new URLVariables();
			}
			
			
			this.dispatchEvent(new ControlEvent(eventType,_currentLinkData));
			
			
		}
		private var _regExp:RegExp;
		protected function onFlowOperationCompleteHandler(event:FlowOperationEvent):void
		{
			
		}
		/**
		 * RegExpType 枚举
		 * @see com.sanbeetle.data.RegExpType 
		 */
		public function get regExp():RegExp
		{
			return _regExp;
		}
		
		/**
		 * @private
		 */
		public function set regExp(value:RegExp):void
		{
			_regExp = value;
		}		
		protected function onFlowOperationBedginHandler(event:TextEvent):void
		{
			
			
			
			
		}		
		//获取字符串的字节数 
		private function getStringBytesLength(str:String,charSet:String):int
		{
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(str, charSet);
			bytes.position = 0;
			
			//Log.out( str + "    " + bytes.length ); 
			return bytes.length;
		}  
		/**
		 * CENTER : String = "center"</br>
		 * [静态] 指定与容器中心对齐。</br>
		 * TextAlign</br>
		 * END : String = "end"</br>
		 * [静态] 指定结束边缘对齐 - 文本与书写顺序的结束端对齐。</br>
		 * TextAlign</br>
		 * JUSTIFY : String = "justify"</br>
		 * [静态] 指定文本在行内两端对齐，以便位于容器空间范围内。</br>
		 * TextAlign</br>
		 * LEFT : String = "left"</br>
		 * [静态] 指定左边缘对齐。</br>
		 * TextAlign</br>
		 * RIGHT : String = "right"</br>
		 * [静态] 指定右边缘对齐。</br>
		 * TextAlign</br>
		 * START : String = "start"</br>
		 * [静态] 指定起始边缘对齐 - 文本与书写顺序的起始端对齐。 </br>
		 * @return 
		 * 
		 */		
		[Inspectable(enumeration = "center,end,justify,left,right,start",defaultValue = "start")]
		public function get textAlign():String
		{
			return _textAlign;
		}
		
		public function set textAlign(value:String):void
		{
			if(_textAlign !== value){
				_textAlign = value;
				
				this.textFormat.align = 	_textAlign;		
				this.updateUI();
			}
			
		}
		
		/**
		 * 行高 
		 */
		[Inspectable()]
		public function get lineHeight():*
		{
			return _lineHeight;
		}
		
		public function set lineHeight(value:Object):void
		{
			if(_lineHeight !== value){
				_lineHeight = value;
				if(_lineHeight==null){
					_lineHeight=null;
				}else if(_lineHeight==""){
					_lineHeight =null;
				}
				
				this.updateUI();
			}
			
		}
		
		/**
		 * 在给定的宽度不变的情况下，自己扩展 高度。 
		 * @return 
		 * 
		 */
		[Inspectable]
		public function get autoBound():Boolean
		{
			return _autoBound;
		}
		
		public function set autoBound(value:Boolean):void
		{
			if(_autoBound !== value){
				_autoBound = value;
				
				this.textField.autoSize = TextFieldAutoSize.LEFT;
				this.updateUI();
			}
			
		}
		[Inspectable(defaultValue=0)]
		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:Number):void
		{
			if( _paddingTop !== value)
			{
				_paddingTop = value;
				//_textLayoutFormat.paddingTop = _paddingTop;
				//textContainerManager.hostFormat = _textLayoutFormat;
				this.updateUI();
				
			}
		}
		
		[Inspectable]
		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:Number):void
		{
			if( _paddingRight !== value)
			{
				_paddingRight = value;
				//_textLayoutFormat.paddingRight = _paddingRight;
				//textContainerManager.hostFormat = _textLayoutFormat;
			}
		}
		
		[Inspectable(defaultValue=0)]
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:Number):void
		{
			if( _paddingLeft !== value)
			{
				_paddingLeft = value;
				//_textLayoutFormat.paddingLeft = _paddingLeft;
				//textContainerManager.hostFormat = _textLayoutFormat;
				this.updateUI();
			}
		}
		
		[Inspectable]
		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:Number):void
		{
			if( _paddingBottom !== value)
			{
				_paddingBottom = value;
				//_textLayoutFormat.paddingBottom = _paddingBottom;
				//textContainerManager.hostFormat = _textLayoutFormat;
			}
		}
		private var _maxChars:int=0;
		public function get textFlow():TextFlow
		{
			return null;
		}
		[Inspectable(defaultValue =0)]
		public function get maxChars():int
		{
			return _maxChars;
		}
		public function set maxChars(value:int):void
		{
			_maxChars = value;
			//updateUI();
		}
		
		
		//[Inspectable(defaultValue=false)]
		/**
		 * 是否可以滚动文本 
		 */
		public function get scrollText():Boolean
		{
			return _scrollText;
		}	
		[Deprecated(message="这个已经废弃了，请改用: 不滚动[ILabel.multiline = true;ILabel.autoBound = true;],滚动[ILabel.multiline = true;ILabel.autoBound = false;]")]
		public function set scrollText(value:Boolean):void
		{
			if(_scrollText!=value){
				_scrollText = value;
				if(_scrollText){
					this.multiline = true;
					this.autoBound = false;
				}else{
					this.multiline = true;
					this.autoBound = true;
				}
				//Log.info("这个禁止滚动的。还没有实现。");
				textField.mouseWheelEnabled =_scrollText;
			}
			
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
		
		//[Inspectable(enumeration="subpixel,none,pixel",defaultValue = "none")]
		public function get gridFitType():String
		{
			return null;
		}
		[Deprecated]	
		public function set gridFitType(value:String):void
		{
			/*if(_gridFitType!=value){
			_gridFitType = value;
			textfield.gridFitType = _gridFitType;
			this.updateUI();
			}	*/		
		}
		[Inspectable(defaultValue=false)]
		/**
		 * 是否多行 
		 * @return 
		 * 
		 */
		public function get multiline():Boolean
		{
			return _multiline;
		}
		//[Deprecated(message="这个属性已经不在使用，")]
		public function set multiline(value:Boolean):void
		{
			if(_multiline!=value){
				_multiline = value;
				this.textField.multiline = _multiline;
				textField.wordWrap = _multiline;
				if(_multiline){					
					//_textLayoutFormat.lineBreak = LineBreak.TO_FIT;
					//_textLayoutFormat.breakOpportunity = BreakOpportunity.AUTO;
					
				}else{	
					
					//_textLayoutFormat.lineBreak = LineBreak.EXPLICIT;
					//_textLayoutFormat.breakOpportunity = BreakOpportunity.NONE;
					
				}	
				//textContainerManager.hostFormat =_textLayoutFormat;
				//textContainerManager.getTextFlow().format = _textLayoutFormat;
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
		[Deprecated(message="这个属性已经不在使用，请使用 lineHeight")]
		public function set leading(value:Number):void
		{
			if(_leading != value){
				_leading = value;
				if(_multiline==false){
					//textFormat.leading = 0;
					lineHeight = null;
				}else{
					//textFormat.leading = _leading;
					//lineHeight =_leading;
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
				
			}			
		}
		
		//[Inspectable(defaultValue = false)]
		/**
		 * 是否显示成html 
		 */
		public function get showHtml():Boolean
		{
			return _showHtml;
		}
		[Deprecated(message="已经不用了，要显示 富文本请使用 IRichText 组件")]
		public function set showHtml(value:Boolean):void
		{	
			
			if(_showHtml!==value){
				_showHtml = value;
				//this._text = "<p>"+this._text+"</p>"				
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
		 * 
		 * 自动尺寸 
		 */
		public function get autoSize():String
		{
			return _autoSize;
		}
		
		[Deprecated(message="autoSize 已经不使用了,请使用 ILabel.autoBound",replacement="ILabel.autoBound")]		
		public function set autoSize(value:String):void
		{
			if(_autoSize!= value){
				_autoSize = value;	
				if(_autoSize!=TextFieldAutoSize.NONE){
					_autoBound = true;
				}else{
					_autoBound = false;
				}
				this.updateUI();
			}	
			
		}
		
		override public function dispose():void
		{
			/*currentLinkData = null;
			removeTextFlowEvent();
			
			styleSheet.clear();
			
			while(textContainerManager.getTextFlow().numChildren>0){
			textContainerManager.getTextFlow().removeChildAt(0);
			}
			
			//textContainerManager.getTextFlow().flowComposer.removeAllControllers();
			textContainerManager.getTextFlow().flowComposer = null;
			textContainerManager.getTextFlow().interactionManager = null;
			textContainerManager.hostFormat = null;
			container.removeChildren();
			container.graphics.clear();
			
			if(stage!=null){
			stage.removeEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
			}
			_textLayoutFormat =null;
			configuration=null;
			textContainerManager =null;
			container=null;
			container = null;
			aMarkData=null;
			super.dispose();*/
		}	
		protected function interactionManager():ISelectionManager{
			
			if(this._selectable){
				return new SelectionManager();
			}else{
				return null;
			}
			
		}		
		
		private function changeCCSize(w:Number,h:Number):void{
			
			
			if(ccw!=w || cch!=h){
				ccw=w;
				cch=h;
			}
			
		}
		
		override public function updateUI():void		
		{
			
			//textFormat.bold =true;
			
			textField.defaultTextFormat = textFormat;
			
			if(isHtml){
				textField.htmlText =_text;
			}else{
				textField.text = _text;
			}			
			
			
			textField.width = trueWidth;
			textField.height = trueHeight;
			
			
			textField.y=0;
			textField.x=0;
			
				var rect:Rectangle = textField.getCharBoundaries(0);
			
			if(_verticalAlign==VerticalAlign.MIDDLE){
				textField.y =0;	
			}else{
								
				
				
				textField.y=-rect.y;
				textField.x=-rect.x;
				
				
				textField.x =this.paddingLeft-rect.x-1;
				textField.y =this.paddingTop-rect.y-3;
				
			}
			var w:Number= 0;
			var h:Number = 0;
			if(textField.border){	
				w = textField.x+textField.width+2+paddingRight;
				h = textField.y+textField.height+2+paddingBottom;
			}else{
				w = textField.x+textField.width-2+paddingRight;
				h = textField.y+textField.height-3+paddingBottom;
			}
			
			drawBorder(w,h);
			changeTrueSize(w,h);
			reTextImagesLayout();
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
				
				if(_bold){
					this.textFormat.bold = true;
					textFormat.font = FontNames.MS_YaHeiBold;
				}else{
					this.textFormat.bold = false;
					textFormat.font = FontNames.MS_YaHei;
				}
				
				
				this.updateUI();
			}		
			
		}	
		
		override public function createUI():void
		{		
			
			this.addChildAt(textField,0);
			onYaheiFontLoadedHandelr(null);
			//textContainerManager.getTextFlow().interactionManager = interactionManager();
			//this.addChild(container);
			
			
			
			
		}
		override public function onStageHandler(event:Event):void
		{
			
			stage.addEventListener(ControlEvent.FONT_LOADED,onYaheiFontLoadedHandelr);
			
		}
		
		protected function onYaheiFontLoadedHandelr(event:Event):void
		{
			//textFormat.font = FontNames.MS_YaHei;
			//textField.setTextFormat(textFormat);
			
			//this.updateUI();
			var fonts:Array = Font.enumerateFonts();
			if(fonts.length>=2){
				var fontName:String = Font(fonts[0]).fontName+Font(fonts[1]).fontName;
				if(fontName.indexOf(FontNames.MS_YaHei)!=-1 && fontName.indexOf(FontNames.MS_YaHeiBold)!=-1){
					//当还没有载入字体时，设置会出错
					textField.embedFonts = true;
					this.updateUI();
				}
			}
			
		}
		
		[Inspectable(defaultValue = 0x333333)]
		public function get color():String
		{
			return _color;
		}
		
		public function set color(value:String):void
		{
			if(_color!= value){
				_color = value;
				
				this.textFormat.color = uint(value);
			}	
			
		}			
		//[Inspectable(defaultValue = false)]
		public function get border():Boolean
		{
			return _border;
		}
		[Deprecated(message="border 已经废弃掉了，设置无效。",replacement="无")]
		public function set border(value:Boolean):void
		{
			
			if(_border!= value){
				_border = value;	
				this.textField.border = _border;
			}	
			
		}		
		//[Inspectable(defaultValue = false)]
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}
		[Deprecated(message="已经废弃了，改用 multiline")]
		public function set wordWrap(value:Boolean):void
		{
			if(_wordWrap!= value){
				_wordWrap = value;		
				textField.wordWrap = _wordWrap;
				multiline = _wordWrap;
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
				_fontSize = value;				
				this.textFormat.size = _fontSize;
				updateUI();	
				//textContainerManager.updateContainer();
				//textContainerManager.compose();
				/*textContainerManager.updateContainer();
				textContainerManager.compose();
				textContainerManager.hostFormat=_textLayoutFormat;	*/	
			}			
			
		}			
		[Inspectable(enumeration = "left,right,center,justify",defaultValue = "left")]
		public function get align():String
		{
			
			return _align;
		}
		[Deprecated(message="这个属性不使用了，改用 textAlign,",replacement="textAlign")]
		public function set align(value:String):void
		{			
			if(_align!= value){
				_align = value;				
				//_textAlign = _align;				
				this.textAlign = _align;			
			}
			
		}		
		protected function clearnAddText():void{
			/*	while(_textFlow.numChildren>0){
			_textFlow.removeChildAt(0);
			}
			while(p.numChildren>0){
			p.removeChildAt(0);
			}
			
			p.addChild(textContext);
			//trace(textTextFlow.numChildren);
			this._textFlow.addChild(p);
			textContext.text="";
			cc.setTextFlow(_textFlow);
			cc.compose();*/
			
			
		}
		public function set text(value:String):void
		{
			isHtml = false;
			_text= value;
			this.updateUI();
			
		}
		[Inspectable(defaultValue = "default label")]
		/**
		 *@default TextFieldAutoSize.NONE
		 */
		public function get text():String
		{
			//return _textFlow.getText();	
			return this.textField.text;
		}
		/**
		 * 
		 * @param type TextConverter 的静态属性
		 * @param conversionType ConversionType 的静态属性
		 * 
		 * @return 
		 * @see flashx.textLayout.conversion.TextConverter
		 * @see flashx.textLayout.conversion.ConversionType
		 */		
		public function exportText(type:String,conversionType:String):Object{
			
			return this.textField.htmlText;			
			
			
		}
	}
}