package com.sanbeetle.component.child
{
	import com.sanbeetle.core.TextBox;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.formats.BlockProgression;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class SideExtendButton extends ExtendButton
	{
		
		public function SideExtendButton(up:DisplayObject=null, over:DisplayObject=null, down:DisplayObject=null)
		{
			super(up, over, down);
			
			btnlabel.paddingBottom = 0;
			btnlabel.paddingRight=0;
			btnlabel.paddingTop=0;
			btnlabel.paddingLeft=0;
			btnlabel.autoBound = true;
			//this.btnlabel.border =true;
			//btnlabel.wordWrap =true;			
			btnlabel.multiline = false;
			
			//btnlabel.multiline = true;
			//btnlabel.leading = 0;
			this.btnlabel.blockProgression = BlockProgression.RL;
			
			//btnlabel.paddingBottom =0;
		}
		
		override protected function reDrawMask():void
		{
			
			var matixg:Matrix =new Matrix()//矩阵  
			matixg.createGradientBox(btnlabel.height,trueWidth,0,0,0);
			//matixg.translate(-(trueWidth/2),-(trueHeight/2));
			matixg.rotate(Math.PI/2);
			
			//Console.out("components"+sf);
			var beCo:uint = uint(color);
			var enCo:uint = beCo-sf;			
			
			textMask.graphics.clear();
			//textMask.graphics.lineStyle(1,0xff0000);
			textMask.graphics.beginGradientFill(GradientType.LINEAR,[beCo,enCo],[1,1],[0x00,0xff],matixg);
			textMask.graphics.drawRect(0,0,trueWidth,btnlabel.height);
			textMask.graphics.endFill();		
			
			//textMask.height =int(btnlabel.fontSize)+1;
			
			textMask.y =(trueHeight-textMask.height)/2;
			
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
			
			//btnlabel.width = trueWidth-11;
			//btnlabel.height = trueHeight-15;
			btnlabel.x = (trueWidth/2)-((btnlabel.width/2+9)/2);
			//btnlabel.x=trueWidth-btnlabel.height;
			//btnlabel.x = 0;
			textMask.x = 0;
			var rect:Rectangle= btnlabel.getBounds(textMask);
			
		}
		
		
	}
}