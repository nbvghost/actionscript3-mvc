package 
{

	import com.asvital.dev.Log;
	import com.sanbeetle.Component;
	import com.sanbeetle.component.IHScrollBar;
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.component.ITabButton;
	import com.sanbeetle.component.ITextInput;
	import com.sanbeetle.component.ITimeSchedule;
	import com.sanbeetle.component.IVScrollBar;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.utils.FontNames;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
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

		/*[Embed(source = "styles/style.css",mimeType = "application/octet-stream")]
		private var Style:Class;*/

		public var time:ITimeSchedule;

		public var sd:ITabButton;

		public var tee:ITextInput;

		public var vsb:IVScrollBar;
		public var hsb:IHScrollBar;
		public var target:MovieClip;
		public var targeta:MovieClip;
		
		public var teete:ILabel;

		private var fontLoader:Loader;
		public function Main ()
		{
			//Log.setLeve (Log.ERROR_LEVE|Log.OUT_LEVE|Log.INFO_LEVE);
			
			//Component.component.initStyle (new Style());	
			
			
			//Component.component.initContentContainer (stage);		


			this.addEventListener (Event.ADDED_TO_STAGE,onStage);
		}
		protected function onStage (event:Event):void
		{
			
			
			fontLoader = new Loader();
			fontLoader.contentLoaderInfo.addEventListener (Event.COMPLETE, onFontCompleteHandler);
			fontLoader.load (new URLRequest("MSYahei.swf"));
		}
		protected function onFontCompleteHandler (event:Event):void
		{
			var FontClass:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYahei") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontClass);
			Font.registerFont (FontClass);
			var FontBoldClass:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYaheiBold") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontBoldClass);
			Font.registerFont (FontBoldClass);

			/*var FontClassDF3:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYaheiDF3") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontClass);
			Font.registerFont (FontClassDF3);
			var FontBoldClassDF3:Class = fontLoader.contentLoaderInfo.applicationDomain.getDefinition("com.sanbeetle.component.MSYaheiBoldDF3") as Class;
			//Console.out("components"+"components"+"FontBoldClass"+FontBoldClass);
			Font.registerFont (FontBoldClassDF3);*/

			TextRenderer.maxLevel = 7;
			TextRenderer.displayMode = TextDisplayMode.DEFAULT;

			var arr:Array = new Array();
			arr.push (new CSMSettings(36, 0.4435, -0.4685));
			arr.push (new CSMSettings(34, 0.4435, -0.4685));
			arr.push (new CSMSettings(32, 0.4435, -0.4685));
			arr.push (new CSMSettings(30, 0.4435, -0.4685));
			arr.push (new CSMSettings(28, 0.4435, -0.4685));
			arr.push (new CSMSettings(26, 0.4435, -0.4685));
			arr.push (new CSMSettings(24, 0.4435, -0.4685));
			arr.push (new CSMSettings(22, 0.4435, -0.4685));
			arr.push (new CSMSettings(18, 0.4435, -0.4685));
			arr.push (new CSMSettings(16, 0.4435, -0.4685));
			arr.push (new CSMSettings(14, 0.4435, -0.4685));
			arr.push (new CSMSettings(12, 0.4435, -0.4685));
			arr.push (new CSMSettings(11, 0.4435, -0.4685));
			arr.push (new CSMSettings(10, 0.4435, -0.8685));
			arr.push (new CSMSettings(9, 0.4435, -0.4685));

			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.REGULAR, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.ITALIC, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.BOLD, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.BOLD_ITALIC, TextColorType.DARK_COLOR, arr);

			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.REGULAR, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.ITALIC, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.BOLD, TextColorType.DARK_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.BOLD_ITALIC, TextColorType.DARK_COLOR, arr);



			stage.dispatchEvent (new ControlEvent(ControlEvent.FONT_LOADED));
			
			
			
			
			testCode();
			


			/*var txt:TextField = new TextField();
			txt.text="呈困国人细岁dsfdsfsd";
			txt.antiAliasType=AntiAliasType.ADVANCED;
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


			//Console.out("components"+new Date(1986,12).toDateString());
		}
		
		private function testCode():void
		{
			
			/*var cobobox:ComboBox = new ComboBox();
			cobobox.width = 300;
			var data:DataProvider = new DataProvider();
			data.addItem(new SimpleCollectionItem("ssdsd","dsfs"));
			data.addItem(new SimpleCollectionItem("ssdsd","dsfs"));
			data.addItem(new SimpleCollectionItem("ssdsd","dsfs"));
			data.addItem(new SimpleCollectionItem("ssdsd","dsfs"));
			data.addItem(new SimpleCollectionItem("ssdsd","dsfs"));
			data.addItem(new SimpleCollectionItem("ssdsd","dsfs"));
			
			cobobox.itemCellRenaderer = DsCellItem;
			
			cobobox.dataProvider = data;
			this.addChild(cobobox);*/
			
		}
	}

}