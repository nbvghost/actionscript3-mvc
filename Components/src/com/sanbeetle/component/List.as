package com.sanbeetle.component
{
	
	import com.sanbeetle.component.child.IListBox;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.skin.IListBoxBgB;
	
	public class List extends IListBox
	{
		private var _dataProvider:DataProvider;
	
		private var ivbar:IVScrollBar;		
		
		public function List(){
			
			super(new IListBoxBgB());			
			
			ivbar = new IVScrollBar;
			
			this._itemColor = "0xffffff";
			
		
			paddingRect.right =15+paddingRect.left;	
		}		
		override protected function createUI():void
		{
			this.addChild(ivbar);
			
			ivbar.source = this.content;
		
			super.createUI();
			
		}		
		override protected function updateUI():void
		{	
			//Console.out("components"+ivbar.visible)
			super.updateUI();			
			
			ivbar.y = paddingRect.top;
			ivbar.x = content.x+content.width;
			ivbar.height = trueHeight;
			
			if(ivbar.visible==false){
				paddingRect.right =paddingRect.left;	
				super.updateUI();
				this._background.height = content.height+paddingRect.top+paddingRect.buttom;
			}else{
				this._background.height = trueHeight+paddingRect.top+paddingRect.buttom;
			}					
			
			ivbar.upDisplayList();
		}
		
		
	}
}