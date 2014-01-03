package com.sanbeetle.component.child
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * @author sixf
	 * 日期：2013-11-11 下午3:40:43 2013
	 * Administrator
	 */
	public class ProgressBarSkin extends Sprite
	{
		private var ww:int =67;
		private var hh:int=9;
		
		private var bg:Shape;
		private var c:Shape;
		
		private var _border:int = 0;		
		private var _borderColor:uint =0x000000;
		private var _borderAlpha:Number = 1;
		
		private var _slipColor:uint=0x234E02;
		private var _backgroundColor:uint=0xDDE6D6;
		
		private var _currentValue:Number=1;
		
		public function ProgressBarSkin()
		{
			bg = new Shape();
			c = new Shape();
			this.addChild(bg);
			this.addChild(c);
			
			
		}

		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}

		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
			reDraw();
		}

		public function get borderColor():uint
		{
			return _borderColor;
		}

		public function set borderColor(value:uint):void
		{
			_borderColor = value;
			reDraw();
		}

		public function get border():int
		{
			return _border;
		}

		public function set border(value:int):void
		{
			_border = value;
			reDraw();
		}

		public function get currentValue():Number
		{
			return _currentValue;
		}

		public function set currentValue(value:Number):void
		{
			_currentValue = value;
			reDraw();
		}

		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
			reDraw();
		}

		public function get slipColor():uint
		{
			return _slipColor;
		}

		public function set slipColor(value:uint):void
		{
			_slipColor = value;
			reDraw();
		}

		public function setSize(w:int=67,h:int=9):void{
			this.ww =w;
			this.hh =h;			
			reDraw();
		}
		public function reDraw():void{
			
			if(_currentValue>1){
				_currentValue=1;
			}
			if(_currentValue<0){
				_currentValue=0;
			}
			if(isNaN(_currentValue)){
				_currentValue = 0;
			}
			
			bg.graphics.clear();
			bg.graphics.lineStyle(_border,_borderColor,_borderAlpha);
			bg.graphics.beginFill(_backgroundColor);
			bg.graphics.drawRect(0,0,ww,hh);
			
			c.graphics.clear();
			c.graphics.lineStyle(_border,_borderColor,_borderAlpha);
			c.graphics.beginFill(_slipColor);
			c.graphics.drawRect(0,0,ww*(int(_currentValue*100))/100,hh);
			
		}
	}
}