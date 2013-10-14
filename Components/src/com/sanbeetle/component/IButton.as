package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IButtonSkin_down_default;
	import com.sanbeetle.skin.IButtonSkin_down_gary;
	import com.sanbeetle.skin.IButtonSkin_icon;
	import com.sanbeetle.skin.IButtonSkin_over_default;
	import com.sanbeetle.skin.IButtonSkin_over_gary;
	import com.sanbeetle.skin.IButtonSkin_up_default;
	import com.sanbeetle.skin.IButtonSkin_up_gary;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	/**
	 * 按钮
	 *@author sixf
	 */
	public class IButton extends UIComponent {
		
		private var button:SimpleButton;
		private var _label:String="Label";
		//private var labelText:TextField;
		protected var btnlabel:ILabel;
		private var _color:String="0xffffff";
		
		protected var buttonSkin_up:DisplayObject;				
		protected var buttonSkin_over:DisplayObject;		
		protected var buttonSkin_down:DisplayObject;
		
		private var _showICO:Boolean=false;
		private var _bold:Boolean=false;
		private var _icoIndex:int=1;
		
		private var ico:MovieClip;
		
		private var _backgroundColor:String="0x000000";
		private var _fontSize:String="10";
		
		private var _styleType:String="default";
		
		private var textMask:Shape = new Shape();
		
		/**
		 * 
		 * @param upw 弹起状态
		 * @param overw 鼠标经过状态
		 * @param downw 鼠标按下状态
		 * 
		 */
		public function IButton(upw:DisplayObject=null,overw:DisplayObject=null,downw:DisplayObject=null) {	
			
			btnlabel = new ILabel();	
			
			btnlabel.mouseEnabled = false;
			btnlabel.mouseChildren = false;
			if(upw!=null && overw!=null && downw!=null){
				buttonSkin_up = upw;
				buttonSkin_over = overw;
				buttonSkin_down = downw;
				
			}else{
				buttonSkin_up=new IButtonSkin_up_default;
				buttonSkin_over =new IButtonSkin_over_default;	
				buttonSkin_down =new IButtonSkin_down_default;
				ico = new IButtonSkin_icon;
				
			}
			button = new SimpleButton(buttonSkin_up,buttonSkin_over,buttonSkin_down,buttonSkin_down);			
			
		}		
		
		[Inspectable(enumeration = "default,gray",defaultValue = "default")]
		public function get styleType():String
		{
			return _styleType;
		}
		
		public function set styleType(value:String):void
		{
			_styleType = value;
			switch(_styleType){
				default:
				case "default":
					buttonSkin_up=new IButtonSkin_up_default;
					buttonSkin_over =new IButtonSkin_over_default;	
					buttonSkin_down =new IButtonSkin_down_default;
					break;
				case "gray":
					buttonSkin_up=new IButtonSkin_up_gary;
					buttonSkin_over =new IButtonSkin_over_gary;	
					buttonSkin_down =new IButtonSkin_down_gary;
					break;					
			}
			
			this.updateUI();
		}
		
		[Inspectable(defaultValue = "10")]
		public function get fontSize():String
		{
			
			return _fontSize;
		}
		public function set fontSize(value:String):void
		{
			_fontSize = value;
			
			updateUI();
			
		}
		override protected function createUI():void
		{	
			
			
			//btnlabel.border =true;
			
			this.addChild(button);	
			
			this.addChild(btnlabel);
			
			
			
			if(ico!=null){
				ico.stop();
				ico.visible =this.showICO;
				ico.mouseChildren =false;
				ico.mouseEnabled = false;
				this.addChild(ico);					
				
			}	
			
			textMask.cacheAsBitmap =true;
			
			btnlabel.cacheAsBitmap =true;			
			
			this.addChild(textMask);			
			
			
			textMask.mask = btnlabel;
			//textMask.alpha = 0.5;
			textMask.filters=[new DropShadowFilter(1, 60, 0x000000, 0.3, 1, 1, 1,BitmapFilterQuality.LOW, false, false)];
			
			this.updateUI();
			
		}
		
		override protected function updateUI():void
		{
			
			
			btnlabel.width =this.trueWidth;
			btnlabel.height =this.trueHeight;
			
			btnlabel.fontSize = _fontSize;
			btnlabel.autoSize = TextFieldAutoSize.LEFT;
			btnlabel.align = TextFormatAlign.CENTER;
			
			btnlabel.bold = bold;
			btnlabel.text = this.label;
			
			buttonSkin_up.width = trueWidth;
			buttonSkin_over.width = trueWidth;			
			buttonSkin_down.width = trueWidth;			
			
			buttonSkin_up.height =trueHeight;
			buttonSkin_over.height=trueHeight;
			buttonSkin_down.height=trueHeight;			
			
			//btnlabel.border =true;
			//btnlabel.width = this.trueWidth;
			buttonSkin_up.x =0;
			buttonSkin_up.y =0;
			
			buttonSkin_over.x =buttonSkin_up.x;
			buttonSkin_over.y = buttonSkin_up.y;
			buttonSkin_down.x = buttonSkin_up.x;
			buttonSkin_down.y = buttonSkin_up.y;	
			
			button.upState = buttonSkin_up;
			button.overState = buttonSkin_over;
			button.downState = buttonSkin_down;
			
			btnlabel.y =((trueHeight-btnlabel.textHeight)/2);	
			
			
			if(ico){
				
				if(showICO){	
					if(btnlabel.text==""){
						
						ico.x=((this.trueWidth)/2);
						ico.y = (this.trueHeight)/2;
						return;
						
					}
					btnlabel.align = TextFormatAlign.LEFT;
					//btnlabel.autoSize = TextFieldAutoSize.LEFT;
					//btnlabel.border = true;
					ico.visible =true;
					
					var conw:Number = ico.width+10+btnlabel.textWidth;
					
					ico.x=((this.trueWidth-conw)/2)+(ico.width/2)+5;
					ico.y = (this.trueHeight)/2;
					
					btnlabel.x = ico.x+10;
					
					if(icoIndex<0){
						icoIndex=0;
					}
					if(icoIndex<=ico.totalFrames){
						ico.gotoAndStop(icoIndex);
					}
					//trace("icoIndexa:"+icoIndex);
				}else{
					if(ico!=null){
						ico.visible =false;
					}				
					btnlabel.x=(this.trueWidth-btnlabel.textWidth)/2;
				}				
				
			}else{
				btnlabel.x=(this.trueWidth-btnlabel.textWidth)/2;
			}
			this.reDrawMask();
		}
		
		[Inspectable(defaultValue ="false")]	
		/**
		 * 是否显示按钮图标 
		 */
		public function get showICO():Boolean
		{
			return _showICO;
		}
		[Inspectable(defaultValue =false)]
		public function get bold():Boolean
		{
			return _bold;
		}		
		public function set bold(value:Boolean):void
		{
			_bold =value;
			this.updateUI();
			
			//trace("_boldA:"+_bold);
		}	
		
		public function set showICO(value:Boolean):void
		{
			_showICO = value;
			
			this.updateUI();			
		}	
		[Inspectable(defaultValue ="0x000000")]	
		/**
		 * 实例被叠加的颜色 
		 */
		public function get backgroundColor():String
		{
			return _backgroundColor;
		}
		
		public function set backgroundColor(value:String):void
		{
			_backgroundColor = value;		
			
			this.updateUI();			
		}
		
		
		/**
		 * ico 已被编译到 IButton 中，ico 是由多帧构成，通过 icoIndex 来切换不同的图标。 
		 */
		[Inspectable(defaultValue = 1)]	
		public function get icoIndex():int
		{
			return _icoIndex;
		}
		
		public function set icoIndex(value:int):void
		{
			_icoIndex = value;
			
			this.updateUI();		
			
		}
		
		[Inspectable(defaultValue = "0xffffff")]		
		/**
		 * 字体颜色 
		 */
		public function get color():String
		{
			return _color;
		}
		
		public function set color(value:String):void
		{			
			_color = value;
			this.updateUI();
		}
		
		[Inspectable(defaultValue = "Label")]		
		/**
		 * 显示的文本 
		 */
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			_label = value;			
			this.updateUI();
			
		}
		private var sf:Number =(0xffffff-0xd0cccc);
		private function reDrawMask():void{
			
			var matixg:Matrix =new Matrix()//矩阵  
			matixg.createGradientBox(trueHeight,trueWidth,0,0,0);
			//matixg.translate(-(trueWidth/2),-(trueHeight/2));
			matixg.rotate(Math.PI/2);
			
			//trace(sf);
			var beCo:uint = uint(color);
			var enCo:uint = beCo-sf;	
			
			//trace(uint(color).toString(16),beCo.toString(16),enCo.toString(16));
			
			textMask.graphics.clear();
			//textMask.graphics.lineStyle(1,0xff0000);
			textMask.graphics.beginGradientFill(GradientType.LINEAR,[beCo,enCo],[1,1],[0x00,0xff],matixg);
			textMask.graphics.drawRect(0,0,trueWidth,trueHeight);
			textMask.graphics.endFill();	
			
			//textMask.graphics.clear();
			//textMask.graphics.beginFill(0xff0000);
			
			//textMask.graphics.drawRect(0,0,trueWidth,trueHeight);
			//textMask.graphics.endFill();	
			
			
			textMask.height =int(btnlabel.fontSize)+1;
			
			textMask.y =(trueHeight-textMask.height)/2;
			textMask.x = 0;
			
			
		}
		override public function setSize(w:Number,h:Number):void{
			//trace("--------:"+w,h);
			trueWidth = w;
			trueHeight =h;			
			
			this.updateUI();		
		}
		
	}
	
}
