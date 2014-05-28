package com.game.framework.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.geom.Point;
	import flash.text.TextSnapshot;
	
	
	
	
	/**
	 *
	 *@author sixf
	 */
	public class Layer extends BaseLayer
	{
		
		
		
		public function Layer(parentContainer:DisplayObjectContainer)
		{
			super(parentContainer);	
		}
		public function get mouseX():Number {
			return 	_container.mouseX;
		}
		public function get mouseY():Number{
			return _container.mouseY;
		}
		public function get loaderInfo():LoaderInfo{
			return _container.loaderInfo;
		}
		public function get visible():Boolean
		{
			return _container.visible;
		}
		
		public function set visible(value:Boolean):void
		{
			_container.visible = value;
		}
		
		public function globalToLocal(point:Point):Point{
			return _container.globalToLocal(point);
		}
		public function localToGlobal(point:Point):Point{
			return _container.localToGlobal(point);
		}
		
		public function get mask():DisplayObject
		{
			return _container.mask;
		}
		
		public function set mask(value:DisplayObject):void
		{
			_container.mask = value;
		}
		
		public function get x():int{
			return this._container.x;
		}
		public function set x(value:int):void{
			this._container.x =value;
		}
		
		public function get y():int{
			return this._container.y;
		}
		public function set y(value:int):void{
			this._container.y =value;
		}
		
		public function get filters():Array
		{
			return _container.filters;
		}
		
		public function set filters(value:Array):void
		{
			_container.filters = value;
		}
		
		public function get mouseEnabled():Boolean
		{
			return _container.mouseEnabled;
		}
		
		public function set mouseEnabled(value:Boolean):void
		{
			_container.mouseEnabled = value;
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			// TODO Auto Generated method stub
			return _container.addChild(child);
		}
		
		public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if(index<0){
				index=0;
			}
			// TODO Auto Generated method stub
			return _container.addChildAt(child, index);
		}
		
		public function areInaccessibleObjectsUnderPoint(point:Point):Boolean
		{
			// TODO Auto Generated method stub
			return _container.areInaccessibleObjectsUnderPoint(point);
		}
		
		public function contains(child:DisplayObject):Boolean
		{
			// TODO Auto Generated method stub
			return _container.contains(child);
		}
		
		public function getChildAt(index:int):DisplayObject
		{
			// TODO Auto Generated method stub
			return _container.getChildAt(index);
		}
		
		public function getChildByName(name:String):DisplayObject
		{
			// TODO Auto Generated method stub
			return _container.getChildByName(name);
		}
		
		public function getChildIndex(child:DisplayObject):int
		{
			// TODO Auto Generated method stub
			return _container.getChildIndex(child);
		}
		
		public function getObjectsUnderPoint(point:Point):Array
		{
			// TODO Auto Generated method stub
			return _container.getObjectsUnderPoint(point);
		}
		
		public function get mouseChildren():Boolean
		{
			// TODO Auto Generated method stub
			return _container.mouseChildren;
		}
		
		public function set mouseChildren(enable:Boolean):void
		{
			// TODO Auto Generated method stub
			_container.mouseChildren = enable;
		}
		
		
		
		public function get numChildren():int
		{
			// TODO Auto Generated method stub
			return _container.numChildren;
		}
		
		public function removeChild(child:DisplayObject):DisplayObject
		{
			if(child){
				if(_container.contains(child)){
					_container.removeChild(child);
				}
			}
			return child;
		}
		
		public function removeChildAt(index:int):DisplayObject
		{
			
			return _container.removeChildAt(index);
		}
		
		public function removeChildren(beginIndex:int=0, endIndex:int=2147483647):void
		{
			// TODO Auto Generated method stub
			_container.removeChildren(beginIndex, endIndex);
		}
		
		public function setChildIndex(child:DisplayObject, index:int):void
		{
			// TODO Auto Generated method stub
			_container.setChildIndex(child, index);
		}
		
		public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			// TODO Auto Generated method stub
			_container.swapChildren(child1, child2);
		}
		
		public function swapChildrenAt(index1:int, index2:int):void
		{
			// TODO Auto Generated method stub
			_container.swapChildrenAt(index1, index2);
		}
		
		public function get tabChildren():Boolean
		{
			// TODO Auto Generated method stub
			return _container.tabChildren;
		}
		
		public function set tabChildren(enable:Boolean):void
		{
			// TODO Auto Generated method stub
			_container.tabChildren = enable;
		}
		
		public function get textSnapshot():TextSnapshot
		{
			// TODO Auto Generated method stub
			return _container.textSnapshot;
		}
		
	}
}