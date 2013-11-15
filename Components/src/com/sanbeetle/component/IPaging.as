package com.sanbeetle.component
{
	
	import com.sanbeetle.component.child.IPagingSkin;
	import com.sanbeetle.core.FixedUIComponent;
	import com.sanbeetle.events.ControlEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name = "page_paging_event",type = "com.sanbeetle.events.ControlEvent")]
	public class IPaging extends FixedUIComponent
	{		
		private var content:IPagingSkin;
		
		private var total:int;
		private var paging:int = 20;
		private var currentIndex:int = 1;
		private var totalPageCount:int = 0;
		public function IPaging()
		{
			content = new IPagingSkin();
			//setTotal(500);
			//setPaging(20);
			//setdata();
		}		
		override protected function createUI():void
		{			
			
			//Console.out("components"+content);
			//content = IPagingSkin(getChildByName("content"));
			//Console.out("components"+content);
			this.addChild(content);
			
			//Console.out("components"+this.numChildren+"------------");
			/*content.per_mc = SimpleButton(this.getChildByName("per_mc"));
			
			content.top_mc = SimpleButton(getChildByName("top_mc"));
			
			content.last_mc = SimpleButton(getChildByName("last_mc"));
			
			content.next_mc = SimpleButton(getChildByName("next_mc"));
			
			content.pageindex_txt = TextField(getChildByName("pageindex_txt"));
			
			content.djy_txt = TextField(getChildByName("djy_txt")) ;*/
			
			//Console.out("components"+"components"+"sdfs");
			content.per_mc.addEventListener(MouseEvent.MOUSE_DOWN,onPerMouseHandler);
			content.top_mc.addEventListener(MouseEvent.MOUSE_DOWN,onTopMouseHandler);
			content.last_mc.addEventListener(MouseEvent.MOUSE_DOWN,onLastMouseHandler);
			content.next_mc.addEventListener(MouseEvent.MOUSE_DOWN,onNextMouseHandler);			
			//pageindex_com.addEventListener(TextEvent,onPageIndexHandler);
			content.pageindex_txt.addEventListener(Event.CHANGE,onPageIndexHandler);			
		}
		
		private function setDataDis():void
		{
			setdata();
			
			var datadd:Object = {"currentIndex":currentIndex,"totalPageCount":totalPageCount};
			var ite:ControlEvent = new ControlEvent(ControlEvent.PAGE_PAGING_EVENT,datadd);
			
			this.dispatchEvent(ite);
			//var eventssd:IEvent = new IEvent("dsfds");
			
			//Console.out("components"+new IEvent("dsfds"));
			//var ite:IEvent = new IEvent("dsfds");
			//Console.out("components"+ite);			
			//this.dispatchEvent(new IEvent("dsfds"));
		}
		private function setdata():void
		{
			if (currentIndex<1)
			{
				currentIndex = 1;
			}
			if (currentIndex>totalPageCount)
			{
				currentIndex = totalPageCount;
			}
			content.pageindex_txt.text = String(currentIndex);
			content.djy_txt.text = "第" + currentIndex + "页，共" + totalPageCount + "页";
		}
		
		protected function onPageIndexHandler(event:Event):void
		{
			//Console.out("components"+int(content.pageindex_txt.text));
			
			if (int(content.pageindex_txt.text)==0)
			{
				currentIndex = 1;
			}
			else
			{
				currentIndex = int(content.pageindex_txt.text);
			}
			
			setDataDis();
		}
		
		protected function onNextMouseHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			currentIndex++;
			setDataDis();
		}
		
		protected function onLastMouseHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			currentIndex = totalPageCount;
			setDataDis();
			
		}
		
		protected function onTopMouseHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			currentIndex = 1;
			setDataDis();
		}
		/**
		 * 设置当前页
		 * @param page
		 * 
		 */
		public function setCurrentPage(page:int):void{
			currentIndex = page;
			setDataDis();
		}
		protected function onPerMouseHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			currentIndex--;
			setDataDis();
		}
		/**
		 * 设置总的条数 
		 * @param total
		 * 
		 */
		public function setTotal(total:int):void
		{
			this.total = total;
			if ((total%paging)==0)
			{
				totalPageCount = (total / paging);
				
			}
			else
			{
				totalPageCount =(int(total/paging)+1);
			}
			setdata();
		}
		/**
		 * 显示第一页多少项。默认20 
		 * @param paging
		 * 
		 */
		public function setPaging(paging:int):void
		{
			this.paging = paging;
			if ((total%paging)==0)
			{
				totalPageCount = (total / paging);
				
			}
			else
			{
				totalPageCount =(int(total/paging)+1);
			}
			setdata();
		}
	}
	
}