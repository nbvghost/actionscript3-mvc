package com.sanbeetle.renderer
{
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.interfaces.IDisplayItem;
	import com.sanbeetle.interfaces.IFListItem;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class GridBoxItemRenderer extends Sprite implements IDisplayItem
	{
		private var clickedCl:uint = 0x52892a;
		private var selectedCl:uint = clickedCl;
		private var overCl:uint = 0x426893;



		private var over_alpha:Number = 0.05;
		private var clicked_alpha:Number = 0.35;
		private var select_alpha:Number = clicked_alpha;


		private var bg:Shape;
		private var selectShape:Shape;
		private var mouseOverShape:Shape;


		private var _select:Boolean = false;

		private var _width:Number = 0;
		private var _height:Number = 0;

		private var _data:IFListItem;
		private var _listData:ListData;

		public function GridBoxItemRenderer ()
		{
			super ();

			bg = new Shape();
			this.addChildAt (bg,0);

			selectShape = new Shape();
			this.addChildAt (selectShape,1);

			mouseOverShape = new Shape();
			this.addChildAt (mouseOverShape,2);
			
		}

		private function mouseHandler (event:MouseEvent):void
		{

			switch (event.type)
			{
				case MouseEvent.MOUSE_OVER :

					mouseOverShape.graphics.clear ();
					mouseOverShape.graphics.beginFill (overCl,over_alpha);
					mouseOverShape.graphics.drawRect (0,0,this._width,this._height);
					mouseOverShape.graphics.endFill ();

					break;
				case MouseEvent.RIGHT_MOUSE_DOWN :
				case MouseEvent.MOUSE_DOWN :
					mouseOverShape.graphics.clear ();
					mouseOverShape.graphics.beginFill (clickedCl,clicked_alpha);
					mouseOverShape.graphics.drawRect (0,0,this._width,this._height);
					mouseOverShape.graphics.endFill ();

					//只有一条;
					mouseOverShape.graphics.beginFill (0x000000,0.1);
					mouseOverShape.graphics.drawRect (0,0,this._width,1);
					mouseOverShape.graphics.endFill ();
					break;

				case MouseEvent.MOUSE_UP :
					mouseOverShape.graphics.clear ();
					mouseOverShape.graphics.beginFill (overCl,over_alpha);
					mouseOverShape.graphics.drawRect (0,0,this._width,this._height);
					mouseOverShape.graphics.endFill ();
					break;
				case MouseEvent.MOUSE_OUT :
					mouseOverShape.graphics.clear ();
					break;

			}
		}
		public function get data ():IFListItem
		{
			return _data;
		}

		public function mouseDown (event:MouseEvent):void
		{
			mouseHandler (event);
		}


		public function set data (value:IFListItem):void
		{
			_data = value;

		}

		public function get contentWidth ():Number
		{
			return 0;
		}

		public function get contentHeight ():Number
		{
			return _height;
		}

		public function get listData ():ListData
		{
			return _listData;
		}

		public function set listData (value:ListData):void
		{
			this._listData = value;
		}	

		public function setSize (_width:Number, _height:Number, autoLayOut:Boolean=false,index:int=-1):void
		{
			this._width = _width;
			this._height = _height;

			bg.graphics.clear ();
			bg.graphics.beginFill (0xffffff,0);
			bg.graphics.drawRect (0,0,_width,_height);
			bg.graphics.endFill ();

		}

		public function mouseOut (event:MouseEvent):void
		{
			mouseHandler (event);
		}

		public function mouseOver (event:MouseEvent):void
		{
			mouseHandler (event);
		}

		public function doAction (actionType:String, actionComplete:Function, actionPar:Array=null):void
		{

		}

		public function get selected ():Boolean
		{
			return _select;
		}

		public function set selected (value:Boolean):void
		{
			_select = value;
			if (_select)
			{
				selectShape.graphics.clear ();
				selectShape.graphics.beginFill (selectedCl,select_alpha);
				selectShape.graphics.drawRect (0,0,this._width,this._height);
				selectShape.graphics.endFill ();
			}
			else
			{
				selectShape.graphics.clear ();
			}


		}

		public function get haveStage ():Boolean
		{
			return false;
		}

		public function setStage (value:Boolean):void
		{
		}
	}
}