package 
{
	
	import com.sanbeetle.Component;
	import com.sanbeetle.component.IButton;
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.component.ITabButton;
	import com.sanbeetle.component.ITimeSchedule;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.ListChildItem;
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
		
		[Embed(source = "styles/style.css",mimeType = "application/octet-stream")]
		private var Style:Class;	
		
		public var time:ITimeSchedule;
		
		public var sd:ITabButton;
		
		
		
		
		private var fontLoader:Loader;
		public function Main ()
		{			
			Component.component.initStyle(new Style());
			
			//sdfs.text="dsfds";
			
			//Console.out("components"+fds.width,fds.height);
			
			return;
			
			var ibu:IButton = new IButton();
			ibu.width = 20;
			this.addChild(ibu);
			
			
			var ite:ILabel =new ILabel;
			ite.width = 200;
			this.addChild(ite);
			ite.x=100;
			ite.y = 300;
			
			//Console.out("components"+ite.width,ite.height);
			/*var txt:TextField = new TextField();
			txt.text="dsfds df dsfds fds fds fdsfds fds";
			//txt.width = 500;
			//txt.height = 20;
			txt.autoSize = TextFieldAutoSize.RIGHT;
			txt.wordWrap =true;
			txt.border =true;
			this.addChild(txt);*/
			return;
			
			
			
			/*time.onlyText = false;
			var date:Date = new Date();	
			//tei.setTotalDate (date.setHours (1,0,10,0)-date.setHours (0,0,0,0));
			//目标时间，要完成倒计时的总时间。 如：一个小时时间长度。date 通过 Date.setHours(); 来设置;
			//tei.begin (date.setHours (0,0,10,0)-date.setHours (0,0,0,0));
			time.setTotalDate (241819);
			//目标时间，要完成倒计时的总时间。 如：一个小时时间长度。date 通过 Date.setHours(); 来设置;
			time.begin (241819);
			time.start();*/
		
			
			
			/*for(var i:int=0;i<200;i++){
				var tei:ITimeSchedule = new ITimeSchedule();
				tei.onlyText = true;
				var date:Date = new Date();	
				//tei.setTotalDate (date.setHours (1,0,10,0)-date.setHours (0,0,0,0));
				//目标时间，要完成倒计时的总时间。 如：一个小时时间长度。date 通过 Date.setHours(); 来设置;
				//tei.begin (date.setHours (0,0,10,0)-date.setHours (0,0,0,0));
				tei.setTotalDate (241819);
				//目标时间，要完成倒计时的总时间。 如：一个小时时间长度。date 通过 Date.setHours(); 来设置;
				tei.begin (241819);
				tei.start();
				//tei.x = Math.random()*stage.stageWidth;
				tei.y = 10*i;
				//开始倒计时的时间。;				
				//date = new Date();
				//date.setHours(0,1,0,0);
				//to(date);
				this.addChild (tei);
			}*/
			
				
			
			var arr:Array = new Array();
			var data:DataProvider = new DataProvider();
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			data.addItem(new ListChildItem("dfs","dsfds"));
			
			var chindchild:ListChildItem= new ListChildItem("dsfs","dsfds");
			chindchild.childs = new DataProvider;
			chindchild.childs.addItem(new ListChildItem("sdfds","sdfds"));
			chindchild.childs.addItem(new ListChildItem("sdfds","sdfds"));
			chindchild.childs.addItem(new ListChildItem("sdfds","sdfds"));
			chindchild.childs.addItem(new ListChildItem("sdfds","sdfds"));
			chindchild.childs.addItem(new ListChildItem("sdfds","sdfds"));
			chindchild.childs.addItem(new ListChildItem("sdfds","sdfds"));
			
			data.addItem(chindchild);
			
			arr.push(data);
			//弹出二级菜单，是根据 ITabButton.data 的索引号来取的。如，selectIndex =1时。二级菜单数据就是childData[1]
			//var tab:ITabButton =new ITabButton();
			//tab.width = 500;
			//tab.selectIndex =1;
			//sd.childData = arr;
			//this.addChild(tab);
			
			
			//var kss:IListBox = new IListBox(new IListBoxBgA);
			//this.addChild(kss);
			
			/*
			var im:StateButton = new StateButton(new TabButton_left_up_gray,new TabButton_left_over_gray,new TabButton_left_down_gray);
			im.select =true;
			im.enable =false;
			this.addChild(im);
			im.width = 200;
			im.height = 200;*/
			
			
			
			/*var te:IStar = this.getChildByName("star") as IStar;
			te.total = 5;
			te.current = 3;
			te.isShowCurrent = true;*/
			
			
			
			
			
			/*var arr:Array = [];
			
			
			arr.push(IStatus.SALE);
			arr.push(IStatus.WORK);
			arr.push(IStatus.RED_CARD);
			arr.push(IStatus.YELLOW_CARD);
			arr.push(IStatus.BRUISE);
			arr.push(IStatus.LEASE);
			var it:IStatus =new IStatus();
			it.iconLabels = null;
			this.addChild(it);
			return;*/
			
			
			/*var time:Number = getTimer();
			for (var i:int=0; i<200; i++)
			{
			var li:ILabel = new ILabel();
			li.text = "lable" + i;
			this.addChild(li);
			li.y = li.textHeight * i;
			}
			Console.out("components"+getTimer()-time);
			
			return;*/
			
			
			
			
			
			/*StyleManager.initStyle (new Style());
			
			
			
			var data:DataProvider = new DataProvider();
			data.addItem (new SimpleCollectionItem("dsf","dsf"));
			data.addItem (new AttributeSimpleItem("dfsd","dsf","0xff00ff",false));
			
			var rightMenu:IRightMenu = new IRightMenu();
			rightMenu.dataProvider = data;
			this.addChild (rightMenu);
			
			
			
			
			
			/*
			
			
			
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
			
			
			var arr:IArrow = new IArrow();
			arr.iconIndex = 9;
			this.addChild(arr);*/
			
			
			
			
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
			
			TextRenderer.maxLevel = 3;
			TextRenderer.displayMode = TextDisplayMode.DEFAULT;
			
			var arr:Array = new Array();
			arr.push (new CSMSettings(36, 0.3, -0.4));
			arr.push (new CSMSettings(34, 0.3, -0.4));
			arr.push (new CSMSettings(32, 0.3, -0.4));
			arr.push (new CSMSettings(30, 0.3, -0.4));
			arr.push (new CSMSettings(28, 0.3, -0.4));
			arr.push (new CSMSettings(26, 0.3, -0.4));
			arr.push (new CSMSettings(24, 0.3, -0.4));
			arr.push (new CSMSettings(22, 0.3, -0.4));
			arr.push (new CSMSettings(18, 0.3, -0.4));
			arr.push (new CSMSettings(16, 0.3, -0.4));
			arr.push (new CSMSettings(14, 0.3, -0.4));
			arr.push (new CSMSettings(12, 0.3, -0.4));
			arr.push (new CSMSettings(11, 0.3, -0.4));
			arr.push (new CSMSettings(10, 0.3, -0.4));
			arr.push (new CSMSettings(9, 0.3, -0.4));
			
			
			//Console.out("components"+Font.enumerateFonts()[0]);
			//Console.out("components"+Font(Font.enumerateFonts()[0]).fontType);
			
			
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.REGULAR, TextColorType.LIGHT_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.ITALIC, TextColorType.LIGHT_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.BOLD, TextColorType.LIGHT_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHeiBold, FontStyle.BOLD_ITALIC, TextColorType.LIGHT_COLOR, arr);
			
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.REGULAR, TextColorType.LIGHT_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.ITALIC, TextColorType.LIGHT_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.BOLD, TextColorType.LIGHT_COLOR, arr);
			TextRenderer.setAdvancedAntiAliasingTable (FontNames.MS_YaHei, FontStyle.BOLD_ITALIC, TextColorType.LIGHT_COLOR, arr);
			
			
			stage.dispatchEvent (new ControlEvent(ControlEvent.FONT_LOADED));
			
			
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
			
			
			//Console.out("components"+new Date(1986,12).toDateString());
		}
	}
	
}