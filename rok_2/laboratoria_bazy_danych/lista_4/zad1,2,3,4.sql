use MDBHobby

db.createCollection("zwierzeta");
db.createCollection("sport" , { capped: true, size: 5242880, max: 5000} );
db.createCollection("osoba")

###################################SPORT##########################################
[
  '{{repeat(10)}}',
  {
    _id: '{{objectId()}}',
    index: '{{index()}}',
    sport_name: 'Badminton v{{integer(0, 22)}}',
    place: function (tags) {
 	var where = ['inside', 'outside', ['inside', 'outside']];
      return where[tags.integer(0, where.length - 1)];
    },
    multiplicity: function (tags) {
 	var types = ['singiel', 'debel', ['singiel', 'debel']];
      return types[tags.integer(0, types.length - 1)];
  	}
  }
]
###############################################################################
[
  {
    "index": 10,
    "sport_name": "Squash",
    "place": "inside",
    "multiplicity": "singiel",
    "for_true_men": true
  }
]
####################################ZWIERZETA############################################
[
  '{{repeat(10)}}',
  {
    index: '{{index()}}',
    type_name: 'Dolly the Sheep v{{integer(0, 22)}}',
    race_name: function (tags) {
      return 'Asino Ignito ' + this.type_name;
    },
    min_weight: '{{integer(1,9)}}',
    max_weight: '{{integer(10,1120)}}',
    color_range: function (tags) {
 	var colors = [['black', 'white'], ['pink', 'red'],['colorful', 'notcolorful'], ['white_clean','grey_dirty']];
      return colors[tags.integer(0, colors.length - 1)];
    },
    expected_life: '{{integer(10,110)}}'
  	}
]
#####################################ZWIERZE Z NIEZDECYDOWANA RASA############################################
[
  {
    "index": 10,
    "type_name": " Smallus Birdus",
    "race_name": [
      {
        "type": "Smallus Birdus 13"
      },
      {
        "type": "Smallus Birdus 3"
      }
    ],
    "min_weight": 9,
    "max_weight": 297,
    "color_range": [
      "white_clean",
      "grey_dirty"
    ],
    "expected_life": 38
  }
]
##################################OSOBA###########################################
[
  '{{repeat(10)}}',
  {
    name: '{{firstName()}}',
    last_name: '{{surname()}}',
    age: '{{integer(18,81)}}',
    height: '{{integer(160,200)}}',
    intrests: ['{{integer(1,10)}} commandment', 'drawing Karnaugh table for {{integer(20,30)}} vars'],
    nationality: '{{country()}}',
    //nationality: ['{{country()}}' ,'{{country()}}' ]
    //nationality: [
    // {
    //    state: '{{state()}}',
    //    true_country: 'USA'
    //  }
    //]
    pet: [
      {
        pet_name: '{{surname()}}',
        type: 'Dolly the Sheep v0'
      }
    ]
  }
]
