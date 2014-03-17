package com.asvital.text
{
	import com.asvital.text.elements.BaseTextElement;
	import com.asvital.text.elements.LinkElement;
	import com.asvital.text.elements.SpanElement;
	import com.asvital.text.event.FTEOperationEvent;
	import com.sanbeetle.Component;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextBaseline;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	import flash.text.ime.CompositionAttributeRange;
	import flash.text.ime.IIMEClient;
	
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.VerticalAlign;
	
	[Event(name="LinkMouseDown", type="com.asvital.text.event.FTEOperationEvent")]
	[Event(name="LinkMouseOver", type="com.asvital.text.event.FTEOperationEvent")]
	[Event(name="LinkMouseOut", type="com.asvital.text.event.FTEOperationEvent")]
	
	public class FTETextField extends Sprite implements IIMEClient
	{
		private var textBlocks:Vector.<TextBlock> = new Vector.<TextBlock>();
		
		private var _textFormat:ElementFormat;
		
		private var _text:String;
		private var ishtmlText:Boolean= false;
		
		
		private var _scrollText:Boolean =false;	
		
		private var _styleSheet:StyleSheet=new StyleSheet();
		
		private var _width:Number = 120;
		private var _height:Number = 120;
		
		private var _border:Boolean = false;
		
		private var _autoSize:Boolean = false;
		
		
		private var setWidth:Number=120;
		private var setHeight:Number = 120;
		
		
		private var _textWidth:Number = 0;
		private var _textHeight:Number =0;
		
		private var _wordWrap:Boolean = false;
		
		
		private var maskTarget:Shape;
		
		private var textContent:Sprite;
		
		
		private var _verticalAlign:String="top";
		private var _horizontalAlign:String="left";
		
		
		
		private var _padding:TextPadding=new TextPadding();
		
		
		private var _lineHeight:uint = 2;
		
		
		private var _attributes:Object={};
		
		
		public function FTETextField()
		{
			super();
			//var t:Number = getTimer();			
			_textFormat= Component.component.elementFormat.clone();			
			_textFormat.fontDescription =Component.component.fontDescription.clone();		
			//_textFormat.color = Math.random()*0xffffff;			
			maskTarget= new Shape();			
			drawBorder();
			//maskTarget.cacheAsBitmap = true;			
			this.addChild(maskTarget);			
			textContent = new Sprite();
			textContent.addEventListener(MouseEvent.MOUSE_OVER,onOverHandler);
			textContent.addEventListener(MouseEvent.MOUSE_DOWN,onDownHandler,true);
			//textContent.addEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
			this.addChild(textContent);			
			textContent.mask = maskTarget;
			//trace(getTimer()-t);
		}
		
		public function get scrollText():Boolean
		{
			return _scrollText;
		}
		
		public function set scrollText(value:Boolean):void
		{
			_scrollText = value;
		}
		
		public function get attributes():Object
		{
			return _attributes;
		}
		
		public function get lineHeight():uint
		{
			return _lineHeight;
		}
		
		public function set lineHeight(value:uint):void
		{
			_lineHeight = value;
		}
		
		protected function onDownHandler(event:MouseEvent):void
		{
			
			
			var currentMouseLine:TextLine = event.target as TextLine;
			
			
			
			if(currentMouseLine){
				
				
				
				var ateIndex:int = currentMouseLine.getAtomIndexAtPoint(event.stageX,event.stageY);
				if(ateIndex==-1){
					return;
				}
				var charIndex:int = ateIndex+currentMouseLine.textBlockBeginIndex;
				//trace(textLine.getAtomIndexAtPoint(event.stageX,event.stageY),textLine.textBlockBeginIndex);
				//trace(textLine.textBlock.content.groupElement.getElementAtCharIndex(charIndex));
				var group:GroupElement = currentMouseLine.textBlock.content as GroupElement;
				if(group){
					contentElement = group.getElementAtCharIndex(charIndex);
					if(contentElement){
						
						var element:BaseTextElement = contentElement.userData;
						if(element){
							_attributes = element.attributes;
							this.dispatchEvent(new FTEOperationEvent(FTEOperationEvent.LinkMouseDown));
						}						
					}
					
				}
			}
			
			this.dispatchEvent(new FTEOperationEvent(FTEOperationEvent.LinkMouseOut));
		}
		protected function onOutHandler(event:MouseEvent):void
		{
			
			textContent.addEventListener(MouseEvent.MOUSE_OVER,onOverHandler);
			textContent.removeEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
			
			if(contentElement){
				
				var element:BaseTextElement = contentElement.userData;
				if(element){
					_attributes = element.attributes;
					this.dispatchEvent(new FTEOperationEvent(FTEOperationEvent.LinkMouseOut));
				}
				if(element && element.defaultFormat){
					
					contentElement.elementFormat = element.defaultFormat;
					createTextLine();
					//trace("a");
				}
			}
			
		}
		private var contentElement:ContentElement;
		
		protected function onOverHandler(event:MouseEvent):void
		{
			
			
			textContent.removeEventListener(MouseEvent.MOUSE_OVER,onOverHandler);
			textContent.addEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
			
			var currentMouseLine:TextLine = event.target as TextLine;
			
			
			
			if(currentMouseLine){
				
				
				
				var ateIndex:int = currentMouseLine.getAtomIndexAtPoint(event.stageX,event.stageY);
				if(ateIndex==-1){
					return;
				}
				var charIndex:int = ateIndex+currentMouseLine.textBlockBeginIndex;
				//trace(textLine.getAtomIndexAtPoint(event.stageX,event.stageY),textLine.textBlockBeginIndex);
				//trace(textLine.textBlock.content.groupElement.getElementAtCharIndex(charIndex));
				var group:GroupElement = currentMouseLine.textBlock.content as GroupElement;
				if(group){
					contentElement = group.getElementAtCharIndex(charIndex);
					if(contentElement){
						
						var element:BaseTextElement = contentElement.userData;
						if(element){
							_attributes = element.attributes;
							this.dispatchEvent(new FTEOperationEvent(FTEOperationEvent.LinkMouseOver));
						}
						if(element && element.linkHoverFormat){
							
							contentElement.elementFormat = element.linkHoverFormat;
							createTextLine();
							//trace("b");
							
							
							
						}
					}
					
				}
			}
		}
		
		
		public function get padding():TextPadding
		{
			return _padding;
		}
		
		public function set padding(value:TextPadding):void
		{
			_padding = value;
			
			//createTextLine();
		}
		
		public function get horizontalAlign():String
		{
			return _horizontalAlign;
		}
		
		public function set horizontalAlign(value:String):void
		{
			_horizontalAlign = value;
			createTextLine();
		}
		
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		public function set verticalAlign(value:String):void
		{
			_verticalAlign = value;
			
			createTextLine();
		}
		
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			_wordWrap = value;
			createTextLine();
		}
		
		public function get textHeight():Number
		{
			return _textHeight;
		}
		
		public function set textHeight(value:Number):void
		{
			_textHeight = value;
		}
		
		public function get textWidth():Number
		{
			return _textWidth;
		}
		
		public function set textWidth(value:Number):void
		{
			_textWidth = value;
		}
		
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		
		public function set autoSize(value:Boolean):void
		{
			_autoSize = value;
			createTextLine();		
		}
		
		public function get compositionEndIndex():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function get compositionStartIndex():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function confirmComposition(text:String=null, preserveSelection:Boolean=false):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function getTextBounds(startIndex:int, endIndex:int):Rectangle
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function getTextInRange(startIndex:int, endIndex:int):String
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function selectRange(anchorIndex:int, activeIndex:int):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get selectionActiveIndex():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function get selectionAnchorIndex():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function updateComposition(text:String, attributes:Vector.<CompositionAttributeRange>, compositionStartIndex:int, compositionEndIndex:int):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get verticalTextLayout():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		
		public function get border():Boolean
		{
			return _border;
		}
		
		public function set border(value:Boolean):void
		{
			_border = value;
			drawBorder();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
			
			this.setHeight=_height;
			
			//createTextLine();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
			
			this.setWidth = _width;
			
			
			//createTextLine();
			
		}
		
		private function drawBorder():void{
			this.graphics.clear();
			if(_border){
				this.graphics.lineStyle(1);
				this.graphics.drawRect(0,0,_width,_height);
				this.graphics.endFill();
			}
			
			maskTarget.graphics.clear();
			maskTarget.graphics.beginFill(0xff0000,0.5);
			maskTarget.graphics.drawRect(0,0,_width,_height);
			maskTarget.graphics.endFill();
		}
		
		public function get styleSheet():StyleSheet
		{
			return _styleSheet;
		}
		
		
		
		/**
		 * 在 htmlText/text 设置之前设置 ,不会替换之前的样式，请用 clearn
		 * @param value
		 * 
		 */
		public function set styleSheet(value:StyleSheet):void
		{
			
			if(value!=null){
				var lent:int = value.styleNames.length;
				for (var i:int = 0; i < lent; i++) 
				{
					_styleSheet.setStyle(value.styleNames[i],value.getStyle(value.styleNames[i]));
				}
				
			}
			
		}
		
		public function get htmlText():String
		{
			return _text;
		}
		
		public function set htmlText(value:String):void
		{
			ishtmlText = true;
			_text = value;
			
			createElements();	
			
		}
		
		
		private function createElements():void{
			
			//var t:Number = getTimer();
			
			while(textContent.numChildren>0){
				
				textContent.removeChildAt(0);
				
			}
			
			var groupBlock:Vector.<ContentElement> = new Vector.<ContentElement>();
			
			textBlocks.splice(0,textBlocks.length);
			if(ishtmlText){
				
				var xml:XML;
				
				
				try{
					xml = new XML("<textformat>"+_text+"</textformat>");
				}catch(e:TypeError){
					throw new TypeError(e.message+" htmlText 必须 是 XML或者只含一个根的元素。");
				}
				
				var xmlChild:XMLList= xml.children();
				var lent:int = xmlChild.length();
				
				for (var i:int = 0; i < lent; i++) 
				{
					var xmlItem:XML = xmlChild[i];
					
					switch(xmlItem.localName()){
						case "a":
							groupBlock.push(new LinkElement(xmlItem.children(),xmlItem.attributes(),_textFormat,_styleSheet).getContentElement(textContent));
							break;
						case "span":
							groupBlock.push(new SpanElement(xmlItem.children(),xmlItem.attributes(),_textFormat,_styleSheet).getContentElement());
							break;
						case "font":
							groupBlock.push(new SpanElement(xmlItem.children(),xmlItem.attributes(),_textFormat,_styleSheet).getContentElement());
							break;
						case "br":							
							textBlocks.push(createTextBlock(groupBlock));
							groupBlock = new Vector.<ContentElement>();
							break;
						case "b":
							groupBlock.push(new SpanElement(xmlItem.children(),xmlItem.attributes(),_textFormat,_styleSheet,true).getContentElement());
							break;
						case "img":
							//groupBlock.push(new GraphicsElement().getContentElement());
							break;
						case null:
							groupBlock.push(new SpanElement(xmlItem,xmlItem.attributes(),_textFormat,_styleSheet).getContentElement());
							break;
						default:
							groupBlock.push(new SpanElement(xmlItem.children(),xmlItem.attributes(),_textFormat,_styleSheet).getContentElement());
							break;
					}
				}
				if(groupBlock.length>0){					
					textBlocks.push(createTextBlock(groupBlock));					
				}
				
				System.disposeXML(xml);
			}else{
				
				groupBlock.push(new TextElement(_text,_textFormat));
				
				if(groupBlock.length>0){
					textBlocks.push(createTextBlock(groupBlock));
				}
				
			}
			if(textBlocks.length>0){
				
				createTextLine();
			}
						
		}
		
		
		private function createTextLine():void{
			
			
			var preTextLine:TextLine=null;
			var textBlock:TextBlock;
			
			var nextTextLine:TextLine;
			
			_textWidth = 0;
			_textHeight = _padding.top;
			
			while(textContent.numChildren>0){
				
				textContent.removeChildAt(0);
				
			}
			var childs:Vector.<TextLine> = new Vector.<TextLine>();
			for (var i:int = 0; i < textBlocks.length; i++) 
			{
				
				textBlock = textBlocks[i];				
				
				preTextLine=null;
				
				while(true){
					if(_wordWrap){						
						nextTextLine = textBlock.createTextLine(preTextLine,setWidth-_padding.left-_padding.right);
					}else{
						nextTextLine = textBlock.createTextLine(preTextLine);
					}
					
					if(nextTextLine!=null){
						
						_textWidth = Math.max(_textWidth,nextTextLine.textWidth);		
						
						textContent.addChild(nextTextLine);
						
						nextTextLine.y = _textHeight;
						
						if(_verticalAlign!=VerticalAlign.TOP){
							
							childs.push(nextTextLine);
						}
						
						//trace(nextTextLine.y);						
						
						if(_autoSize==false){
							if(_horizontalAlign==TextAlign.RIGHT){
								
								nextTextLine.x = _padding.left+(setWidth-nextTextLine.textWidth-_padding.left-_padding.right);
								
							}else if(_horizontalAlign == TextAlign.CENTER){
								
								//nextTextLine.x = _padding.left;
								nextTextLine.x = _padding.left+(setWidth-nextTextLine.textWidth-_padding.left-_padding.right)/2;
								
							}else{
								
								nextTextLine.x = _padding.left;
								
							}
							
							if(_verticalAlign==VerticalAlign.TOP){
								
							}else if(_verticalAlign==VerticalAlign.MIDDLE){
								
							}else{
								nextTextLine.y = _textHeight+_lineHeight;
							}
						}else{
							
							nextTextLine.x = _padding.left;
							nextTextLine.y = _textHeight;
						}
						
						//nextTextLine.mouseChildren = false;
						//nextTextLine.mouseEnabled = false;
						
						_textHeight=(_textHeight+nextTextLine.textHeight)+_lineHeight;
						
						if(nextTextLine.hasGraphicElement){
							nextTextLine.y=_textHeight-preTextLine.height;
						}
						
						//this.graphics.clear();
						//this.graphics.lineStyle(1);		
						//this.graphics.drawRect(nextTextLine.x,nextTextLine.y,nextTextLine.width,nextTextLine.textHeight);
						//this.graphics.endFill();
						
						preTextLine=nextTextLine;
					}else{
						
						for (var j:int = 0; j < childs.length; j++) 
						{
							if(_autoSize==false){
								
								if(_verticalAlign==VerticalAlign.BOTTOM){
									childs[j].y = childs[j].y- (_textHeight-setHeight-_padding.top-_padding.buttom);
									
								}else if(_verticalAlign==VerticalAlign.MIDDLE){
									childs[j].y = childs[j].y- (_textHeight-setHeight-_padding.top-_padding.buttom)/2;
								}else{
									//nextTextLine.y = _textHeight+_lineHeight;
								}
							}
						}
						
						break;
					}
					
				}
				
				_textHeight=_textHeight-_lineHeight;
				
				/*if(_autoSize){
					if(_wordWrap){
						_width = setWidth+_padding.left+_padding.right;
						_height = _textHeight+_padding.buttom;
					}else{
						_width = _textWidth+_padding.left+_padding.right;
						_height = _textHeight+_padding.buttom;
					}
				}*/
				
				if(_autoSize){
					if(_wordWrap){
						_width = setWidth;
						_height = _textHeight+_padding.buttom;
					}else{
						_width = _textWidth+_padding.left+_padding.right;
						_height = _textHeight+_padding.buttom;
					}
				}
				
				
				textBlock.releaseLineCreationData();
			}
			
			
			
			
			
			//trace("_textWidth",_textWidth,_textHeight);
			drawBorder();
		}
		
		public function get text():String
		{
			return _text;
		}
		private function createTextBlock(groupBlock:Vector.<ContentElement>,elementFormat:ElementFormat=null, eventMirror:EventDispatcher=null, textRotation:String="rotate0"):TextBlock{
			var textBlock:TextBlock = new TextBlock();
			
			//textBlock.baselineZero = TextBaseline.ASCENT;	
			textBlock.baselineZero = TextBaseline.IDEOGRAPHIC_TOP;
			textBlock.applyNonLinearFontScaling = true;	
			textBlock.content=new GroupElement(groupBlock,elementFormat,eventMirror,textRotation);
			return textBlock;
		}
		public function set text(value:String):void
		{
			
			ishtmlText = false;
			_text = value;
			
			
			createElements();
			
		}
		
		public function refreshTextLine():void{
			createTextLine();
		}
		
		public function get textFormat():ElementFormat
		{
			
			return _textFormat;
		}
		
		public function set textFormat(value:ElementFormat):void
		{
			if(value!=null){
				if(value.locked){
					_textFormat = value.clone();
				}else{
					_textFormat = value;
				}
			}else{
				return;
			}
			
			
			//createTextLine();
		}
		
	}
}