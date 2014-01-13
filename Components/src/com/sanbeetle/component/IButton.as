package com.sanbeetle.component {
	
	import com.sanbeetle.core.StateButton;
	import com.sanbeetle.core.TextBox;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.IButtonSkin_down_blue;
	import com.sanbeetle.skin.IButtonSkin_down_default;
	import com.sanbeetle.skin.IButtonSkin_down_gary;
	import com.sanbeetle.skin.IButtonSkin_down_green;
	import com.sanbeetle.skin.IButtonSkin_down_red;
	import com.sanbeetle.skin.IButtonSkin_down_sea_blue;
	import com.sanbeetle.skin.IButtonSkin_down_yellow;
	import com.sanbeetle.skin.IButtonSkin_icon;
	import com.sanbeetle.skin.IButtonSkin_over_blue;
	import com.sanbeetle.skin.IButtonSkin_over_default;
	import com.sanbeetle.skin.IButtonSkin_over_gary;
	import com.sanbeetle.skin.IButtonSkin_over_green;
	import com.sanbeetle.skin.IButtonSkin_over_red;
	import com.sanbeetle.skin.IButtonSkin_over_sea_blue;
	import com.sanbeetle.skin.IButtonSkin_over_yellow;
	import com.sanbeetle.skin.IButtonSkin_up_blue;
	import com.sanbeetle.skin.IButtonSkin_up_default;
	import com.sanbeetle.skin.IButtonSkin_up_gary;
	import com.sanbeetle.skin.IButtonSkin_up_green;
	import com.sanbeetle.skin.IButtonSkin_up_red;
	import com.sanbeetle.skin.IButtonSkin_up_sea_blue;
	import com.sanbeetle.skin.IButtonSkin_up_yellow;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.formats.TextAlign;
	
	/**
	 * 按钮
	 *@author sixf
	 */
	public class IButton extends UIComponent {
		
		protected var button:StateButton;
		private var _label:String="Label";
		//private var labelText:TextField;
		protected var btnlabel:TextBox;
		private var _color:String="0xffffff";
		
		protected var buttonSkin_up:DisplayObject;				
		protected var buttonSkin_over:DisplayObject;		
		protected var buttonSkin_down:DisplayObject;
		
		private var _showICO:Boolean=false;
		private var _bold:Boolean=false;
		private var _icoIndex:int=1;
		
		private var ico:MovieClip;
		
		public static const STYLE_DEFAULT:String="default";
		public static const STYLE_GRAY:String="gray";
		public static const STYLE_GREEN:String="green";
		public static const STYLE_BLUE:String="blue";
		public static const STYLE_RED:String="red";
		public static const STYLE_SEA_BLUE:String="sea_blue";
		public static const STYLE_YELLOW:String="yellow";
		
		
		protected var sf:Number =(0xffffff-0xd0cccc);
		private var _select:Boolean = false;
		
		private var _backgroundColor:String="0x000000";
		private var _fontSize:String="10";
		
		private var _styleType:String="default";
		private var _align:String=TextFormatAlign.CENTER;
		private var _autoSize:String= TextFieldAutoSize.LEFT;
	
		protected var textMask:Shape = new Shape();
		
		/**
		 * 
		 * @param upw 弹起状态
		 * @param overw 鼠标经过状态
		 * @param downw 鼠标按下状态
		 * 
		 */
		public function IButton(upw:DisplayObject=null,overw:DisplayObject=null,downw:DisplayObject=null) {	
			
			btnlabel = new TextBox();	
			btnlabel.addEventListener(ControlEvent.FONT_LOADED,onFontLoadedHandler);
			btnlabel.multiline =false;
			//btnlabel.leading = 0;
			btnlabel.mouseEnabled = false;
			btnlabel.mouseChildren = false;
			btnlabel.autoBound = true;
			btnlabel.textAlign = TextAlign.CENTER;
			
			//btnlabel.paddingTop = 0;
			//btnlabel.paddingLeft = 0;
			
			//btnlabel.textAlign = TextAlign.CENTER;
			
			//btnlabel.autoSize = TextFieldAutoSize.LEFT;
			//btnlabel.border =true;
			if(upw!=null && overw!=null && downw!=null){
				buttonSkin_up = upw;
				buttonSkin_over = overw;
				buttonSkin_down = downw;
				ico = new IButtonSkin_icon;
				
			}else{
				buttonSkin_up=new IButtonSkin_up_default;
				buttonSkin_over =new IButtonSkin_over_default;	
				buttonSkin_down =new IButtonSkin_down_default;
				ico = new IButtonSkin_icon;
				
			}
			button = new StateButton(buttonSkin_up,buttonSkin_over,buttonSkin_down,buttonSkin_down);
			this.buttonMode =true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseHandler);			
		
		}		
		private var _enabled:Boolean = false;
		override public function get enabled():Boolean
		{
			
			return _enabled;
		}
		
		override public function set enabled(value:Boolean):void
		{
			
			_enabled = value;
			button.enable = _enabled;
			this.mouseEnabled = _enabled;
			
		}
		
		
		protected function onFontLoadedHandler(event:ControlEvent):void
		{
			this.updateUI();
		}
		
		private function onMouseHandler(event:MouseEvent):void
		{
			if(stage==null){
				return;
			}
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					textMask.y = textMask.y+1;
					btnlabel.y = btnlabel.y+1;
					ico.y=ico.y+1;
					stage.addEventListener(MouseEvent.MOUSE_UP,onMouseHandler);
					break;				
				case MouseEvent.MOUSE_UP:
					textMask.y = textMask.y-1;
					btnlabel.y = btnlabel.y-1;
					ico.y = ico.y-1;
					stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseHandler);
					break;
			}
			
		}
		
		public function get select():Boolean
		{
			return _select;
		}

		public function set select(value:Boolean):void
		{
			_select = value;			
			this.button.select = _select;
		}

		public function get autoSize():String
		{
			return _autoSize;
		}

		public function set autoSize(value:String):void
		{
			_autoSize = value;
			
			updateUI();
		}

		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			_align = value;
			
			updateUI();
		}
		/**
		 * IButton 的静态属性 
		 * @return 
		 * 
		 */	
		[Inspectable(enumeration = "default,gray,green,blue,red,sea_blue,yellow",defaultValue = "default")]
		public function get styleType():String
		{
			return _styleType;
		}
		
		public function set styleType(value:String):void
		{
			_styleType = value;
			switch(_styleType){
				default:
				case STYLE_DEFAULT:
					buttonSkin_up=new IButtonSkin_up_default;
					buttonSkin_over =new IButtonSkin_over_default;	
					buttonSkin_down =new IButtonSkin_down_default;
					break;
				case STYLE_GRAY:
					buttonSkin_up=new IButtonSkin_up_gary;
					buttonSkin_over =new IButtonSkin_over_gary;	
					buttonSkin_down =new IButtonSkin_down_gary;
					break;		
				case STYLE_GREEN:
					buttonSkin_up=new IButtonSkin_up_green;
					buttonSkin_over =new IButtonSkin_over_green;	
					buttonSkin_down =new IButtonSkin_down_green;
					break;
				case STYLE_BLUE:
					buttonSkin_up=new IButtonSkin_up_blue;
					buttonSkin_over =new IButtonSkin_over_blue;	
					buttonSkin_down =new IButtonSkin_down_blue;
					break;		
				case STYLE_RED:
					buttonSkin_up=new IButtonSkin_up_red;
					buttonSkin_over =new IButtonSkin_over_red;	
					buttonSkin_down =new IButtonSkin_down_red;
					break;		
				case STYLE_SEA_BLUE:
					buttonSkin_up=new IButtonSkin_up_sea_blue;
					buttonSkin_over =new IButtonSkin_over_sea_blue;	
					buttonSkin_down =new IButtonSkin_down_sea_blue;
					break;		
				case STYLE_YELLOW:
					buttonSkin_up=new IButtonSkin_up_yellow;
					buttonSkin_over =new IButtonSkin_over_yellow;	
					buttonSkin_down =new IButtonSkin_down_yellow;
					break;		
			}
			button.upState = buttonSkin_up;
			button.overState = buttonSkin_over;
			button.downState = buttonSkin_down;
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
		override public function createUI():void
		{	
			
			
			//btnlabel.border =true;
			
			this.addChild(button);	
			
			this.addChild(btnlabel);
			
			this.addChild(textMask);
			
			
			
			if(ico!=null){
				ico.stop();
				ico.visible =this.showICO;
				ico.mouseChildren =false;
				ico.mouseEnabled = false;
				this.addChild(ico);					
				
			}	
			
			textMask.cacheAsBitmap =true;
			
			btnlabel.cacheAsBitmap =true;		
		
			
			
			maskTarget();
			
			this.updateUI();
			
			
		}
		protected function maskTarget():void{
			textMask.mask = btnlabel;
			textMask.filters=component.ibuttonFilters;
			//textMask.alpha = 0.5;				
		}
		
		override public function updateUI():void
		{	
			
			//btnlabel.width = trueWidth;
			
			btnlabel.fontSize = fontSize;
			//btnlabel.autoSize = autoSize;
			//btnlabel.align =align;
			btnlabel.color = this.color;
			btnlabel.bold = bold;
			btnlabel.text = this.label;				
			
			button.width = trueWidth;
			button.height = trueHeight;
			
			
			
			btnlabel.y =((trueHeight-btnlabel.height)/2);
			
			if(ico){
				
				if(showICO){	
					if(icoIndex<0){
						icoIndex=0;
					}
					
					if(icoIndex<=ico.totalFrames){
						ico.gotoAndStop(icoIndex);
					}
					ico.visible =true;
					if(btnlabel.text==""){
						
						ico.x=((this.trueWidth)/2);
						ico.y = (this.trueHeight)/2;
						return;
						
					}
					//btnlabel.align = align;			
					
					var conw:Number = ico.width+10+btnlabel.width;
					
					ico.x=((this.trueWidth-conw)/2)+(ico.width/2)+5;
					ico.y = (this.trueHeight)/2;
					
					btnlabel.x = ico.x+10;
				}else{
					
					ico.visible =false;
								
					btnlabel.x=(this.trueWidth-btnlabel.width)/2;
				}				
				
			}else{
				btnlabel.x=(this.trueWidth-btnlabel.width)/2;
			}
			this.reDrawMask();
			
			//btnlabel.x=0;
			
			//Console.out("components"+btnlabel.width);
			drawBorder(this.trueWidth,this.trueHeight);
			
			if(label=="" || label==null){
				btnlabel.visible = false;
				textMask.visible = false;
			}else{
				btnlabel.visible = true;
				textMask.visible = true;
			}
		
			//Log.out(btnlabel.width);
		}
		
		[Inspectable(defaultValue =false)]	
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
			
			//Console.out("components"+"components"+"_boldA:"+_bold);
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
		protected function reDrawMask():void{
			textMask.scaleY = 1;
			var matixg:Matrix =new Matrix()//矩阵  
			matixg.createGradientBox(btnlabel.height+1,trueWidth,0,0,0);
			//matixg.translate(-(trueWidth/2),-(trueHeight/2));
			matixg.rotate(Math.PI/2);
			
			
			var beCo:uint = uint(color);
			var enCo:uint = beCo-sf;	
			
			
			textMask.graphics.beginGradientFill(GradientType.LINEAR,[beCo,enCo],[1,1],[0x00,0xff],matixg);
			textMask.graphics.drawRect(0,0,trueWidth,btnlabel.height+1);
			textMask.graphics.endFill();
			
			//textMask.height=9;
			//textMask.y =(trueHeight-textMask.height)/2;
			textMask.y = btnlabel.y-1;
			textMask.x = 0;
			
			/*return;
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
			
			textMask.height =int(btnlabel.fontSize)+1;
			
			textMask.y =(trueHeight-textMask.height)/2;
			textMask.x = 0;*/
			
			
		}			
	}
	
}
