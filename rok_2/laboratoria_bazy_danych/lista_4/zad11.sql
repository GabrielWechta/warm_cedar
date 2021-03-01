db.osoba.updateMany(
    {intrests: {$all: ["9 commandment", "drawing Karnaugh table for 27 vars"] } },
		{
		    $set: {intrests: 'triatlon'}
		})
