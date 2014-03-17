package com.asvital.text.elements
{
	import flash.events.EventDispatcher;
	import flash.text.engine.ContentElement;

	public class BaseElement extends EventDispatcher
	{
		public function BaseElement()
		{
			
		}
		public function getContentElement(eventDispather:EventDispatcher=null):ContentElement{
		
			throw new Error("请重写！"+this);
		}
	}
}