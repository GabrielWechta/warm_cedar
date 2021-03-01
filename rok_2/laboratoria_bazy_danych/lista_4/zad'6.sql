db.zwierzeta.aggregate([
    {
        $lookup: {
            from: "osoba",
            localField: "type_name",
            foreignField: "pet.type",
            as: "cloned"
        }
    },
    {
        $match: {
            "cloned": {$ne: []}
        }
    }
])
