use MDBHobby
show collections 

var myCollections = db.getCollectionNames()
for(var i = 0; i < myCollections.length; i++){
    var col = db.getCollection(myCollections[i]);
    if(col.count() == 0) {
        print(myCollections[i]);
    }
}

