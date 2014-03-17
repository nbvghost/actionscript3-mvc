package com.sanbeetle.component
{	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.TimeProgressBarBack;
	import com.sanbeetle.skin.TimeProgressBarBtn;
	import com.sanbeetle.skin.TimeProgressBarFront;
	
	import flash.events.MouseEvent;
	
	import flashx.textLayout.formats.TextAlign;
	
	[Event(name="close", type="com.sanbeetle.events.ControlEvent")]
	
	public class TimeProgressBar extends UIComponent 
	{
		private var m_back:TimeProgressBarBack = null;
		private var m_front:TimeProgressBarFront = null;
		private var m_btn:TimeProgressBarBtn = null;
		private var m_txt:ILabel = null;
		private var m_pro:ILabel = null;
		
		private var _btnFrame:int = 1;
		
		private var _progress:Number =0;
		private var _txt:String = "-00:00:00";
		
		public function TimeProgressBar()
		{
			m_back = new TimeProgressBarBack();
			m_front = new TimeProgressBarFront();
			
			m_btn = new TimeProgressBarBtn();
			
			m_txt =new ILabel();	
			//m_txt.align = "left";
			m_txt.horizontalAlign = TextAlign.LEFT;
			//m_txt.autoSize = "none";
			m_txt.bold = true;
			//m_txt.border =false;
			m_txt.color ="0xffffff";
			m_txt.dropShadow = false;
			m_txt.multiline = false;
			m_txt.fontSize="11";
			//m_txt.gridFitType="none";
			//m_txt.leading = 0;	
			
			m_pro =new ILabel();	
			//m_pro.align = TextFormatAlign.RIGHT;
			m_pro.horizontalAlign = TextAlign.RIGHT;
			//m_pro.autoSize = "none";			
			m_pro.bold = true;
			//m_pro.border =false;
			m_pro.color ="0xffffff";
			m_pro.dropShadow = false;
			m_pro.multiline = false;
			m_pro.fontSize="11";
			//m_pro.gridFitType="none";
			//m_pro.leading = 0;			
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			_btnFrame = 1;
			updateUI();
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			_btnFrame = 3;
			updateUI();
		}
		
		protected function onMouseOutHandler(event:MouseEvent):void
		{
			_btnFrame = 1;
			updateUI();
		}
		
		protected function onMouseOverHandler(event:MouseEvent):void
		{
			_btnFrame = 2;
			updateUI();
		}
		
		[Inspectable(defaultValue="-00:00:00")]
		public function get txt():String
		{
			return _txt;
		}

		public function set txt(value:String):void
		{
			_txt = value;
			updateUI();
		}

		[Inspectable(defaultValue=0)]
		public function get progress():Number
		{
			return _progress;
		}
		
		public function set progress(value:Number):void
		{
			_progress = value;
			updateUI();
		}

		override public function createUI():void
		{
			this.addChild(m_back);
			this.addChild(m_front);
			this.addChild(m_btn);
			this.addChild(m_txt);
			this.addChild(m_pro);
			
			m_front.x = 5;
			m_front.y = 17;
			
			m_btn.x = 344;
			m_btn.y = 9;
			m_btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler );
			m_btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler );
			m_btn.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler );
			m_btn.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			m_btn.addEventListener(MouseEvent.CLICK,onClickHandler);
			
			m_txt.x = 233.2;
			m_txt.y = -1.7;
			m_txt.width = 62;
			m_txt.height = 18;
			
			m_pro.x = 290;
			m_pro.y = -1.7;
			m_pro.width = 39.05;
			m_pro.height = 18;
			
			
			updateUI();
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new ControlEvent(ControlEvent.CLOSE));
		}
		
		override public function dispose():void
		{
			m_btn.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler );
			m_btn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler );
			m_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler );
			m_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseUpHandler);
		}
		
		override public function updateUI():void
		{
			m_btn.gotoAndStop( _btnFrame );
			
			m_txt.text=_txt;
			
			var _v:int = _progress * 100;
			m_pro.text = _v.toString() + "%";
			
			var _w:Number = 336 * _progress;
			if ( _w < 7 )
				_w = 7;
			m_front.width = _w;
		}
	}
	
}
