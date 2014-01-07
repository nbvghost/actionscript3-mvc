var library = fl.getDocumentDOM().library;
var items=library.items;
var itemsCount=items.length; 

fl.outputPanel.clear();
//fl.getDocumentDOM().selectAll();
//fl.outputPanel.Console.out(fl.getDocumentDOM().library.renameItem("new name"));
for(var i=0;i< itemsCount;i++){
	fl.getDocumentDOM().library.items[i].linkageExportForRS = true;
	fl.getDocumentDOM().library.items[i].linkageURL = "TextLayoutSkin.swf";
	var names = fl.getDocumentDOM().library.items[i].name;
	//fl.getDocumentDOM().library.items[i].name=names+i;
	//fl.outputPanel.Console.out(names);
	
	var arr = names.split(" ");
	
	fl.getDocumentDOM().library.items[i].name=arr[0];
	
	//library.setItemProperty('linkageExportForAS', true);
	//library.setItemProperty("linkageExportForRS",true);
	//library.setItemProperty("linkageURL","Skin.swf");
	//items[i].linkageURL("Skin.swf");
	//items[i].linkageURL ="Skin.swf";
	//fl.outputPanel.Console.out(items[i].getItemProperty("name"));
	//fl.outputPanel.Console.out(items[i].getData("linkageURL"));
	//fl.outputPanel.Console.out(items[i].linkageURL);
   
	
}