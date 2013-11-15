package com.sanbeetle.component.child {
	
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.component.ITextInput;
	import com.sanbeetle.skin.IPagingSkin_last_mc;
	import com.sanbeetle.skin.IPagingSkin_next_mc;
	import com.sanbeetle.skin.IPagingSkin_per_mc;
	import com.sanbeetle.skin.IPagingSkin_top_mc;
	
	import flash.display.MovieClip;
	import flash.text.TextFormatAlign;
	
	
	public class IPagingSkin extends MovieClip {
		
		public var per_mc:MovieClip;
		public var top_mc:MovieClip;
		public var last_mc:MovieClip;
		public var next_mc:MovieClip;
		public var djy_txt:ILabel;
		public var pageindex_txt:ITextInput;
		
		public function IPagingSkin() {
			
						
			djy_txt = new ILabel();
			djy_txt.bold =true;
			djy_txt.color ="0x373B40";
			djy_txt.fontSize ="10";		
			djy_txt.height = 17;
			djy_txt.width = 90;
			
			djy_txt.border =false;
			djy_txt.align =TextFormatAlign.RIGHT;
			this.addChild(djy_txt);
			
			var txt:ILabel = new ILabel();
			//txt.selectable =true;
			txt.color = djy_txt.color;
			txt.x =  94;
			txt.fontSize = djy_txt.fontSize;
			txt.bold = djy_txt.bold;
			txt.border = djy_txt.border;
			txt.height = djy_txt.height;
			txt.width = 24;
			txt.text="转到";
			txt.align = TextFormatAlign.LEFT;
			this.addChild(txt);
			
			pageindex_txt = new ITextInput();
			pageindex_txt.selectable =true;
			pageindex_txt.color = djy_txt.color;
			//pageindex_txt.x = txt.x+txt.textWidth+10;
			pageindex_txt.fontSize = djy_txt.fontSize;
			pageindex_txt.bold = djy_txt.bold;
			pageindex_txt.border = djy_txt.border;
			pageindex_txt.height = djy_txt.height;
			pageindex_txt.width = 46;
			pageindex_txt.x =123;
			pageindex_txt.align = TextFormatAlign.CENTER;
			pageindex_txt.leading = 0;
			addChild(pageindex_txt);	
			
			
			
			per_mc = new IPagingSkin_per_mc;
			top_mc= new IPagingSkin_top_mc;
			last_mc= new IPagingSkin_last_mc;
			next_mc= new IPagingSkin_next_mc;			
			
			per_mc.stop();
			top_mc.stop();
			last_mc.stop();
			next_mc.stop();	
			
			
			per_mc.y = 9;
			top_mc.y = per_mc.y;
			last_mc.y = per_mc.y;
			next_mc.y = per_mc.y;			
			
			addChild(per_mc);
			addChild(top_mc);
			addChild(last_mc);
			addChild(next_mc);
			
			top_mc.x = 180;
			per_mc.x =204;
			next_mc.x = 229;
			last_mc.x =251;			
			
			//cunt.x =pageindex_txt.x+pageindex_txt.textWidth+20;
			//cunt.y = 8;
			
		}
	}
	
}
