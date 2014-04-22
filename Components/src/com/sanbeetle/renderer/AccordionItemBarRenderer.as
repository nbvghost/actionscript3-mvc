package com.sanbeetle.renderer
{
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.core.DisplayItem;
	
	import flash.display.Shape;
	
	import flashx.textLayout.formats.VerticalAlign;

	public class AccordionItemBarRenderer extends DisplayItem 
	{
		private var shape:Shape = new Shape();
		
		private var ilabel:ILabel = new ILabel();
		
		public function AccordionItemBarRenderer(){
			this.addChild(ilabel);
			ilabel.x = 0;
		}
		
		
		override public function get contentHeight():Number
		{
			// TODO Auto Generated method stub
			return ilabel.height;
		}
		
		override public function get contentWidth():Number
		{
			// TODO Auto Generated method stub
			return ilabel.width;
		}
		
		override protected function createUI():void
		{
			ilabel.verticalAlign = VerticalAlign.MIDDLE;
			ilabel.text = this.data.label;
			
		}
		
		override protected function drawLayout(cw:Number, ch:Number, autoLayOut:Boolean=false):void
		{
			ilabel.width = cw-0;
			ilabel.height = 24;
			
			/*shape.graphics.clear();
			shape.graphics.beginFill(0xffffff*Math.random());			
			shape.graphics.drawRect(0,0,cw,ch);
			shape.graphics.endFill();*/
			
		}
		
	}
}