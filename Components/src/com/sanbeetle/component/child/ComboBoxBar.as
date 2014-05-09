package com.sanbeetle.component.child
{
	import com.asvital.dev.Log;
	import com.sanbeetle.component.ComboBox;
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.core.DisplayItem;
	import com.sanbeetle.core.ExtendMovieClip;
	import com.sanbeetle.core.StateButton;
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.data.SimpleCollectionItem;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.skin.ComboBoxBarArrow;
	import com.sanbeetle.skin.ComboBoxBarBg_rb_bg_over;
	import com.sanbeetle.skin.ComboBoxBarBg_rb_bg_up;
	import com.sanbeetle.skin.ComboBoxBarBg_rb_down;
	import com.sanbeetle.skin.ComboBoxBarBg_rb_over;
	import com.sanbeetle.skin.ComboBoxBarBg_rb_up;
	import com.sanbeetle.skin.ComboBoxBarOverBg;
	import com.sanbeetle.skin.ComboBox_downSkin;
	import com.sanbeetle.skin.ComboBox_overSkin;
	import com.sanbeetle.skin.ComboBox_upSkin;
	
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import fl.motion.Color;
	
	[Event(name="select", type="com.sanbeetle.events.ControlEvent")]
	
	public class ComboBoxBar extends ExtendMovieClip 
	{
		private var _label:String="default label";
		private var _height:Number=0;
		private var _width:Number = 0;
		private var _backgroundType:String;
		private var _labelTxt:ILabel;
		
		private var _cx:Number = 0;
		private var randFunc:Function;
		private var _fontSize:String = "10";
		private var _fontColor:String = "0xffffff";
		
		
		private var _displayItem:DisplayItem;
		
		
		private var _defaultLabel:String;
		
		public function get defaultLabel():String
		{
			return _defaultLabel;
		}
		
		public function set defaultLabel(value:String):void
		{
			_defaultLabel = value;
			
			var data:SimpleCollectionItem = new SimpleCollectionItem(_defaultLabel,null);
			data.itemColor = _fontColor;
			_displayItem.data = data;			
			_displayItem.listData =new ListData(_displayItem.data,0,-1,null);	
			
		}
		
		public function get displayItem():DisplayItem
		{
			return _displayItem;
		}
		
		public function set displayItem(value:DisplayItem):void
		{
			
			
			var DClass:Class = getDefinitionByName(getQualifiedClassName(value)) as Class;
			
			if(_displayItem!=null){
				if(_displayItem.parent){
					_displayItem.parent.removeChild(_displayItem);
				}
			}
			_displayItem = new DClass();	
			
			var data:IFListItem = new SimpleCollectionItem(value.data.label,value.data.data);
			data.enable  = true;
			data.itemColor = this._fontColor;		
			_displayItem.data = data;
			_displayItem.setSize(value.contentWidth,value.contentHeight,true);
			//	Log.out(value.contentWidth,value.contentHeight);
			this.addChild(_displayItem);
			
			_displayItem.listData = value.listData;
			_displayItem.mouseEnabled = false;
			_displayItem.mouseChildren = false;
			_displayItem.buttonMode = false;
			//_displayItem.data = value.data;
			//_displayItem.setSize(value.contentWidth,value.contentHeight);			
			//	Log.out(_displayItem,"555");
			updateDis();
		}
		
		
		
		public function get cx():Number
		{
			return _cx;
		}
		
		/*public function get labelTxt():ILabel
		{
		return _labelTxt;
		}*/
		
		
		
		
		public function ComboBoxBar()
		{
			
			_displayItem = new IListBoxItem();
			
			var data:SimpleCollectionItem = new SimpleCollectionItem("defautl","defautl");
			data.itemColor = _fontColor;
			_displayItem.data = data;
			
			
			
			_displayItem.listData =new ListData(_displayItem.data,0,-1,null);		
			//this.addChild(_displayItem);			
			
			//labelTxt.color = "0xffffff";
			this.addEventListener(MouseEvent.CLICK,onClickHandler);
		}
		
		public function get fontColor():String
		{
			return _fontColor;
		}
		
		public function set fontColor(value:String):void
		{
			_fontColor = value;
			
			var data:SimpleCollectionItem = new SimpleCollectionItem(_defaultLabel,null);
			data.itemColor = _fontColor;
			_displayItem.data = data;		
			//_displayItem.listData =new ListData(_displayItem.data.label,0,-1);	
		}
		
		/*public function get fontSize():String
		{
		return _fontSize;
		}
		
		public function set fontSize(value:String):void
		{
		_fontSize = value;
		_labelTxt.fontSize = _fontSize;
		
		}*/
		
		
		
		
		
		
		protected function onClickHandler(event:MouseEvent):void
		{
			
			this.dispatchEvent(new ControlEvent(ControlEvent.SELECT).setMouseEvent(event));
		}
		
		public function get backgroundType():String
		{
			return _backgroundType;
		}
		
		public function set backgroundType(value:String):void
		{
			
			
			if(_backgroundType!=value){
				
				
				_backgroundType = value;
				
				while(this.numChildren>0){
					this.removeChildAt(0);
				}
				
				//_labelTxt.autoSize = TextFieldAutoSize.NONE;				
				///_labelTxt.x = 0;
				//_labelTxt.bold =false;
				_cx = 0;
				
				switch(_backgroundType){
					case ComboBox.background_default:
					{
						var btnUp:ComboBox_upSkin;
						var btnOver:ComboBox_overSkin;
						var btnDown:ComboBox_downSkin;
						
						btnUp = new ComboBox_upSkin();
						btnOver = new ComboBox_overSkin();
						btnDown = new ComboBox_downSkin();
						
						var btn:StateButton = new StateButton(btnUp,btnOver,btnDown);						
						//btn.addEventListener (MouseEvent.CLICK,onMouseListHandler);	
						btn.buttonMode = true;
						this.addChild(btn);
						
						this.addChild(_displayItem);
						
						_displayItem.mouseEnabled = false;
						
						
						
						randFunc = function ():void{
							
							btn.width = _width;
							btn.height = _height;							
							_displayItem.setSize( _width-15,_height);							
							_displayItem.y = (_height-_displayItem.contentHeight)/2;
						}
						
						break;
					}
					case ComboBox.background_none:
					{
						var arrow:ComboBoxBarArrow = new ComboBoxBarArrow();
						this.addChild(arrow);
						this.addChild(_displayItem);
						
						//_labelTxt.autoSize = TextFieldAutoSize.LEFT;
						
						randFunc = function ():void{
							arrow.x = _width-arrow.width;
							arrow.y = (_height-arrow.height)/2;	
							
							_displayItem.x = _width-_displayItem.contentWidth-arrow.width-4;							
							//_labelTxt.bold =true;							
							_displayItem.setSize(_displayItem.contentWidth,_displayItem.contentHeight,true);						
							
							_displayItem.y = (_height-_displayItem.contentHeight)/2;
							_cx= _displayItem.x;
							
							//btn.width = _width;
							//btn.height = _height;
							
						}
						
						break;
					}
					case ComboBox.background_over:
					{
						var arrowa:ComboBoxBarArrow = new ComboBoxBarArrow();
						var overBg:ComboBoxBarOverBg = new ComboBoxBarOverBg();
						overBg.visible =false;
						this.addChild(overBg);
						this.addChild(arrowa);
						this.addChild(_displayItem);
						//_labelTxt.autoSize = TextFieldAutoSize.LEFT;
						this.addEventListener(MouseEvent.MOUSE_OVER,onBgHandler);
						this.addEventListener(MouseEvent.MOUSE_OUT,onBgHandler);
						function onBgHandler(e:MouseEvent):void{
							if(e.type == MouseEvent.MOUSE_OVER){
								overBg.visible =true;
							}else{
								overBg.visible =false;
							}
							
						}
						randFunc = function ():void{
							this.graphics.clear();
							this.graphics.beginFill(0xffffff,0);
							this.graphics.drawRect(0,0,_width,_height);
							this.graphics.endFill();
							overBg.width = _width;
							overBg.height = _height;
							
							arrowa.y = (_height-arrowa.height)/2;	
							arrowa.x = _width-8-arrowa.width;
							//_labelTxt.y = (_height-_labelTxt.height)/2;
							//_labelTxt.height =_height;	
							
							
							
							
							_displayItem.x = 4;
							
							_displayItem.setSize(_width -_displayItem.x-8-8-arrowa.width,_displayItem.contentHeight);
							//_displayItem.width = _width -_displayItem.x-8-8-arrowa.width;
							//displayItemBitMap.autoSize = TextFieldAutoSize.LEFT;
							_displayItem.y = (_height-_displayItem.contentHeight)/2;
							
							
						}
						break;
					}
					case ComboBox.backround_rb:
					{
						
						var te:StateButton = new StateButton(new ComboBoxBarBg_rb_bg_up,new ComboBoxBarBg_rb_bg_over,new ComboBoxBarBg_rb_bg_over);
						var rb:StateButton = new StateButton(new ComboBoxBarBg_rb_up,new ComboBoxBarBg_rb_over,new ComboBoxBarBg_rb_down);
						
						
						this.addChild(te);
						this.addChild(rb);
						this.addChild(_displayItem);
						
						
						randFunc = function ():void{
							//_height = 23;
							te.width = _width;
							te.height = _height;
							
							rb.width = 22;
							rb.height=_height;
							
							rb.x = _width-rb.width;
							
							
							_displayItem.setSize(_width-rb.width,_displayItem.contentHeight);
							
							
							_displayItem.y = (_height-_displayItem.contentHeight)/2;
							
						}
						
						break;
					}
					default:
					{
						Log.info("ComboBox 没有找到背景:"+_backgroundType);
						break;
					}
				}			
				
			}			
			
		}
		
		/*public function get label():String
		{
		return _label;
		}
		
		public function set label(value:String):void
		{
		_label = value;
		labelTxt.text = _label;
		}*/
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return _height;
		}
		
		private function updateDis():void{
			
			if(randFunc!=null){
				randFunc();
			}
			
			_displayItem.mouseEnabled = false;
			_displayItem.mouseChildren = false;
			_displayItem.buttonMode = false;
			_displayItem.setSize(_displayItem.contentWidth,_displayItem.contentHeight,true);
			//_labelTxt.height = this.height;
		}
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			_height = value;
			updateDis();
			
			
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			_width = value;
			updateDis();
		}
		
		
	}
}