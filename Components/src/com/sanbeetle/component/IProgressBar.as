package com.sanbeetle.component {
	
	import com.sanbeetle.core.TextBox;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IProgressBarSkinBg;
	import com.sanbeetle.skin.IProgressBarSkinProgress;
	
	
	public class IProgressBar extends UIComponent {
		
		private var bgSkin:IProgressBarSkinBg;
		private var progressSKin:IProgressBarSkinProgress;		
		private var nameTxt:TextBox;
		private var progressTxt:TextBox;		
		private var _showLabel:Boolean =true;		
		private var _label:String="名称";
		private var _progress:Number = 0.5;
		
		public function IProgressBar() {
			bgSkin = new IProgressBarSkinBg();
			progressSKin = new IProgressBarSkinProgress();
			
			nameTxt =new TextBox();			
			nameTxt.multiline = false;
			//nameTxt.autoSize = TextFieldAutoSize.LEFT;
			nameTxt.autoBound = true;
			//nameTxt.border =false;
			nameTxt.fontSize="10";
			nameTxt.color ="0x373b40";
			nameTxt.bold =true;
			//nameTxt.leading = 0;
			
			progressTxt = new TextBox();
			progressTxt.autoBound = true;
			progressTxt.multiline = nameTxt.multiline;		
			//progressTxt.border =nameTxt.border;
			progressTxt.fontSize=nameTxt.fontSize;
			progressTxt.bold =nameTxt.bold;
			//progressTxt.leading = nameTxt.leading;
			progressTxt.color =nameTxt.color;
			progressTxt.y = nameTxt.y;
			
			progressTxt.text="0%";
			
		}		
		[Inspectable(defaultValue=true)]
		public function get showLabel():Boolean
		{
			return _showLabel;
		}

		public function set showLabel(value:Boolean):void
		{
			if(_showLabel!=value){
				_showLabel = value;
				this.updateUI();
			}
			
		}		
		[Inspectable(defaultValue=0.5)]
		public function get progress():Number
		{
			return _progress;
		}

		public function set progress(value:Number):void
		{			
			if(_progress!=value){
				_progress = value;
				this.updateUI();
			}
		}
		[Inspectable(defaultValue="名称")]
		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			if(_label!=value){
				_label = value;
				this.updateUI();
			}			
		}	
		
		override public function createUI():void
		{
			this.addChild(bgSkin);
			this.addChild(progressSKin);
			
			bgSkin.y = Math.round(nameTxt.y+nameTxt.height);
			progressSKin.y = Math.round(nameTxt.y+nameTxt.height);
			
			this.addChild(nameTxt);
			this.addChild(progressTxt);
			
			updateUI();
		}		
		override protected function updateUI():void
		{
			
			
			bgSkin.width = Math.round(trueWidth);
			
			if(_progress>1){
				_progress = 1;
			}
			if(_progress<0){
				_progress = 0;
			}
			
			this.progressSKin.width = Math.round(this.trueWidth * _progress);
			
			nameTxt.text = _label;		
			
			progressTxt.text = int(_progress*100)+"%";
			
			progressTxt.x = trueWidth-progressTxt.width;
			
			if(_showLabel==false){
				progressTxt.visible=false;
				nameTxt.visible = false;
				bgSkin.y = 0;
				progressSKin.y = 0;
			}else{
				progressTxt.visible=true;
				nameTxt.visible = true;
				bgSkin.y = Math.round(nameTxt.y+nameTxt.height);
				progressSKin.y = Math.round(nameTxt.y+nameTxt.height);
			}
			
		}
		
	}
	
}
