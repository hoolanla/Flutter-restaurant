class Person {
  final String id;
  final String name;
  final int age;
  final List<String> places;
  final List<Images> images;
  final Address address;

  Person(
      {this.id, this.name, this.age, this.places, this.images, this.address});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      places: parsePlaces(json['places']), // json['places']);
      images: parseImages(json),
      address: Address.fromJson(
        json['address'],
      ),
    );
  }

  static List<String> parsePlaces(placesJson) {
    List<String> placesList = new List<String>.from(placesJson);
    return placesList;
  }

  static List<Images> parseImages(imagesJson) {
    var list = imagesJson['images'] as List;
    List<Images> imagesList =
    list.map((data) => Images.fromJson(data)).toList();
    return imagesList;
  }
}

class Images {
  final int id;
  final String name;

  Images({this.id, this.name});

  factory Images.fromJson(Map<String, dynamic> parsedJson) {
    return Images(id: parsedJson['id'], name: parsedJson['name']);
  }
}

class Details {
  final int houseNo;
  final String town;

  Details({this.houseNo, this.town});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      houseNo: json['house_no'] as int,
      town: json['town'],
    );
  }
}

class Address {
  final String streetNo;
  final Details details;

  Address({this.streetNo, this.details});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        streetNo: json['street_no'] as String,
        details: Details.fromJson(
          json['details'],
        ));
  }
}

class Album {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Album({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
