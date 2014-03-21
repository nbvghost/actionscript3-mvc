package com.sanbeetle.core
{
	import com.sanbeetle.Component;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Point;
	
	public class BoundDisplayObject
	{
		private var _height:int=0;
		private var _width:int=0;
		private var border:Shape = new Shape();
		private var _contentContainer:DisplayObjectContainer;		
		
		public function BoundDisplayObject(_contentContainer:DisplayObjectContainer)
		{
			this._contentContainer = _contentContainer;
			
			upData();
			
			
		}	
		public function upData():void{
			var x:int=0;
			var y:int=0;
			
			border.graphics.clear();
			
			
			if(_contentContainer is Stage){
				_width = Stage(_contentContainer).stageWidth;
				_height = Stage(_contentContainer).stageHeight;
				x= Stage(_contentContainer).x;
				y= Stage(_contentContainer).y;					
				
			}else{
				x = _contentContainer.x;
				y = _contentContainer.y;
				_width = _contentContainer.width;
				_height = _contentContainer.height;					
			}
			
			if(Component.component.debug){	
				
				border.graphics.beginFill(0xff0000,1);
			}else{
				border.graphics.beginFill(0xff0000,0);
			}		
			border.graphics.drawRect(x,y,_width,_height);
			border.graphics.drawRect(x+1,y+1,_width-2,_height-2);
			border.graphics.endFill();		
			_contentContainer.addChildAt(border,0);	
		}
		public function get isSetContainer():Boolean{
			if(_contentContainer.parent==null){
				if( !(_contentContainer is Stage)){
					return false;
				}				
				
			}
			return true; 
		}
		public function get parent():DisplayObjectContainer{
			
			return _contentContainer.parent;
		}
		public function get mine():DisplayObjectContainer{
			return _contentContainer;
		}
		public function localToGlobal(point:Point):Point{
			return _contentContainer.localToGlobal(point);
		}
		public function globalToLocal(point:Point):Point{
			
			return _contentContainer.globalToLocal(point);
		}
		public function get height():Number
		{
			return _height;
		}
		
		public function get width():Number
		{
			// TODO Auto Generated method stub
			return _width;
		}
		
	}
}