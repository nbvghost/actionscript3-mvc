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
	
	import flash.events.MouseEvent;
	
	/**
	 *
	 *@author sixf
	 */
	public class ITabSideButton extends ITabButton
	{
		
		
		
		
		
		public function ITabSideButton()
		{
			super();	
			
			
			
		}	
		
		override public function set childData(value:Array):void
		{
			
		}	
		
		override public function createUI():void
		{
			updateUI();
		}
		
		
		override public function updateUI():void
		{
			for each(var btn:ExtendButton in  btnArr){
				if(btn.parent!=null){
					
					btn.parent.removeChild(btn);
				}
				btn.removeEventListener(MouseEvent.MOUSE_DOWN,onClickHandle);
			}
			
			btnArr.splice(0,btnArr.length);		
			if(_data.length==0){
				return;
			}
			
			var w:Number = 0;
			var itew:Number = trueHeight / _data.length;		
			//Log.out("components"+itew);
			
			if(_data.length==1){
				//var one:ExtendButton = new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);
				var one:ExtendButton = createMidButton();
				one.width = trueWidth;			
				one.height = itew;	
				one.label = _data[0];
				
				addChild(one);
				btnArr.push(one);
				setButonStyle(one);
				return;
			}else{
				//var left:ExtendButton = new ExtendButton(new TabButton_left_up_gray(),new TabButton_left_over_gray,new TabButton_left_down_gray);		
				var left:ExtendButton = createLeftButton();
				left.width = trueWidth;			
				left.height = itew;		
				left.label = _data[0];	
				
				addChild(left);			
				left.index = 0;
				w = left.height-1;
				btnArr.push(left);
				setButonStyle(left);
			}					
			
			if(_data.length==2){
				
				//var right:ExtendButton = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);
				var right:ExtendButton =  createRightButton();
				
				right.width = trueWidth;
				right.height =itew;	
				right.label = _data[1];		
				
				addChild(right);
				right.y = w;
				right.x = 0;
				right.index=1;
				btnArr.push(right);
				setButonStyle(right);
				return;
			}
			
			for(var i:int=1;i<_data.length-1;i++){
				
				//var mid:ExtendButton = new ExtendButton(new TabButton_mid_up_gray,new TabButton_mid_over_gray,new TabButton_mid_down_gray);	
				var mid:ExtendButton = createMidButton();
				mid.width = trueWidth;
				mid.height = itew;	
				mid.label = _data[i];
				
				mid.index = i;				
				addChild(mid);
				mid.x = 0;
				mid.y =w;
				//Log.out("components"+w);
				w +=  mid.height-1;
				btnArr.push(mid);
				setButonStyle(mid);
				
			}	
			
			//Console.out("components"+"components"+"-----------------------"+_data.length);			
			if(_data.length>0){
				
				//var right_a:ExtendButton = new ExtendButton(new TabButton_right_up_gray,new TabButton_right_over_gray,new TabButton_right_down_gray);		
				var right_a:ExtendButton =  createRightButton();
				right_a.width = trueWidth;
				right_a.height = itew;		
				right_a.label = _data[data.length-1];		
				
				addChild(right_a);
				right_a.y = w;
				right_a.x = 0;
				right_a.index = _data.length-1;
				btnArr.push(right_a);	
				setButonStyle(right_a);
			}
		}
		
		override protected function setButonStyle(btn:ExtendButton):void
		{
			// TODO Auto Generated method stub
			super.setButonStyle(btn);
			
			
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