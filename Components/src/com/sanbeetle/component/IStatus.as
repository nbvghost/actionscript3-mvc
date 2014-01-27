package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IListBoxBg;
	import com.sanbeetle.skin.image.IStatus_bruise;
	import com.sanbeetle.skin.image.IStatus_lease;
	import com.sanbeetle.skin.image.IStatus_pre_sale;
	import com.sanbeetle.skin.image.IStatus_red_card;
	import com.sanbeetle.skin.image.IStatus_retire;
	import com.sanbeetle.skin.image.IStatus_sale;
	import com.sanbeetle.skin.image.IStatus_transfer;
	import com.sanbeetle.skin.image.IStatus_work;
	import com.sanbeetle.skin.image.IStatus_yellow_card;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	public class IStatus extends UIComponent {
		/**
		 * 退役 
		 */
		public static const RETIRE:String="retire";
		/**
		 * 工作
		 */
		public static const WORK:String="work";
		/**
		 * 受伤
		 */
		public static const BRUISE:String="bruise";
		/**
		 * 拍卖
		 */
		public static const SALE:String="sale";
		/**
		 * 抽调
		 */
		public static const TRANSFER:String="transfer";
		/**
		 * 租借
		 */
		public static const LEASE:String="lease";
		/**
		 * 预售 
		 */
		public static const PRE_SALE:String="pre_sale";
		/**
		 * 红牌
		 */
		public static const RED_CARD:String="red_card";
		/**
		 * 黄牌
		 */
		public static const YELLOW_CARD:String="yellow_card";
		
		private var _iconLabels:Array = ["red_card"];
		private var arr:Array = new Array();
		
		private var _pwidth:Number =100;
		
		private var rightDO:Sprite;
		private var bg:IListBoxBg;
		private var show:Boolean =false;
		public function IStatus() {
			rightDO = new Sprite();
			bg = new IListBoxBg();
			bg.width = this._pwidth;		
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);	
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMousehandler);			
		}		
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);	
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMousehandler);		
			
			this.clearn();
			
		}
		
		override protected function onAddStage():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);	
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMousehandler);		
			this.updateUI();
		}
		
		override protected function onRemoveStage():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);	
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMousehandler);		
			
			this.clearn();
		}
		
		
		protected function onMousehandler(event:MouseEvent):void
		{
			rightDO.x = stage.mouseX+10;
			rightDO.y = stage.mouseY+10;
		
			event.updateAfterEvent();
		}
		
		protected function onMouseOutHandler(event:MouseEvent):void
		{
			
			rightDO.visible =false;
			if(rightDO.parent){
				rightDO.parent.removeChild(rightDO);
			}
			
		}
		
		protected function onMouseOverHandler(event:MouseEvent):void
		{
			show =true;
			
			updateUI();
			rightDO.visible =true;
			stage.addChild(rightDO);
			
		}
		[Inspectable(type = "Array",defaultValue = "red_card")]
		public function get iconLabels():Array
		{
			return _iconLabels;
		}
		
		public function set iconLabels(value:Array):void
		{
			_iconLabels = value;
			updateUI();
		}
		private function clearn():void{
			for (var i:int = 0; i < arr.length; i++) 
			{
				var bitmap:Bitmap = arr[i];
				if (bitmap) 
				{
					if(bitmap.parent){
						bitmap.parent.removeChild(bitmap);
					}
					bitmap.bitmapData.dispose();
					bitmap.bitmapData =null;
					bitmap=null;
				}
			}
			
			arr.splice(0,arr.length);
			rightDO.removeChildren();
		}
		/**
		 *  这个方法会影响性能，请使用 iconLabels
		 * */
		public function addLable(label:String):void{
			_iconLabels.push(label);
			updateUI();
		}
		
		override public function createUI():void {
			
			
			rightDO.addChild(bg);
			rightDO.visible = false;
			
			//this.addChild(rightDO);
			
			updateUI();
		}
		
		override public function updateUI():void
		{
			if(_iconLabels==null){
				return;
				
			}
			clearn();
			//Console.out("components"+"components"+"_iconLabels",_iconLabels.length);
			if(_iconLabels.length<=0){
				
				return;
				
			}
			
			
			
			var ds:DisplayObject = getBitmapData(_iconLabels[0]);
			this.addChild(ds);
			arr.push(ds);
			
			if(!show){
				return;
			}
			bg.width =this._pwidth;
			
			var line:int=0;
			var xx:int=0;
			var total:int = 0;
			var ww:Number=0;
			for(var i:int=0;i<_iconLabels.length;i++){
				if(i==0){
					continue;
				}
				ds = getBitmapData(_iconLabels[i]);
				ds.x = ((ds.width+5)*xx)+10;
				
				if((ds.x+ds.width)>this.pwidth){		
					bg.width=ds.x-5+10;
					line++;
					xx=0;
					ds.x = ((ds.width+5)*xx)+10;
					xx=1;
					
					total=((line+3)*ds.height)+5;
					
				}else{
					xx++;
					ww=ds.x+ds.width+10;
					
				}
				if(xx==1){
					//bg.height = (ds.height+15)+((ds.height+15)*line);
					bg.height = ((ds.height+5)*(line+1))+10;
				}				
				
				ds.y =((ds.height+5)*line)+10;
				rightDO.addChild(ds);
				arr.push(ds);
			}
			if(line==0){
				bg.width = ww;
				
			}
			//Console.out("components"+line);
			//bg.height = total;
			
		}
		private function getBitmapData(label:String):DisplayObject{
			var currentBMD:BitmapData;
			switch(label){
				case IStatus.BRUISE:
					currentBMD = new IStatus_bruise;
					break;
				case IStatus.LEASE:
					currentBMD = new IStatus_lease;
					break;
				case IStatus.RED_CARD:
					currentBMD = new IStatus_red_card;
					break;
				case IStatus.RETIRE:
					currentBMD = new IStatus_retire;
					break;
				case IStatus.SALE:
					currentBMD = new IStatus_sale;
					break;
				case IStatus.TRANSFER:
					currentBMD = new IStatus_transfer;
					break;
				case IStatus.WORK:
					currentBMD = new IStatus_work;
					break;
				case IStatus.YELLOW_CARD:
					currentBMD = new IStatus_yellow_card;
					break;
				case IStatus.PRE_SALE:
					currentBMD = new IStatus_pre_sale;
					break;
				default :
					currentBMD = new IStatus_red_card;
					
			}
			
			return new Bitmap(currentBMD);
			
		}
		
		[Inspectable(defaultValue = "100")]
		public function get pwidth():Number {
			return _pwidth;
		}
		
		public function set pwidth(value:Number):void {
			_pwidth = value;
			updateUI();
		}
		
	}
	
}
