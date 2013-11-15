package com.game.framework.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.text.TextSnapshot;
	
	
	
	/**
	 *
	 *@author sixf
	 */
	public class LayerContainer extends BaseLayer
	{
		private var _topLayer:Layer;
		private var _midLayer:Layer;
		private var _buttomLayer:Layer;
		
		
		public function LayerContainer(parentContainer:DisplayObjectContainer)
		{
			super(parentContainer);
			
			buttomLayer=new Layer(container);			
			midLayer=new Layer(container);
			topLayer=new Layer(container);
					
			//container.addChild(buttomLayer);
			//container.addChild(midLayer);
			//container.addChild(topLayer);	
			
		}
		public function get mask():DisplayObject
		{
			return container.mask;
		}
		
		public function set mask(value:DisplayObject):void
		{
			container.mask = value;
		}

		public function get x():int{
			return this.container.x;
		}
		public function set x(value:int):void{
			this.container.x =value;
		}
		
		public function get y():int{
			return this.container.y;
		}
		public function set y(value:int):void{
			this.container.y =value;
		}
		
		public function get filters():Array
		{
			return container.filters;
		}

		public function set filters(value:Array):void
		{
			container.filters = value;
		}

		public function get mouseEnabled():Boolean
		{
			return container.mouseEnabled;
		}

		public function set mouseEnabled(value:Boolean):void
		{
			container.mouseEnabled = value;
		}

		public function addChild(child:DisplayObject):DisplayObject
		{
			// TODO Auto Generated method stub
			return container.addChild(child);
		}
		
		public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			// TODO Auto Generated method stub
			return container.addChildAt(child, index);
		}
		
		public function areInaccessibleObjectsUnderPoint(point:Point):Boolean
		{
			// TODO Auto Generated method stub
			return container.areInaccessibleObjectsUnderPoint(point);
		}
		
		public function contains(child:DisplayObject):Boolean
		{
			// TODO Auto Generated method stub
			return container.contains(child);
		}
		
		public function getChildAt(index:int):DisplayObject
		{
			// TODO Auto Generated method stub
			return container.getChildAt(index);
		}
		
		public function getChildByName(name:String):DisplayObject
		{
			// TODO Auto Generated method stub
			return container.getChildByName(name);
		}
		
		public function getChildIndex(child:DisplayObject):int
		{
			// TODO Auto Generated method stub
			return container.getChildIndex(child);
		}
		
		public function getObjectsUnderPoint(point:Point):Array
		{
			// TODO Auto Generated method stub
			return container.getObjectsUnderPoint(point);
		}
		
		public function get mouseChildren():Boolean
		{
			// TODO Auto Generated method stub
			return container.mouseChildren;
		}
		
		public function set mouseChildren(enable:Boolean):void
		{
			// TODO Auto Generated method stub
			container.mouseChildren = enable;
		}
		
		
		
		public function get numChildren():int
		{
			// TODO Auto Generated method stub
			return container.numChildren;
		}
		
		public function removeChild(child:DisplayObject):DisplayObject
		{
			// TODO Auto Generated method stub
			return container.removeChild(child);
		}
		
		public function removeChildAt(index:int):DisplayObject
		{
			// TODO Auto Generated method stub
			return container.removeChildAt(index);
		}
		
		public function removeChildren(beginIndex:int=0, endIndex:int=2147483647):void
		{
			// TODO Auto Generated method stub
			container.removeChildren(beginIndex, endIndex);
		}
		
		public function setChildIndex(child:DisplayObject, index:int):void
		{
			// TODO Auto Generated method stub
			container.setChildIndex(child, index);
		}
		
		public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			// TODO Auto Generated method stub
			container.swapChildren(child1, child2);
		}
		
		public function swapChildrenAt(index1:int, index2:int):void
		{
			// TODO Auto Generated method stub
			container.swapChildrenAt(index1, index2);
		}
		
		public function get tabChildren():Boolean
		{
			// TODO Auto Generated method stub
			return container.tabChildren;
		}
		
		public function set tabChildren(enable:Boolean):void
		{
			// TODO Auto Generated method stub
			container.tabChildren = enable;
		}
		
		public function get textSnapshot():TextSnapshot
		{
			// TODO Auto Generated method stub
			return container.textSnapshot;
		}
		public function get buttomLayer():Layer
		{
			return _buttomLayer;
		}

		public function set buttomLayer(value:Layer):void
		{
			_buttomLayer = value;
		}

		public function get midLayer():Layer
		{
			return _midLayer;
		}

		public function set midLayer(value:Layer):void
		{
			_midLayer = value;
		}

		public function get topLayer():Layer
		{
			return _topLayer;
		}

		public function set topLayer(value:Layer):void
		{
			_topLayer = value;
		}

	}
}