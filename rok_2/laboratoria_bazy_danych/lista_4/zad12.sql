db.osoba.updateMany(
    {"nationality.true_country": "Russian Federation" },
		{
		    $set: {nationality: 'rosyjskie'}
		})
db.osoba.find({
    nationality: "rosyjskie"
})
