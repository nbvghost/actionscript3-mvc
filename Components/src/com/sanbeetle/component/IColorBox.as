package com.sanbeetle.component
{
	import com.sanbeetle.core.UIComponent;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Matrix;
	
	public class IColorBox extends UIComponent
	{
		private var _lineSize:Number = 1;
		private var _lineColor:String="0x000000";
		private var _lineAlpha:Number=1;
		
		private var _roundSize:Number = 0;
		private var _contentColorBegin:String="0xff0000";
		private var _contentColorEnd:String="0x00ff00";
	
		
		private var _contentColorRotate:Number = 90;
		
		public function IColorBox()
		{
			super();
			
		}
		[Inspectable(defaultValue=90)]
		public function get contentColorRotate():Number
		{
			return _contentColorRotate;
		}

		public function set contentColorRotate(value:Number):void
		{
			_contentColorRotate = value;
			updateUI();
		}

		[Inspectable(defaultValue="0x00ff00")]
		public function get contentColorEnd():String
		{
			return _contentColorEnd;
		}

		public function set contentColorEnd(value:String):void
		{
			_contentColorEnd = value;
			updateUI();
		}
		[Inspectable(defaultValue="0xff0000")]
		public function get contentColorBegin():String
		{
			return _contentColorBegin;
		}

		public function set contentColorBegin(value:String):void
		{
			_contentColorBegin = value;
			updateUI();
		}
		[Inspectable(defaultValue=0)]
		public function get roundSize():Number
		{
			return _roundSize;
		}

		public function set roundSize(value:Number):void
		{
			_roundSize = value;
			updateUI();
		}
		[Inspectable(defaultValue=1)]
		public function get lineAlpha():Number
		{
			return _lineAlpha;
		}

		public function set lineAlpha(value:Number):void
		{
			_lineAlpha = value;
			updateUI();
		}
		[Inspectable(defaultValue="0x000000")]
		public function get lineColor():String
		{
			return _lineColor;
		}

		public function set lineColor(value:String):void
		{
			_lineColor = value;
			updateUI();
		}
		[Inspectable(defaultValue=1)]
		public function get lineSize():Number
		{
			return _lineSize;
		}

		public function set lineSize(value:Number):void
		{
			_lineSize = value;
			updateUI();
		}
		
		override public function createUI():void
		{
			// TODO Auto Generated method stub
			super.createUI();
			updateUI();
		}
		
		override public function updateUI():void
		{
			
			var matixg:Matrix =new Matrix()//矩阵  
			matixg.createGradientBox(trueWidth,trueHeight,((2*Math.PI)/360)*_contentColorRotate,0,0);	
			
			
			this.graphics.clear();
			if(lineSize>0){
				this.graphics.lineStyle(lineSize,uint(lineColor),lineAlpha,true,LineScaleMode.NONE,CapsStyle.ROUND,JointStyle.MITER);		
			}				
			this.graphics.beginGradientFill(GradientType.LINEAR,[_contentColorBegin,_contentColorEnd],[1,1],[0,255],matixg);
			this.graphics.drawRoundRect(0,0,this.trueWidth,this.trueHeight,_roundSize,_roundSize);
			this.graphics.endFill();
			
			
			//this.graphics.drawRoundRect(0,0,this.trueWidth,this.trueHeight,_roundSize,_roundSize);
			//this.graphics.endFill();
			
			
			
		}
		
		
	}
}