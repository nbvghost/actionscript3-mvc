package com.sanbeetle.component.child {
	
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.data.DataProvider;
	
	import flash.display.MovieClip;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	
	public class IRadarSkinLabel extends MovieClip {
		
		private var _dataPro:DataProvider;
		public function IRadarSkinLabel() {
			
		}

		public function get dataPro():DataProvider
		{
			return _dataPro;
		}

		private var labelArr:Array = new Array;
		public function dataProvider(value:DataProvider,viewHeight:int):void
		{
			
			for(var y:int;y<labelArr.length;y++){
				labelArr[y].dispose();
				this.removeChild(labelArr[y]);
			}
			labelArr.splice(0,labelArr.length);
			
			_dataPro = value;		
			
			var r:Number = (Math.PI*2)/8;
			
			for(var i:int=0;i<8;i++){
				if(i>(_dataPro.length-1)){
					_dataPro.addItem({label:"字段",data:50});
				}
				var valuess:Number = viewHeight+10;
				var xx:Number =Math.cos(r*(i)-(Math.PI/2))*valuess;
				var yy:Number = Math.sin(r*(i)-(Math.PI/2))*valuess;
				
				var lable:ILabel = new ILabel();
				lable.leading =0;
				lable.text = _dataPro.getItemAt(i).label;
				lable.autoSize = TextFieldAutoSize.LEFT;				
				//lable.border =true;
				lable.align = TextFormatAlign.LEFT;
				//lable.setSize(50,50);
				lable.x = xx;
				lable.bold =true;
				lable.y =yy;
				lable.fontSize = "10";
				this.addChild(lable);
				labelArr.push(lable);
				lable.y = lable.y-(lable.height/2);
				if(i==0){
					lable.align = TextFormatAlign.CENTER;
					lable.x =lable.x -(lable.width/2);
				}
				if(i==4){
					lable.align = TextFormatAlign.CENTER;
					lable.x =lable.x -(lable.width/2);
				}
				if(i>4){
					lable.align = TextFormatAlign.RIGHT;
					lable.x =lable.x -lable.width;
				}
				
			}
			
		}

	}
	
}
