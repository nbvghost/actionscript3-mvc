package com.sanbeetle.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class StateButton extends Sprite
	{
		
		private var _upState:DisplayObject;
		private var _overState:DisplayObject;
		private var _downState:DisplayObject;
		private var _disenableState:DisplayObject;
		
		private var _currentState:DisplayObject;
		
		private var _width:int=70;
		private var _height:int=20;
		
		private var _enable:Boolean = true;
		private var _select:Boolean = false;
		
		public function StateButton(upState:DisplayObject,overState:DisplayObject,downState:DisplayObject,disenableState:DisplayObject=null)
		{
			super();
			this._upState =upState;
			this._overState = overState;
			this._downState = downState;
			this._disenableState = disenableState;			
			
			this.mouseChildren = false;
			currentState = _upState;
			
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseHandler);	
			this.updateUI();
		}		

		private function get currentState():DisplayObject
		{
			return _currentState;
		}

		private function set currentState(value:DisplayObject):void
		{
			if(_currentState!=null){
				if(_currentState.parent){
					_currentState.parent.removeChild(_currentState);
				}
			}
			_currentState = value;
		}

		public function set disenableState(value:DisplayObject):void
		{
			_disenableState = value;
		}

		public function set downState(value:DisplayObject):void
		{
			_downState = value;
		}

		public function set overState(value:DisplayObject):void
		{
			_overState = value;
		}

		public function set upState(value:DisplayObject):void
		{
			_upState = value;
			currentState = _upState;
		}

		public function get select():Boolean
		{
			return _select;
		}

		public function set select(value:Boolean):void
		{
			_select = value;			
			if(_select){
				currentState = this._downState;
			}else{
				currentState = this._upState;
			}
			updateUI();
		}

		override public function get height():Number
		{			
			return _height;
		}
		
		override public function set height(value:Number):void
		{			
			_height = value;
			
			updateUI();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{			
			
			_width = value;
			updateUI();
		}		
		public function get enable():Boolean
		{
			return _enable;
		}

		public function set enable(value:Boolean):void
		{
			_enable = value;
			this.mouseEnabled = _enable;	
			if(_enable==false){
				
				_upState.alpha = 0.3;
			}else{
				_upState.alpha = 1;
			}
			updateUI();
		}
		private function updateUI():void{
			
			if(currentState==null){
				currentState = this._upState;
			}
			currentState.width = this._width;
			currentState.height = this._height;
			
			this.addChild(currentState);
			
		}
		private function onMouseHandler(event:MouseEvent):void
		{
			if(_select){
				return;
			}
			//Console.out("components"+event.type);
			switch(event.type){
				case MouseEvent.MOUSE_OVER:
					currentState = overState;
					break;
				case MouseEvent.MOUSE_DOWN:
					currentState = this._downState;
					break;
				case MouseEvent.MOUSE_OUT:
					currentState = _upState;
					break;
				case MouseEvent.MOUSE_UP:
					currentState = _upState;
					break;
				default:
					return;
			}
			
			updateUI();
		}
		
		public function get disenableState():DisplayObject
		{
			return _disenableState;
		}
		
		public function get downState():DisplayObject
		{
			return _downState;
		}
		

		public function get overState():DisplayObject
		{
			return _overState;
		}

	

		public function get upState():DisplayObject
		{
			return _upState;
		}

		

	}
}