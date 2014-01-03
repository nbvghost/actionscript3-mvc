package com.sanbeetle.component {
	
	import com.sanbeetle.renderer.BlackColorListCellRenderer;
	import com.sanbeetle.skin.IListBoxBg;
	
	
	public class IRightMenu extends ListChild {
		
		private var _ItemCellRender:Class;		
		private var bg:IListBoxBg;		
		
				
		public function IRightMenu() {
			
			//bg = new IListBoxBg;
			
			//this.autoSize =true;
			
			setMinWidth(100);
			
			//this.addChild(bg);
			
			//list = new IListBox();
			
			//this.addChild(list);
			
			
			//super(new IListBoxBgA);
			_ItemCellRender = BlackColorListCellRenderer;
			//this.autoSize =true;
			//list.autoSize =true;
			
			//boxWidth = this.listWidth;			
			
		}
		/*override public function get autoSize():Boolean
		{
			// TODO Auto Generated method stub
			return true;
		}
		*/	
		
		/*[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}

		public function set dataProvider(value:DataProvider):void
		{
			_dataProvider = value;
			list.dataProvider = _dataProvider;
		}
*/
		
		/**
		 distance 阴影的偏移距离，以像素为单位。
		 angle 阴影的角度，0 到 360 度（浮点）。
		 color 阴影颜色，采用十六进制格式 0xRRGGBB。默认值为 0x000000。
		 alpha 阴影颜色的 Alpha 透明度值。有效值为 0.0 到 1.0。例如，0.25 设置透明度值为 25%。
		 blurX 水平模糊量。有效值为 0 到 255.0（浮点）。
		 blurY 垂直模糊量。有效值为 0 到 255.0（浮点）。
		 strength 印记或跨页的强度。该值越高，压印的颜色越深，而且阴影与背景之间的对比度也越强。有效值为 0 到 255.0。
		 quality 应用滤镜的次数。使用 BitmapFilterQuality 常量： 
		 BitmapFilterQuality.LOW
		 BitmapFilterQuality.MEDIUM
		 BitmapFilterQuality.HIGH
		 有关这些值的详细信息，请参阅 quality 属性说明。
		 
		 inner 表示阴影是否为内侧阴影。值 true 指定内侧阴影。值 false 指定外侧阴影（对象外缘周围的阴影）。
		 knockout 应用挖空效果 (true)，这将有效地使对象的填色变为透明，并显示文档的背景颜色。
		 hideObject 表示是否隐藏对象。如果值为 true，则表示没有绘制对象本身，只有阴影是可见的。
		 
		 * 
		 */		
		override public function createUI():void
		{
			
			
			super.createUI();
			
			
		}
		
		override public function updateUI():void
		{
			
			super.updateUI();
			
			/*this.content.x =1;
			this.content.y = 9;			
			this.setChildIndex(bg,0);			
			
			bg.bg.width = content.width+2;
			bg.bg.height = content.height+18;
			
			this.drawBorder(bg.bg.width,bg.bg.height);*/
		}
		
		
	}
	
}
