function add_linkage(doc){ 

	var library=doc.library;
	var items=library.items;
	var items_length=items.length;
	var includes='';

	for( var h = 0; h < items_length; h++){
		var item=items[h];
		if(item.itemType=='sound'){
			
			//extract class name from the item name
			var class_name=item.name.substr(item.name.lastIndexOf('/')+1);
			//remove points and spaces
			class_name=class_name.split('.wav').join('').split('.mp3').join('');
				
			//sum and set it up
			item.linkageExportForAS=true;
			item.linkageClassName=class_name;
			item.linkageBaseClass='flash.media.Sound';
			includes+='addSound('+class_name+');\n';
		}
	}
	fl.getDocumentDOM().getTimeline().layers[0].frames[0].actionScript=includes;
}

add_linkage(fl.getDocumentDOM());