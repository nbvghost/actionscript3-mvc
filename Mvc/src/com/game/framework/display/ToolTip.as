package com.game.framework.display {
	import com.asvital.dev.Log;
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.InlineGraphicElementStatus;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.events.StatusChangeEvent;
	
	/**
	 *
	 *@author sixf
	 */
	public class ToolTip {
		public function ToolTip() {
			
		}
		
		/**
		 *
		 *  <html>
		 <title>333</title>
		 <width>400</width>
		 <height>300</height>
		 <body>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsds">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsf">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsd">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsfd">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsfd">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="sdfd">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsdd">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsfd">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsfd">dsfdsfds</a></span>
		 <span><img src="http://s1.bdstatic.com/r/www/cache/static/global/img/icons_2f167d8f.png"/><a href="dsfdsd">dsfdsfds</a></span>
		 </body>
		 </html>
		 *
		 *
		 * @param html
		 * @param displayTarget
		 *
		 */
		public static function createFromHtml(xml:XML, displayTarget:Sprite):ToolTipSprite {
			
			
			
			
			var _textFlow:TextFlow = TextConverter.importToFlow(xml, TextConverter.TEXT_LAYOUT_FORMAT);
			var cc:ContainerController = new ContainerController(displayTarget, 50, 50);
			_textFlow.flowComposer.addController(cc);
			_textFlow.flowComposer.updateAllControllers();
			_textFlow.addEventListener(FlowElementMouseEvent.MOUSE_DOWN, onFlowElementDownHandler);
			
			
			//Log.out(_textFlow.getElementsByTypeName("a"));
			
			_textFlow.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE, graphicStatusChangeEvent);
			function graphicStatusChangeEvent(e:StatusChangeEvent):void {
				// if the graphic has loaded update the display
				// actualWidth and actualHeight are computed from the graphic's height
				if (e.status == InlineGraphicElementStatus.READY || e.status == InlineGraphicElementStatus.SIZE_PENDING) {
					_textFlow.flowComposer.updateAllControllers();
				}
			}
			
			function onFlowElementDownHandler(event:FlowElementMouseEvent):void {
				//Log.out(event.flowElement);
				var le:LinkElement = event.flowElement as LinkElement;
				if (le) {
					Log.out(le);
				}
			}
			
			return null;
		}
		
		
	}
}