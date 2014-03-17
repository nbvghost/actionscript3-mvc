package com.asvital.text.elements
{
	import flash.text.StyleSheet;
	import flash.text.engine.ElementFormat;
	
	
	
	public class SpanElement extends BaseTextElement
	{
		
		public function SpanElement(text:String,attribs:XMLList,textformat:ElementFormat,_styleSheet:StyleSheet,fontWeight:Boolean=false)
		{								
			super(text,attribs,textformat,_styleSheet);
		}
		
	}
}