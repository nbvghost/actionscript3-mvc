package com.sanbeetle.component {
	
	import com.sanbeetle.component.child.IRadarSkinLabel;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.skin.IRadarSkinMc;
	
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	
	public class IRadar extends UIComponent {
		
		private var mc:MovieClip;
		private var labelmc:IRadarSkinLabel;
		
		private var _maxValue:Number=100;
		//private var _currentValues:Array=[10,10,10,10,10,10,10,10];
		private var _lineThickness:Number=1;
		private var _lineColor:String= "0x000000";
		
		private var lineLayer:Shape =new Shape();
		
		private var _dataProvider:DataProvider= new DataProvider();
		
		private const mcHeight:Number=44.5;
		
		private var _labelColor:uint = 0x000000;
		
		public function IRadar() {
			mc = new IRadarSkinMc();			
			labelmc=new IRadarSkinLabel();
			
			labelmc.labelColor = _labelColor;
		}
		
		[Inspectable(type="Color",defaultValue="0x000000")]
		public function get labelColor():uint
		{
			return _labelColor;
		}

		public function set labelColor(value:uint):void
		{
			if(_labelColor != value){
				_labelColor = value;
				labelmc.labelColor = _labelColor;
			}
		}

		[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item",collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}
		public function set dataProvider(value:DataProvider):void
		{
			_dataProvider = value;			
			
			labelmc.dataProvider(_dataProvider,this.mcHeight);
			
			_dataProvider=labelmc.dataPro;
			startTimer();
		}		
		[Inspectable(defaultValue = 0x000000)]
		public function get lineColor():String
		{
			return _lineColor;
		}
		
		public function set lineColor(value:String):void
		{
			_lineColor = value;
			startTimer();
		}
		[Inspectable(defaultValue = 1)]
		public function get lineThickness():Number
		{
			return _lineThickness;
		}
		
		public function set lineThickness(value:Number):void
		{
			_lineThickness = value;
			startTimer();
		}		
		[Inspectable(defaultValue = 100)]
		public function get maxValue():Number
		{
			return _maxValue;
		}
		
		public function set maxValue(value:Number):void
		{
			_maxValue = value;
			startTimer();
		}
		
		override protected function createUI():void
		{
			
			/*_dataProvider.addItem({label:"速度",data:50-12});
			_dataProvider.addItem({label:"进攻",data:50-35});
			_dataProvider.addItem({label:"技术",data:50-15});
			_dataProvider.addItem({label:"创造",data:50-30});
			_dataProvider.addItem({label:"精神",data:50-10});
			_dataProvider.addItem({label:"防守",data:50-30});
			_dataProvider.addItem({label:"制空",data:50-10});
			_dataProvider.addItem({label:"身体",data:50-20});	*/
			
			
			this.addChild(labelmc);
			this.addChild(mc);
			
			mc.x = (trueWidth)/2;
			mc.y = (trueHeight)/2;
			
			labelmc.x = (trueWidth)/2;
			labelmc.y = (trueHeight)/2;
			
			mc.addChild(lineLayer);
			
			labelmc.dataProvider(_dataProvider,this.mcHeight);
			
			_dataProvider=labelmc.dataPro;
			//mc.alpha =0.5;		
			
			
			startTimer();
			
		}	
		
		override protected function updateUI():void
		{
			// TODO Auto Generated method stub
			super.updateUI();
			
			
		}		
		
		private function startTimer():void{
			//Console.out("components"+this._lineColor);
			lineLayer.graphics.clear();
			lineLayer.graphics.lineStyle(this.lineThickness,uint(_lineColor),1,true,LineScaleMode.NONE);
			lineLayer.graphics.beginFill(0xffffff,0);
			
			var r:Number = (Math.PI*2)/8;	
			
			for(var i:int=0;i<_dataProvider.length;i++){
				var value:Number =  (Number(_dataProvider.getItemAt(i).data)/this._maxValue)*mcHeight;
				var xx:Number =Math.cos(r*(i)-(Math.PI/2))*value;
				var yy:Number = Math.sin(r*(i)-(Math.PI/2))*value;				
				
				if(i==0){
					lineLayer.graphics.moveTo(xx,yy);
				}else{
					lineLayer.graphics.lineTo(xx,yy);
				}				
			}			
			lineLayer.graphics.endFill();
			
		}		
		
	}
	
}
