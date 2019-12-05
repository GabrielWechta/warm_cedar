
db.osoba.updateMany(
    {nationality: "Russian Federation" },
		{
		    $set: {nationality: 'rosyjskie'}
		})
db.osoba.find({
    nationality: "rosyjskie"
})

