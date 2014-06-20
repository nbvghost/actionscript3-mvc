package com.sanbeetle.component.child {
	
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.core.DisplayItem;
	import com.sanbeetle.data.LineCollectionItem;
	import com.sanbeetle.data.ListChildItem;
	import com.sanbeetle.skin.IListBoxItemBg;
	import com.sanbeetle.skin.ListSkinsChildArrow;
	
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class IListBoxItem extends DisplayItem {
		
		private var label:ILabel;
		private var bg:IListBoxItemBg;
		private var chidlAroww:ListSkinsChildArrow;
		
		public function IListBoxItem() {
			this.buttonMode =true;
			label = new ILabel();
			
			chidlAroww = new ListSkinsChildArrow;
			
			bg = new IListBoxItemBg;
			this.addChild(bg);
			bg.cacheAsBitmap = true;
			
			bg.mouseEnabled = false;
			bg.mouseChildren =false;
			label.mouseChildren = false;
			label.mouseEnabled = false;			
			label.multiline = false;
			label.autoBound = true;		
			
			
			//label.leading = 0;
			//label.border =true;
			//label.autoSize = TextFieldAutoSize.LEFT;
			//label.color = color;
			
			//label.width = 100;
			//label.align = TextFormatAlign.LEFT;			
			//label.autoSize = TextFieldAutoSize.LEFT;
			//Console.out("components"+"components"+"iladel"+iladel.width);
			label.fontSize = "12";
			
			label.verticalAlign = VerticalAlign.MIDDLE;
			
			label.height=bg.height;			
			
			//label.mouseEnabled =false;
			//label.mouseChildren = false;
			//iladel.border =true;
			label.x = 8;
			
			//chidlAroww.x =bg.width-chidlAroww.width-30;
			//chidlAroww.y = (bg.height-chidlAroww.height)/2;
			
			this.addChild(label);
			//this.width = 100;
			//this.height =20;
			//label.upDisplayList();
			
			
		}
		
		override public function mouseOut(event:MouseEvent):void
		{
			
			bg.gotoAndStop(1);
			label.color = data.itemColor;
		}
		
		override public function mouseOver(event:MouseEvent):void
		{
			
			bg.gotoAndStop(2);
			label.color = data.itemOverColor;
		}		
		override public function doAction(actionType:String, actonComplete:Function,age:Array=null):void
		{
			if(data.enable){
				actonComplete.apply(this,age);
			}
			
		}
		
		override protected function drawLayout(cw:Number, ch:Number,autoLayOut:Boolean=false):void
		{
			
			
			this.addChild(bg);
			this.addChild(label);
			
			
			
			var lci:ListChildItem = data as ListChildItem;
			
			if(lci){
				if(lci.childs!=null){
					if(lci.childs.length>0){
						
						this.addChild(chidlAroww);
					}
					
					
				}else{
					if(chidlAroww.parent){
						chidlAroww.parent.removeChild(chidlAroww);
					}
				}
			}else{
				if(chidlAroww.parent){
					chidlAroww.parent.removeChild(chidlAroww);
				}
			}
			this.graphics.clear();
			
			if(isLineAndDraw()){
				this.bg.width = cw;
				drawLine();
				
				this.mouseChildren = false;
				this.mouseEnabled = false;
				
			}else{
				
				this.mouseChildren = true;
				this.mouseEnabled = true;
			
				
				if(data.enable==false){
					this.bg.alpha = 0.3;
					label.alpha = 0.3;
				}else{
					this.bg.alpha = 1;
					label.alpha=1;
				}
				
				if(autoLayOut){
					label.autoBound = true;
					label.multiline = false;
					label.upDisplayList();
					this.bg.width = label.width+8;
					chidlAroww.x =bg.width-chidlAroww.width-10;
					chidlAroww.y = (bg.height-chidlAroww.height)/2;				
					this.label.width = cw-8;
					
					
				}else{
					label.autoBound = false;
					label.multiline = false;
					label.upDisplayList();
					this.bg.width = cw;
					chidlAroww.x =bg.width-chidlAroww.width-10;
					chidlAroww.y = (bg.height-chidlAroww.height)/2;				
					this.label.width = cw-8;
					
				}				
				label.y = (bg.height-label.height)/2;
				
			}			
		}	
		override public function get contentWidth():Number
		{
			return this.bg.width;
		}		
		override public function get contentHeight():Number{
			return this.bg.height;
		}	
		
		override protected function createUI():void
		{
			this.graphics.clear();
			
			if(isLineAndDraw()){
				//this.removeChild(chidlAroww);
				drawLine();
				
			}else{
				
			
				//this.mouseEnabled = data.enable;
//				/this.mouseChildren = data.enable;
				
				
				
				label.color=data.itemColor;
				
				label.text = data.label;
			
				label.upDisplayList();
				//bg.height = label.height;
				
				this.bg.width = 8+label.width;
			}
			
			
		}		
		
		private function drawLine():void{
			
			if(label.parent){
				label.parent.removeChild(label);
			}
			if(bg.parent){
				bg.parent.removeChild(bg);
			}			
			
			bg.height = 9;
			
			this.graphics.clear();
			this.graphics.lineStyle(1,0x000000,0.3,false,LineScaleMode.VERTICAL,CapsStyle.NONE);
			this.graphics.moveTo(0,4);
			this.graphics.lineTo(this.contentWidth,4);
			
		}
		
		private function isLineAndDraw():Boolean{	
			
			var isLine:Boolean = false;
			
			if(data!=null){
				if(data is LineCollectionItem){
					isLine = true;
				}else if(data.label=="-" || data.data=="-"){					
					
					isLine = true;
				}else{
					
					isLine = false;
				}
			}	
			if(isLine==false){
				bg.scaleY = 1;
				//label.height=bg.height;
			}
			
			return isLine;
		}		
		
		
	}
	
}
