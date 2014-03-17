package com.asvital.text.elements
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.text.engine.ContentElement;
	import flash.text.engine.GraphicElement;

	public class GraphicsElement extends BaseElement
	{
		private var graphic:GraphicElement;
		public function GraphicsElement()
		{
			super();
			
			var te:Sprite = new Sprite();
			
			graphic=new GraphicElement(te);
		}
		
		override public function getContentElement(eventDispather:EventDispatcher=null):ContentElement
		{
			// TODO Auto Generated method stub
			return graphic;
		}
		
	}
}