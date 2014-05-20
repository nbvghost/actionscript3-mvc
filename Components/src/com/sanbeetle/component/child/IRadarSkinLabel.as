package com.sanbeetle.component.child {
	
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.data.DataProvider;
	
	import flash.display.MovieClip;
	
	import flashx.textLayout.formats.TextAlign;
	
	
	public class IRadarSkinLabel extends MovieClip {
		
		private var _dataPro:DataProvider;
		private var _labelColor:uint=0x000000;
		public function IRadarSkinLabel() {
			
		}

		public function get labelColor():uint
		{
			return _labelColor;
		}

		public function set labelColor(value:uint):void
		{
			_labelColor = value;
			for (var i:int = 0; i < labelArr.length; i++) 
			{
				var ite:ILabel = labelArr[i];
				if(ite){
					ite.color = String(_labelColor);
				}
			}
			
		}

		public function get dataPro():DataProvider
		{
			return _dataPro;
		}

		
		private var labelArr:Array = new Array;
		public function dataProvider(value:DataProvider,viewHeight:int):void
		{
			
			for(var y:int;y<labelArr.length;y++){
				//labelArr[y].dispose();
				this.removeChild(labelArr[y]);
			}
			labelArr.splice(0,labelArr.length);
			
			_dataPro = value;		
			
			var r:Number = (Math.PI*2)/8;
			
			for(var i:int=0;i<8;i++){
				if(i>(_dataPro.length-1)){
					_dataPro.addItem({label:"字段"+i,data:50});
				}
				var valuess:Number = viewHeight+5;
				var xx:Number =Math.cos(r*(i)-(Math.PI/2))*valuess;
				var yy:Number = Math.sin(r*(i)-(Math.PI/2))*valuess;
				
				var lable:ILabel = new ILabel();
				//lable.leading =0;
				lable.text = _dataPro.getItemAt(i).label;
				//lable.autoSize = TextFieldAutoSize.LEFT;	
				lable.autoBound = true;
				lable.multiline =false;
				lable.color =String(_labelColor);
				//lable.border =true;
				//lable.align = TextFormatAlign.LEFT;
				lable.horizontalAlign = TextAlign.LEFT;
				//lable.setSize(50,50);
				lable.x = xx;
				lable.bold =true;
				lable.y =yy;
				lable.fontSize = "10";
				this.addChild(lable);
				labelArr.push(lable);
				lable.y = lable.y-(lable.height/2);
				if(i==0){
					//lable.align = TextFormatAlign.CENTER;
					lable.horizontalAlign = TextAlign.CENTER;
					lable.x =lable.x -(lable.width/2);
					
					lable.y = -viewHeight-lable.height-2;
					
				}
				if(i==4){
					//lable.align = TextFormatAlign.CENTER;
					lable.horizontalAlign = TextAlign.CENTER;
					lable.x =lable.x -(lable.width/2);
					
					lable.y = viewHeight+2;
				}
				if(i>4){
					//lable.align = TextFormatAlign.RIGHT;
					lable.horizontalAlign = TextAlign.RIGHT;
					lable.x =lable.x -lable.width;
				}
				
			}
			
		}

	}
	
}
