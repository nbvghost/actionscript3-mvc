package com.game.framework.display {
	import com.game.framework.ifaces.IURL;
	import com.game.framework.logic.AssetsData;
	import com.game.framework.net.AssetItem;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * 加载图片
	 *@author sixf
	 */
	public class Picture extends AssetItem {
		
		protected var target:DisplayObjectContainer;
		protected var rect:Rectangle;
		
		public function Picture(target:DisplayObjectContainer, url:IURL, rect:Rectangle = null) {
			super(url, true);
			this.target = target;
			
			if (this.getDatainterface == null) {
				this.setDatainterface = new AssetsData();
			}
			initView();
			
		}
		
		override public function onCompleteHandler(event:Event):void {
			super.onCompleteHandler(event);
			this.addChild(this.contentLoaderInfo.content);
		}
		
		
	}
}