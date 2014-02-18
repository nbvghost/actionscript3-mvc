package com.sanbeetle.core
{
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.model.AMark;
	import com.sanbeetle.utils.FontNames;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.net.URLVariables;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.BreakOpportunity;
	import flash.text.engine.FontWeight;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.edit.IEditManager;
	import flashx.textLayout.edit.ISelectionManager;
	import flashx.textLayout.edit.SelectionManager;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.events.FlowOperationEvent;
	import flashx.textLayout.formats.BlockProgression;
	import flashx.textLayout.formats.LineBreak;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.operations.DeleteTextOperation;
	import flashx.textLayout.operations.FlowOperation;
	import flashx.textLayout.operations.InsertTextOperation;
	import flashx.textLayout.operations.PasteOperation;
	
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
		
		
		protected var textContainerManager:ExtendsTextContainerManager;
		protected var container:Sprite;
		private var _textLayoutFormat:TextLayoutFormat;
		private var configuration:Configuration;
		private var styleSheet:StyleSheet = new StyleSheet();
		
		private var _autoBound:Boolean = false;		
		
		
		private var ccw:Number;
		private var cch:Number;		
		
		
		private var _verticalAlign:String="inherit";
		
		private var _currentLinkData:AMark;
		
		private var _blockProgression:String =BlockProgression.TB;
		
		private var isXMLText:Boolean = false;	
		
		private var textField:TextField;
		
		private var isHtml:Boolean = false;
		
		
		private var textFormat:TextFormat;
		
		public function NormalTextBox()
		{			
			textField = new TextField();
			textField.border = true;
			textField.antiAliasType=AntiAliasType.ADVANCED;
			textField.width = 200;
			textField.height = 200;
			
			textField.multiline =true;
			textField.wordWrap = true;
			
			textFormat = new TextFormat(FontNames.MS_YaHei,22,0xff0000,false);
			textField.setTextFormat(textFormat);
			
			
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
			return _textLayoutFormat;
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
				
				_textLayoutFormat.blockProgression = _blockProgression;
				
				textContainerManager.hostFormat =_textLayoutFormat;
				
				
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
				_textLayoutFormat.verticalAlign = _verticalAlign;
				this.updateUI();
			}
			
		}
		public function setFocus():void{
			if(textContainerManager.getTextFlow().interactionManager){
				
				textContainerManager.getTextFlow().interactionManager.setFocus();
				textContainerManager.getTextFlow().interactionManager.flushPendingOperations();
			}	
			
		}
		protected function addTextFlowEvent():void{
			if(textContainerManager==null){
				return;
			}
			textContainerManager.addEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN,onFlowOperationBedginHandler);
			textContainerManager.addEventListener(FlowOperationEvent.FLOW_OPERATION_COMPLETE,onFlowOperationCompleteHandler);
			textContainerManager.addEventListener(FlowOperationEvent.FLOW_OPERATION_END,onFlowOperationEndHandler);
			textContainerManager.addEventListener(FlowElementMouseEvent.MOUSE_DOWN,onFlowElementMouseDownHandler);		
			
			var tf:TextFlow= textContainerManager.getTextFlow();
			
			tf.addEventListener(FlowElementMouseEvent.MOUSE_MOVE,onFlowElementMoveHandler);
			tf.addEventListener(FlowElementMouseEvent.ROLL_OUT,onFlowElementOutHandler);
			tf.addEventListener(FlowElementMouseEvent.ROLL_OVER,onFlowElementOverHandler);
			
		}	
		
		protected function removeTextFlowEvent():void{
			
			if(textContainerManager==null){
				return;
			}
			textContainerManager.removeEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN,onFlowOperationBedginHandler);
			textContainerManager.removeEventListener(FlowOperationEvent.FLOW_OPERATION_COMPLETE,onFlowOperationCompleteHandler);
			textContainerManager.removeEventListener(FlowOperationEvent.FLOW_OPERATION_END,onFlowOperationEndHandler);			
			textContainerManager.removeEventListener(FlowElementMouseEvent.MOUSE_DOWN,onFlowElementMouseDownHandler);			
			
			
			var tf:TextFlow= textContainerManager.getTextFlow();
			
			tf.removeEventListener(FlowElementMouseEvent.MOUSE_MOVE,onFlowElementMoveHandler);
			tf.removeEventListener(FlowElementMouseEvent.ROLL_OUT,onFlowElementOutHandler);
			tf.removeEventListener(FlowElementMouseEvent.ROLL_OVER,onFlowElementOverHandler);
			
			
		}		
		protected function onFlowElementOverHandler(event:FlowElementMouseEvent):void
		{
			
			var lin:LinkElement = event.flowElement as LinkElement;
			if(lin){
				
				disTextEvent(lin,ControlEvent.TEXT_LINK_OVER);
			}
			
			
		}
		
		protected function onFlowElementOutHandler(event:FlowElementMouseEvent):void
		{
			// TODO Auto-generated method stub
			var lin:LinkElement = event.flowElement as LinkElement;
			if(lin){
				
				disTextEvent(lin,ControlEvent.TEXT_LINK_OUT);
				
			}
			
			
		}
		
		protected function onFlowElementMoveHandler(event:FlowElementMouseEvent):void
		{
			// TODO Auto-generated method stub
			var lin:LinkElement = event.flowElement as LinkElement;
			if(lin){
				
				disTextEvent(lin,ControlEvent.TEXT_LINK_MOVE);
			}
		}
		
		protected function onFlowOperationEndHandler(event:FlowOperationEvent):void
		{
			var op:FlowOperation = event.operation;
			if (op is InsertTextOperation)
			{
				var insertTextOperation:InsertTextOperation =InsertTextOperation(op);
				
				var textToInsert:String = insertTextOperation.text;
				
				// Note: Must process restrict first, then maxChars,
				// then displayAsPassword last.	
				
				
				// The text deleted by this operation.  If we're doing our
				// own manipulation of the textFlow we have to take the deleted
				// text into account as well as the inserted text.
				var delSelOp:SelectionState = insertTextOperation.deleteSelectionState;
				
				var delLen:int = (delSelOp == null) ? 0 :
					delSelOp.absoluteEnd - delSelOp.absoluteStart;
				
				if (maxChars != 0)
				{
					var length1:int = text.length - delLen;
					var length2:int = textToInsert.length;
					if (length1 + length2 > maxChars)
						textToInsert = textToInsert.substr(0, maxChars - length1);
				}				
				
				insertTextOperation.text = textToInsert;
			}else if (op is PasteOperation){
				handlePasteOperation(op as PasteOperation);
			}	
			
			textContainerManager.endInteraction();
			
			
		}
		private function handlePasteOperation(op:PasteOperation):void
		{
			// If copied/cut from displayAsPassword field the pastedText
			// is '*' characters but this is correct.
			var pastedText:String = op.textScrap.textFlow.getText();
			// See if there is anything we need to do.
			
			
			// Save this in case we modify the pasted text.  We need to know
			// how much text to delete.
			var textLength:int = pastedText.length;
			
			
			
			// We know it's an EditManager or we wouldn't have gotten here.
			var editManager:IEditManager = EditManager(textContainerManager.getTextFlow().interactionManager);
			
			// Generate a CHANGING event for the PasteOperation but not for the
			// DeleteTextOperation or the InsertTextOperation which are also part
			// of the paste.
			
			
			var selectionState:SelectionState = new SelectionState(
				op.textFlow, op.absoluteStart, 
				op.absoluteStart + textLength);             
			editManager.deleteText(selectionState);
			
			// Insert the same text, the same place where the paste was done.
			// This will go thru the InsertPasteOperation and do the right
			// things with restrict, maxChars and displayAsPassword.
			selectionState = new SelectionState(
				op.textFlow, op.absoluteStart, op.absoluteStart);
			editManager.insertText(pastedText, selectionState);        
			
			// All done with the edit manager.
			
			
			//dispatchChangeAndChangingEvents = true;
		}
		
		public function get textXML():String{
			
			return "";
		}
		private var imagesArr:Array = [];
		public function set textXML(value:String):void{		
			
			isHtml = true;
			
			var imgData:Array = [];
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
					imgStr = String(strsA[0]).replace(/\ /g,"&").replace(/\'/g,"").replace(/\"/g,"");
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
			
			//_text = value;
			
			this.updateUI();
			
			
			var imgEnd:int = 0;
			var imgIndex:int = 0;
			var rect:Rectangle;
			var index:int = 0;
			while(true){
				imgIndex = textField.text.indexOf("□",imgEnd);
				trace(textField.text);
				if(imgIndex==-1){
					break;
				}
				rect =textField.getCharBoundaries(imgIndex);
				img = new TextImage();
				img.setBoundaries(rect);
				img.x = rect.x;
				img.y = rect.y;
				this.addChild(img);
				img.setImageData(imgData[index]);
				imagesArr.push(img);
				index++;
				imgEnd = imgIndex+1;
			}
			
		}	
		protected function onFlowElementMouseDownHandler(event:FlowElementMouseEvent):void
		{			
			var lin:LinkElement = event.flowElement as LinkElement;
			if(lin){
				
				disTextEvent(lin,ControlEvent.TEXT_LINK);
			}
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
			//Log.out("b");
			_text = textContainerManager.getTextFlow().getText();
			
			this.dispatchEvent(new Event(Event.CHANGE));	
			
			if(event.operation is DeleteTextOperation){
				/*if(p.parent==null){
				this.clearnAddText();					
				}*/
			}
			
			//trace(p.parent);
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
		protected function onFlowOperationBedginHandler(event:FlowOperationEvent):void
		{
			var intotxt:InsertTextOperation = event.operation as InsertTextOperation;			
			
			
			
			var str:String;
			if(intotxt)
			{
				str = text+intotxt.text;
				if(_regExp!=null)
				{
					if(!_regExp.test(str))
					{
						event.preventDefault();
						return;
					}
				}
				
				if ( maxChars > 0 )
				{
					var _o:int = getStringBytesLength(this._text,"gb2312");
					if(_o>maxChars)
					{	
						event.preventDefault();
					}
					else
					{
						intotxt.text = intotxt.text.substring( 0, maxChars - _o );							
						while(  maxChars < _o + getStringBytesLength( intotxt.text ,"gb2312") )
						{
							intotxt.text = intotxt.text.substring( 0, intotxt.text.length - 1 );
						}
					}
				}
			}
			
			
			
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
				_textLayoutFormat.textAlign = _textAlign;	
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
				_textLayoutFormat.lineHeight = _lineHeight;
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
			if(textContainerManager==null){
				return null;
			}
			return textContainerManager.getTextFlow();
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
				//textfield.mouseWheelEnabled =_scrollText;
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
				if(_multiline){					
					
					_textLayoutFormat.lineBreak = LineBreak.TO_FIT;
					_textLayoutFormat.breakOpportunity = BreakOpportunity.AUTO;
					
				}else{	
					
					_textLayoutFormat.lineBreak = LineBreak.EXPLICIT;
					_textLayoutFormat.breakOpportunity = BreakOpportunity.NONE;
					
				}	
				textContainerManager.hostFormat =_textLayoutFormat;
				textContainerManager.getTextFlow().format = _textLayoutFormat;
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
			_currentLinkData = null;
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
			super.dispose();
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
			textField.setTextFormat(textFormat);
			
			if(isHtml){
				textField.htmlText =_text;
			}else{
				textField.text = _text;
			}
			
			
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
					_textLayoutFormat.fontWeight = FontWeight.BOLD;
				}else{
					_textLayoutFormat.fontWeight = FontWeight.NORMAL;
				}
				
				textContainerManager.hostFormat =_textLayoutFormat;
				//textContainerManager.updateContainer();
				this.updateUI();
			}		
			
		}	
		
		override public function createUI():void
		{		
			
			onYaheiFontLoadedHandelr(null);
			//textContainerManager.getTextFlow().interactionManager = interactionManager();
			//this.addChild(container);
			
			this.addChildAt(textField,0);
			
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
			//textField.embedFonts = true;		
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
				_textLayoutFormat.color = uint(value);			
				textContainerManager.hostFormat= _textLayoutFormat;
				textContainerManager.updateContainer();
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
				_textLayoutFormat.fontSize = _fontSize;				
				textContainerManager.hostFormat=_textLayoutFormat;
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
			textField.text = _text;
			this.updateUI();
			
		}
		[Inspectable(defaultValue = "default label")]
		/**
		 *@default TextFieldAutoSize.NONE
		 */
		public function get text():String
		{
			//return _textFlow.getText();	
			return textContainerManager.getTextFlow().getText();
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
			
			return TextConverter.export(textContainerManager.getTextFlow(),type,conversionType);				
			
			
		}
	}
}