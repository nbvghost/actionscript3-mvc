package com.sanbeetle.component
{
	import com.sanbeetle.component.child.ExtendButton;
	import com.sanbeetle.component.child.SideExtendButton;
	import com.sanbeetle.skin.TabButton_left_left_down;
	import com.sanbeetle.skin.TabButton_left_left_over;
	import com.sanbeetle.skin.TabButton_left_left_up;
	import com.sanbeetle.skin.TabButton_left_mid_down;
	import com.sanbeetle.skin.TabButton_left_mid_over;
	import com.sanbeetle.skin.TabButton_left_mid_up;
	import com.sanbeetle.skin.TabButton_left_right_down;
	import com.sanbeetle.skin.TabButton_left_right_over;
	import com.sanbeetle.skin.TabButton_left_right_up;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	/**
	 *
	 *@author sixf
	 */
	public class ITabSideButton extends ITabButton
	{
		
		
		private var _vspace:int = -15;
		
		
		private var tx:Number = 7;
		
		
		private var hideSpace:int = 10;
		
		
		private var maskMC:Shape = new Shape();
		
		
		public function ITabSideButton()
		{
			super();
			fontSize="11";
			
			this.mask = maskMC;
			this.addChild(maskMC);
			
		}	
		
		public function get vspace():int
		{
			return _vspace;
		}
		
		public function set vspace(value:int):void
		{
			_vspace = value;
		}
		
		override public function set childData(value:Array):void
		{
			
		}	
		
		override public function createUI():void
		{
			updateUI();
		}
		
		override protected function onClickHandle(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.onClickHandle(event);
		}
		
		override protected function showList(current:ExtendButton):void
		{
			// TODO Auto Generated method stub
			super.showList(current);
			
			if(oldButton){				
				oldButton.x = this.tx;
				if(oldButton.select==false){
					
					oldButton.buttonLabel.alpha = 0.5;
					oldButton.buttonLabel.x = 8;
				}
			}
			
			current.buttonLabel.x = 10;
			current.x = 0;
		}
		
		override public function dispose():void
		{
			for each(var btn:ExtendButton in  btnArr){
				if(btn.parent!=null){
					
					btn.parent.removeChild(btn);
				}
				btn.removeEventListener(MouseEvent.MOUSE_DOWN,onClickHandle);
				btn.removeEventListener(MouseEvent.MOUSE_OVER,onOverHandle);	
				btn.removeEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
			}
			super.dispose();
		}
		
		
		override protected function updateUI():void
		{
			
			
			var w:Number = 0;
			var itew:Number = (trueHeight-(vspace*(_data.length-1))) / _data.length;
			
			var currentBtn:ExtendButton;
			
			for (var j:int = 0; j < btnArr.length; j++) 
			{
				currentBtn=btnArr[j];
				currentBtn.width = 33;			
				currentBtn.height = itew;	
				
				currentBtn.y = w;
				currentBtn.x = tx;
				
				
				w += currentBtn.height+_vspace;
				
				if(selectButton(currentBtn)){
					if(currentBtn.parent){						
						setChildIndex(currentBtn,numChildren-1);
					}
					currentBtn.x = 0;
					
					currentBtn.buttonLabel.alpha = 1;
					currentBtn.buttonLabel.x = 11;
				}
				
				
				
			}
			
			
			/*if(_data.length==1){
				var one:ExtendButton = createMidButton();
				one.width = 33;
				one.height = 116;	
				one.label = _data[0];
				
				addChild(one);
				btnArr.push(one);
				setButonStyle(one);
				return;
			}else{
				var left:ExtendButton = createLeftButton();
				left.width = 33;			
				left.height = 116;		
				left.label = _data[0];	
				
				left.x = tx;
				
				addChild(left);			
				left.index = 0;
				w = left.height-_vspace;
				btnArr.push(left);
				setButonStyle(left);
			}					
			
			if(_data.length==2){
				
				var right:ExtendButton =  createRightButton();
				
				right.width =33;
				right.height =116;	
				right.label = _data[1];		
				
				addChild(right);
				right.y = w;
				right.x = tx;
				right.index=1;
				btnArr.push(right);
				setButonStyle(right);
				return;
			}
			
			for(var i:int=1;i<_data.length-1;i++){
				
				var mid:ExtendButton = createMidButton();
				mid.width = 33;
				mid.height = 116;	
				mid.label = _data[i];
				
				mid.index = i;				
				addChild(mid);
				mid.x = tx;
				mid.y =w;
				w +=  mid.height-_vspace;
				btnArr.push(mid);
				setButonStyle(mid);
				
			}	
			
			if(_data.length>0){
				
				var right_a:ExtendButton =  createRightButton();
				right_a.width = 33;
				right_a.height = 116;		
				right_a.label = _data[data.length-1];		
				
				addChild(right_a);
				
				right_a.y = w;
				right_a.x = tx;
				right_a.index = _data.length-1;
				btnArr.push(right_a);	
				setButonStyle(right_a);
			}*/
			
			
			//this.changeTrueSize(33,(116*btnArr.length)-(_vspace*(btnArr.length-1)));
			
			maskMC.graphics.clear();
			maskMC.graphics.beginFill(0xff0000);
			maskMC.graphics.drawRect(-100,-50,33+100,trueHeight+100);
			maskMC.graphics.endFill();
			
		}
		
		override protected function setButonStyle(btn:ExtendButton):void
		{
			btn.buttonLabel.alpha = 0.5;
			
			super.setButonStyle(btn);
			btn.addEventListener(MouseEvent.MOUSE_OVER,onOverHandle);	
			btn.addEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
			
			btn.filters = [new GlowFilter(0x000000,1,8,20,0.4,BitmapFilterQuality.HIGH)];
			btn.buttonLabel.x = 8;
			
		}
		
		protected function onOutHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var extenBtn:SideExtendButton = event.currentTarget as SideExtendButton;
			if(extenBtn){
				if (extenBtn.select==false) 
				{					
					extenBtn.x = tx;
					extenBtn.buttonLabel.alpha = 0.5;
					extenBtn.buttonLabel.x = 8;
					
				}
			}
		}
		
		protected function onOverHandle(event:MouseEvent):void
		{
			//trace(event.target,event.currentTarget);
			var extenBtn:SideExtendButton = event.currentTarget as SideExtendButton;
			if(extenBtn){
				extenBtn.x = 0;
				extenBtn.buttonLabel.alpha = 1;
				extenBtn.buttonLabel.x = 11;
			}
		}		
		
		override protected function removeEvent(btn:ExtendButton):void
		{
			// TODO Auto Generated method stub
			super.removeEvent(btn);
			btn.removeEventListener(MouseEvent.MOUSE_DOWN,onClickHandle);
			btn.removeEventListener(MouseEvent.MOUSE_OVER,onOverHandle);	
			btn.removeEventListener(MouseEvent.MOUSE_OUT,onOutHandler);
		}		
				
		override protected function createLeftButton():ExtendButton
		{
			
			return new SideExtendButton(new TabButton_left_left_up,new TabButton_left_left_over,new TabButton_left_left_down);
		}
		
		override protected function createMidButton():ExtendButton
		{
			// TODO Auto Generated method stub
			return new SideExtendButton(new TabButton_left_mid_up,new TabButton_left_mid_over,new TabButton_left_mid_down);
		}
		
		override protected function createRightButton():ExtendButton
		{
			// TODO Auto Generated method stub
			return new SideExtendButton(new TabButton_left_right_up,new TabButton_left_right_over,new TabButton_left_right_down);
		}
		
		
	}
}