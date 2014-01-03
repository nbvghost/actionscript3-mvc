package com.sanbeetle
{
	import com.asvital.dev.Log;
	import com.sanbeetle.core.BoundDisplayObject;
	import com.sanbeetle.data.Version;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.utils.FontNames;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.text.CSMSettings;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.StyleSheet;
	import flash.text.TextColorType;
	import flash.text.TextDisplayMode;
	import flash.text.TextRenderer;
	
	import flashx.textLayout.compose.ISWFContext;
	
	/**
	 *
	 *@author sixf
	 */
	public class Component
	{
		
		private var _TimerRunTime:int = 100;
		private var _Style:StyleSheet=new StyleSheet;
		private var _ilabelFilters:Array;
		private var _ibuttonFilters:Array;
		private var _irightMenuFilters:Array;
		private var _isideBoxFilters:Array;
		
		private var startTextFlow:String='<TextFlow color="#333333" fontFamily="微软雅黑" fontSize="12" fontWeight="normal" paddingLeft="0" paddingTop="0" whiteSpaceCollapse="preserve" version="3.0.0" xmlns="http://ns.adobe.com/textLayout/2008">';
		private var overTextFlow:String="</TextFlow>";
		
		/**
		 * list  菜单 消失时间，毫秒
		 */
		public var LIST_HIDE_TIME:int = 100;
		
		private var _debug:Boolean = true;
		
		
		private var _MaxToolTipWidth:int = 300;
		
		private var _MaxListHeight:int = 100;
		private var _MinListWidth:int = 130;
		/**
		 * 是否自动加载字体  
		 */		
		public static var AutoLoadFont:Boolean = true;
		
		private static var _component:Component;
		
		private var cc:BoundDisplayObject;
		
		private static var fontLoader:Loader;
		
		/**
		 * 0:没加载
		 * 1：正在加载
		 * 3：加载完成，已经有字体了 
		 */
		private static var fontLoadedIndex:int=0;
		
		public static const version:Version=new Version();
		
		
		public static var MicrosoftYaHei:ISWFContext;
		
		public function Component ()
		{
			
			_ilabelFilters = [new DropShadowFilter(1,60,0x000000,0.3,1,1,1,BitmapFilterQuality.LOW,false,false)];
			_ibuttonFilters = [new DropShadowFilter(1,60,0x000000,0.3,1,1,1,BitmapFilterQuality.LOW,false,false)];
			_irightMenuFilters = [new DropShadowFilter(5,90,0x000000,0.3,15,15,1,BitmapFilterQuality.LOW,false,false)];
			_isideBoxFilters = [new DropShadowFilter(5,90,0x000000,0.3,15,15,1,BitmapFilterQuality.LOW,false,false)];
			/*Console.setOutCallBack (function (...ages):void{
			if(ages[0]=="components10"){
			//Console.out("sdfds");
			}
			});*/
			
			fontLoader = new Loader();
			fontLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onFontLoaderCompleteHandler);
			
		}
		
		protected function onFontLoaderCompleteHandler(event:Event):void
		{
			fontLoadedIndex = 3;
			//var FontClass:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYahei") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontClass);
			//Font.registerFont (FontClass);
			//var FontBoldClass:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYaheiBold") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontBoldClass);
			//Font.registerFont (FontBoldClass);
			
			MicrosoftYaHei = fontLoader.content as ISWFContext;
			
			/*var FontClassDF3:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYaheiDF3") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontClass);
			Font.registerFont (FontClassDF3);
			var FontBoldClassDF3:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYaheiBoldDF3") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontBoldClass);
			Font.registerFont (FontBoldClassDF3);*/
			
			TextRenderer.maxLevel = 7;
			TextRenderer.displayMode = TextDisplayMode.DEFAULT;
			
			
			var insideCutoff:Number = 0.4435;
			var outsideCutoff:Number = -0.4685;
			
			var arr:Array = new Array();
			arr.push (new CSMSettings(36, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(34, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(32, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(30, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(28, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(26, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(24, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(22, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(18, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(16, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(14, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(12, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(11, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(10, insideCutoff, outsideCutoff));
			arr.push (new CSMSettings(9, insideCutoff, outsideCutoff));
			
			//TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.REGULAR, TextColorType.DARK_COLOR, arr);
			//TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.ITALIC, TextColorType.DARK_COLOR, arr);
			//TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.BOLD, TextColorType.DARK_COLOR, arr);
			//TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.BOLD_ITALIC, TextColorType.DARK_COLOR, arr);
			
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.REGULAR, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.ITALIC, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.BOLD, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei_Local, FontStyle.BOLD_ITALIC, TextColorType.DARK_COLOR, arr);
			
			
			Log.info("Component 加载字体完成！");
			
			if(contentContainer==null){
				throw new Error("没有设置 组件容器！");
			}
			if(contentContainer.mine){
				if(contentContainer.mine is Stage){
					contentContainer.mine.dispatchEvent(new ControlEvent(ControlEvent.FONT_LOADED));
				}else{
					if(contentContainer.mine.stage!=null){
						contentContainer.mine.dispatchEvent(new ControlEvent(ControlEvent.FONT_LOADED));
					}
				}
			}			
			
		}
		
		
		
		public function getMinListWidth():int
		{
			return _MinListWidth;
		}
		
		public function setMinListWidth(value:int):void
		{
			_MinListWidth = value;
		}
		
		public function getMaxListHeight():int
		{
			return _MaxListHeight;
		}
		
		public function setMaxListHeight(value:int):void
		{
			_MaxListHeight = value;
		}
		
		public function get contentContainer():BoundDisplayObject
		{
			if(cc==null){
				/*var sp:Sprite = new Sprite();
				sp.graphics.beginFill(0xff0000,1);
				sp.graphics.drawRect(0,0,500,400);
				sp.graphics.drawRect(1,1,500-2,400-2);
				sp.graphics.endFill();
				_contentContainer = new BoundDisplayObject(sp);*/
				Log.error("Component.component.contentContainer 不能为 null,请在使用前进行设置，如：Component.component.initContentContainer(stage);");
			}
			return cc;
		}
		public function getMaxToolTipWidth():int
		{
			return _MaxToolTipWidth;
		}
		
		public function setMaxToolTipWidth(value:int):void
		{
			_MaxToolTipWidth = value;
		}
		
		public  function setTextFlow(start:String,over:String):void{
			startTextFlow = start;
			overTextFlow = over;
		}
		public  function getTextFlow(value:String=null):String{
			if(value==null){
				return 	startTextFlow+overTextFlow;
			}
			return 	startTextFlow+value+overTextFlow;
		}
		
		
		public  function get debug ():Boolean
		{
			return _debug;
		}
		
		public function set debug (value:Boolean):void
		{
			_debug = value;
		}
		
		/**
		 *  [new DropShadowFilter(5, 90, 0x000000, 0.3, 15, 15, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get isideBoxFilters ():Array
		{
			return _isideBoxFilters;
		}
		
		public function set isideBoxFilters (value:Array):void
		{
			_isideBoxFilters = value;
		}
		
		/**
		 * [new DropShadowFilter(5, 90, 0x000000, 0.3, 15, 15, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get irightMenuFilters ():Array
		{
			return _irightMenuFilters;
		}
		
		public function set irightMenuFilters (value:Array):void
		{
			_irightMenuFilters = value;
		}
		
		/**
		 * [new DropShadowFilter(1, 60, 0x000000, 0.3, 1, 1, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get ibuttonFilters ():Array
		{
			return _ibuttonFilters;
		}
		
		public function set ibuttonFilters (value:Array):void
		{
			_ibuttonFilters = value;
		}
		
		/**
		 * [new DropShadowFilter(1, 60, 0x000000, 0.3, 1, 1, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get ilabelFilters ():Array
		{
			return _ilabelFilters;
		}
		
		public function set ilabelFilters (value:Array):void
		{
			_ilabelFilters = value;
		}
		
		public function get TimerRunTime ():int
		{
			return _TimerRunTime;
		}
		
		public function set TimerRunTime (value:int):void
		{
			_TimerRunTime = value;
		}
		
		/**
		 *  样式表
		 */
		public function getStyle ():StyleSheet
		{
			return _Style;
		}		
		
		public function initStyle (style:String):void
		{
			//_Style = style;
			_Style.parseCSS(style);
		}
		/**
		 * 组件 容器，不能为空，这个容器，只是为了组件，在显示的时候，不能超出的边缘，比如下拉框，它的显示在最顶层的，为了方便 控制，组件会根据这个容器的进行判断，并自行进行调整， 所以这个容器的的 parent 不能为空，也就是说这个容器必须已经添加到显示列表中。
		 * @param _contentContainer
		 * 
		 */
		public function initContentContainer(_contentContainer:DisplayObjectContainer):void{
			
			
			if(cc==null){
				cc = new BoundDisplayObject(_contentContainer);			
			}else{
				Log.info("已经对 Component.component.contentContainer 设置了。");
			}
			
		}		
		public static function get component():Component
		{
			if (_component==null)
			{				
				_component =new Component();
				
			}else{				
				if(AutoLoadFont){
					if(fontLoadedIndex==0){
						fontLoadedIndex = 1;
						fontLoader.load(new URLRequest("MSYahei.swf"));
					}	
				}							
			}
			return _component;
		}
		
		
	}
	
}
