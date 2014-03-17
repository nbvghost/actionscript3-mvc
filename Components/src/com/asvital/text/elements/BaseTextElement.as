package com.asvital.text.elements
{
	import com.asvital.text.TextUtils;
	
	import flash.events.EventDispatcher;
	import flash.text.StyleSheet;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.TextBaseline;
	import flash.text.engine.TextElement;
	import flash.utils.getTimer;
	
	public class BaseTextElement extends BaseElement
	{
		protected var _defaultFormat:ElementFormat=new ElementFormat();		
		protected var _linkHoverFormat:ElementFormat;
		protected var _linkActiveFormat:ElementFormat;
		
		protected var textElement:TextElement;
		
		private var _text:String;
		protected var styleSheet:StyleSheet;
		
		private var _attributes:Object = {};
		
		public function BaseTextElement(_text:String,attribs:XMLList,textformat:ElementFormat,_styleSheet:StyleSheet)
		{
			super();
			
			//var t:Number = getTimer();
			
			textElement = new TextElement();
			
			this._text = _text;
			this.styleSheet = _styleSheet;
			
			if(textformat){
				
				_defaultFormat = textformat.clone();
			}
			_defaultFormat.dominantBaseline = TextBaseline.ASCENT;
			//_defaultFormat.alignmentBaseline = TextBaseline.ROMAN;
			_defaultFormat.baselineShift=0;
			
			
			
			var lent:int = attribs.length();
			_attributes = {};
			
			
			for (var k:* in attribs) 
			{
				_attributes[QName(attribs[k].name()).localName]= attribs[k];
			}
			
			
			
			
			
			getDefaultStyel(_attributes);
			
			if(_styleSheet){
				var syteArr:Array = String(attributes["styleName"]).split(" ");
				var tf:Object;
				var claseName:String;
				
				lent = syteArr.length;
				
				for (var i:int = 0; i < lent; i++) 
				{
					claseName = syteArr[i];
					
					if(claseName!=null && claseName!="" && claseName!="undefined"){
						
						
						
						tf=TextUtils.GetTextFormFix(claseName,_styleSheet);					
						_defaultFormat = TextUtils.Style2ElementFormat(_defaultFormat,tf);
						
						_defaultFormat = TextUtils.Style2ElementFormat(_defaultFormat,attributes);
						
						_linkHoverFormat = _defaultFormat.clone();
						
						
						_linkActiveFormat = _defaultFormat.clone();
						
						
						tf=TextUtils.GetTextFormFix(claseName,_styleSheet,"hover");					
						_linkHoverFormat = TextUtils.Style2ElementFormat(_linkHoverFormat,tf);
						
						tf=TextUtils.GetTextFormFix(claseName,_styleSheet,"active");			
						_linkActiveFormat = TextUtils.Style2ElementFormat(_linkActiveFormat,tf);
						
					}					
					
				}
				syteArr = String(attributes["class"]).split(" ");
				
				lent = syteArr.length;
				
				for (var j:int = 0; j < lent; j++) 
				{
					claseName = syteArr[j];
					if(claseName!=null && claseName!="" && claseName!="undefined"){
						
						
						tf=TextUtils.GetTextFormFix(claseName,_styleSheet);					
						_defaultFormat = TextUtils.Style2ElementFormat(_defaultFormat,tf);
						
						_defaultFormat = TextUtils.Style2ElementFormat(_defaultFormat,attributes);
						
						_linkHoverFormat = _defaultFormat.clone();
						_linkActiveFormat = _defaultFormat.clone();						
						
						tf=TextUtils.GetTextFormFix(claseName,_styleSheet,"hover");					
						_linkHoverFormat = TextUtils.Style2ElementFormat(_linkHoverFormat,tf);
						
						tf=TextUtils.GetTextFormFix(claseName,_styleSheet,"active");			
						_linkActiveFormat = TextUtils.Style2ElementFormat(_linkActiveFormat,tf);
						
					}
				}	
				
			}	
			
			
			//trace("base text elements",getTimer()-t);
			
			
		}	
		
		public function get attributes():Object
		{
			return _attributes;
		}
		
		protected function getDefaultStyel(attributes:Object):void{
			
			
		}
		
		override public function getContentElement(eventDispather:EventDispatcher=null):ContentElement
		{
			//var t:Number = getTimer();
			textElement.text = _text;
			textElement.elementFormat = defaultFormat;
			if(eventDispather!=null){
				
				textElement.eventMirror = eventDispather;
			}
			textElement.userData = this;
			//trace("getContentElement",getTimer()-t);
			return textElement;
		}
		
		public function get linkActiveFormat():ElementFormat
		{
			return _linkActiveFormat;
		}
		
		public function set linkActiveFormat(value:ElementFormat):void
		{
			_linkActiveFormat = value;
		}
		
		public function get linkHoverFormat():ElementFormat
		{
			return _linkHoverFormat;
		}
		
		public function set linkHoverFormat(value:ElementFormat):void
		{
			_linkHoverFormat = value;
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;			
		}
		
		public function get defaultFormat():ElementFormat
		{
			return _defaultFormat;
		}
		
		public function set defaultFormat(value:ElementFormat):void
		{
			//var t:Number = getTimer();
			_defaultFormat = value;
			if(defaultFormat){
				textElement.elementFormat = defaultFormat;
			}
			
			//trace("set defaultFormat",getTimer()-t);
		}
		
	}
}