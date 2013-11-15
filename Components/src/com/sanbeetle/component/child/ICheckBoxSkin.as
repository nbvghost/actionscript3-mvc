package  com.sanbeetle.component.child {
	
	import com.sanbeetle.skin.ICheckBoxSkinBg;
	import com.sanbeetle.skin.ICheckBoxSkinIco;
	
	import flash.display.MovieClip;
	
	
	public class ICheckBoxSkin extends MovieClip {
		
		public var bg:ICheckBoxSkinBg;
		public var icon:ICheckBoxSkinIco;
		public function ICheckBoxSkin() {
			bg = new ICheckBoxSkinBg;
			icon = new ICheckBoxSkinIco;
			this.addChild(bg);
			this.addChild(icon);
			
			icon.x = bg.width/2;
			icon.y = bg.height/2;
		}
	}
	
}
