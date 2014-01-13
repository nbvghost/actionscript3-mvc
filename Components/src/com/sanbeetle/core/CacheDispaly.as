package com.sanbeetle.core
{
	import com.sanbeetle.component.IToolTip;
	import com.sanbeetle.interfaces.IStage;
	
	import flash.utils.getDefinitionByName;

	public class CacheDispaly
	{
		private static var cache:Object = new Object();
		
		private static var _iTooltip:IToolTip;
		
		public function CacheDispaly()
		{
				
		}	

		public static function get iTooltip():IToolTip
		{
			if(_iTooltip==null){
				_iTooltip = new IToolTip();
			}
			return _iTooltip;
		}
		
		private static function createTarget(className:String):Object{
			if(cache[className]==undefined){
				cache[className] = new Vector.<Object>();
			}			
			
			var arr:Vector.<Object> =cache[className];
			
			var ClassTar:Class = getDefinitionByName(className) as Class;
			
			var te:Object = new ClassTar();
			
			arr.push(te);
			return te;
		}
		private static var seachIndex:int=0;
		public static function get cachePool():Object{
			return cache;
		}
		public static function getTarget(className:String):Object{			
			var arr:Vector.<Object> = cache[className];
			
			var tempArr:Vector.<int> = new Vector.<int>();
			
			//if(arr!=null){
			if(arr!=null){
				var ite:IStage;
				var cuindex:int = 0;
				
				for(var i:int=seachIndex;i<arr.length;i++){
					ite = arr[i] as IStage;
					if(ite.haveStage==false){
						//seachIndex= i;
						return ite;
					}else{
						ite =null;
					}
					
				}
				
				
				if(ite==null){
					return createTarget(className);
				}else{
					return ite;
				}
				
			}else{
				/*cache[className] = new Array;
				arr =cache[className];
				
				var ClassTar:Class = getDefinitionByName(className) as Class;
				
				var te:Object = new ClassTar();
				
				arr.push(te);*/
				return createTarget(className);
			}	
			
			
		}
	}
}