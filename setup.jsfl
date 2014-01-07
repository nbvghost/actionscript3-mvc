var library = fl.getDocumentDOM().library;
var items=library.items;
var itemsCount=items.length; 

fl.outputPanel.clear();


 //var fileURL= fl.browseForFolderURL("请选择导入文件夹");       
   // if(fileURL) 
   exteswc();   
function exteswc(fileURL){
for(var i=0;i< itemsCount;i++){
	
		//fl.outputPanel.trace(fl.getDocumentDOM().library.items[i]);
		
		var ddd = fl.getDocumentDOM().library.items[i];
		
		if(ddd.symbolType=="movie clip"){
			if(ddd.name!="Component Assets/_private/Component_avatar"){
				fl.getDocumentDOM().library.items[i].convertToCompiledClip();
				//fl.getDocumentDOM().library.items[i].exportSWC(fileURL+"/"+ddd.name+".swc");
				
			}
			//fl.outputPanel.trace(ddd.symbolType);	
			//fl.getDocumentDOM().library.items[i].convertToCompiledClip();
		}
		//fl.outputPanel.trace(ddd.name);
		//fl.outputPanel.trace(ddd.symbolType);
		//fl.getDocumentDOM().library.items[3].convertToCompiledClip();
		//fl.outputPanel.trace( fl.getDocumentDOM().selection.length);
	
	
	//library.setItemProperty('linkageExportForAS', true);
	//library.setItemProperty("linkageExportForRS",true);
	//library.setItemProperty("linkageURL","Skin.swf");
	//items[i].linkageURL("Skin.swf");
	//items[i].linkageURL ="Skin.swf";
	//fl.outputPanel.Console.out(items[i].getItemProperty("name"));
	//fl.outputPanel.Console.out(items[i].getData("linkageURL"));
	//fl.outputPanel.Console.out(items[i].linkageURL);
   
	
}
}