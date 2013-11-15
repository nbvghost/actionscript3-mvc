package com.sanbeetle.component {
	
	import com.sanbeetle.component.child.IListBox;
	import com.sanbeetle.skin.IListBoxBgA;
	
	
	public class IRightMenu extends IListBox {
		
		private var _boxWidth:int = 0;
		public function IRightMenu() {
			super(new IListBoxBgA);
			
			boxWidth = this.listWidth;
		}
		[Inspectable(defaultValue = 120)]
		public function get boxWidth():int
		{
			return _boxWidth;
		}

		public function set boxWidth(value:int):void
		{
			_boxWidth = value;
		}

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
		override protected function createUI():void
		{
			// TODO Auto Generated method stub
			super.createUI();
			filters=this.component.irightMenuFilters;
		}
		
	}
	
}
