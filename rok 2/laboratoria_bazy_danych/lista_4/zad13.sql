db.osoba.find(
    {
        //intrests: '5 commandment'
    }, 
    {
        _id: 0,
        age: 0,
        height: 0,
        intrests: 0,
        pet: 0
    }).sort({ age: 1 })
