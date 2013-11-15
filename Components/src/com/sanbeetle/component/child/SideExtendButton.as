package com.sanbeetle.component.child
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class SideExtendButton extends ExtendButton
	{
		public function SideExtendButton(up:DisplayObject=null, over:DisplayObject=null, down:DisplayObject=null)
		{
			super(up, over, down);
			
			//this.btnlabel.border =true;
			btnlabel.wordWrap =true;			
			btnlabel.multiline = true;		
			btnlabel.leading = 0;
		}
		
		override protected function reDrawMask():void
		{
			
			var matixg:Matrix =new Matrix()//矩阵  
			matixg.createGradientBox(trueHeight,trueWidth,0,0,0);
			//matixg.translate(-(trueWidth/2),-(trueHeight/2));
			matixg.rotate(Math.PI/2);
			
			//Console.out("components"+sf);
			var beCo:uint = uint(color);
			var enCo:uint = beCo-sf;			
			
			textMask.graphics.clear();
			//textMask.graphics.lineStyle(1,0xff0000);
			textMask.graphics.beginGradientFill(GradientType.LINEAR,[beCo,enCo],[1,1],[0x00,0xff],matixg);
			textMask.graphics.drawRect(0,0,trueWidth,trueHeight);
			textMask.graphics.endFill();		
			
			//textMask.height =int(btnlabel.fontSize)+1;
			
			textMask.y =(trueHeight-textMask.height)/2;
			textMask.x = 0;
		}
		
		override protected function maskTarget():void
		{
			// TODO Auto Generated method stub
			super.maskTarget();
		}
		
		
		override protected function createUI():void
		{
			// TODO Auto Generated method stub
			super.createUI();
			//this.btnlabel.width = 12;
		}
		
		override public function get align():String
		{
			// TODO Auto Generated method stub
			return TextFormatAlign.LEFT;
		}
		
		override public function get autoSize():String
		{
			// TODO Auto Generated method stub
			return TextFieldAutoSize.NONE;
		}
		
		override protected function updateUI():void
		{
			// TODO Auto Generated method stub
			super.updateUI();
			
			btnlabel.width = trueWidth-11;
			btnlabel.height = trueHeight-15;
		}
		
		
	}
}