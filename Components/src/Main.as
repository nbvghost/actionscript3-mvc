package 
{

	import com.sanbeetle.component.IHScrollBar;
	import com.sanbeetle.component.ITimeSchedule;
	import com.sanbeetle.component.IVScrollBar;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.utils.FontNames;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.CSMSettings;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.TextColorType;
	import flash.text.TextDisplayMode;
	import flash.text.TextRenderer;


	public class Main extends MovieClip
	{

		private var fontLoader:Loader;
		public function Main()
		{
			var tei:ITimeSchedule = new ITimeSchedule();
			var date:Date = new Date();
			date.setHours(0,0,0,0);
			tei.begin(date);
			
			date = new Date();
			date.setHours(0,1,0,0);
			tei.to(date);
			
			//date = new Date();
			//date.setHours(0,1,0,0);
			//to(date);
			this.addChild(tei);
			
			
		
			var iv:IVScrollBar = new IVScrollBar();
			iv.x = 200;
			this.addChild(iv);
			
			var ivtarget:Sprite = new Sprite();
			ivtarget.graphics.beginFill(0xff0000);
			ivtarget.graphics.drawRect(0,0,100,1000);
			ivtarget.graphics.endFill();
			this.addChild(ivtarget);
			
			iv.source=ivtarget;
			
			
			
			var ih:IHScrollBar = new IHScrollBar();
			ih.x = 200;
			ih.y = 200;
			this.addChild(ih);
			
			var ihtarget:Sprite = new Sprite();
			ihtarget.graphics.beginFill(0xff0000);
			ihtarget.graphics.drawRect(0,0,1000,100);
			ihtarget.graphics.endFill();
			this.addChild(ihtarget);
			
			
			ih.source=ihtarget;
			

			this.addEventListener(Event.ADDED_TO_STAGE,onStage);
		}
		protected function onStage(event:Event):void
		{
			fontLoader = new Loader();
			fontLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFontCompleteHandler);
			fontLoader.load(new URLRequest("MSYahei.swf"));
		}
		protected function onFontCompleteHandler(event:Event):void
		{
			var FontClass:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYahei") as Class;
			//trace("FontBoldClass"+FontClass);
			Font.registerFont(FontClass);
			var FontBoldClass:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYaheiBold") as Class;
			//trace("FontBoldClass"+FontBoldClass);
			Font.registerFont(FontBoldClass);

			TextRenderer.maxLevel = 3;
			TextRenderer.displayMode = TextDisplayMode.DEFAULT;

			var arr:Array = new Array();
			arr.push(new CSMSettings(36, 0.3, -0.4));
			arr.push(new CSMSettings(34, 0.3, -0.4));
			arr.push(new CSMSettings(32, 0.3, -0.4));
			arr.push(new CSMSettings(30, 0.3, -0.4));
			arr.push(new CSMSettings(28, 0.3, -0.4));
			arr.push(new CSMSettings(26, 0.3, -0.4));
			arr.push(new CSMSettings(24, 0.3, -0.4));
			arr.push(new CSMSettings(22, 0.3, -0.4));
			arr.push(new CSMSettings(18, 0.3, -0.4));
			arr.push(new CSMSettings(16, 0.3, -0.4));
			arr.push(new CSMSettings(14, 0.3, -0.4));
			arr.push(new CSMSettings(12, 0.3, -0.4));
			arr.push(new CSMSettings(11, 0.3, -0.4));
			arr.push(new CSMSettings(10, 0.3, -0.4));
			arr.push(new CSMSettings(9, 0.3, -0.4));


			//trace(Font.enumerateFonts()[0]);
			//trace(Font(Font.enumerateFonts()[0]).fontType);

			TextRenderer.setAdvancedAntiAliasingTable(FontNames.MS_YaHeiBold, FontStyle.BOLD, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable(FontNames.MS_YaHei, FontStyle.REGULAR, TextColorType.LIGHT_COLOR, arr);

			stage.dispatchEvent(new ControlEvent(ControlEvent.FONT_LOADED));


			/*var txt:TextField = new TextField();
			txt.text="呈困国人细岁dsfdsfsd";
			//txt.antiAliasType=AntiAliasType.ADVANCED;
			txt.wordWrap =true;
			this.addChild(txt);
			txt.embedFonts =true;
			txt.setTextFormat(new TextFormat("Microsoft YaHei",12,0x000000,true));
			txt.y = 100;
			
			
			var txt:TextField = new TextField();
			txt.text="呈困国人细岁dsfdsfsd";
			txt.wordWrap =true;
			//txt.antiAliasType=AntiAliasType.ADVANCED;
			this.addChild(txt);
			txt.embedFonts =true;
			txt.setTextFormat(new TextFormat("Microsoft YaHei Bold",12,0x000000,true));
			txt.y = 200;
			
			var txt:TextField = new TextField();
			txt.text="呈困国人细岁dsfdsfsd";
			txt.wordWrap =true;
			txt.antiAliasType=AntiAliasType.ADVANCED;
			this.addChild(txt);
			txt.embedFonts =true;
			txt.setTextFormat(new TextFormat("Microsoft YaHei Bold",12,0x000000,true));
			txt.y = 150;*/


			//trace(new Date(1986,12).toDateString());
		}
	}

}