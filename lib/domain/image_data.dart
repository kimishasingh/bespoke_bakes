class ImageData {
  int id;
  String imageType;
  String image;
  int matchingId;

  ImageData({
    required this.id,
    required this.imageType,
    required this.image,
    required this.matchingId,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'] as int,
      imageType: ImageType.values
          .firstWhere((element) =>
              element.dbDescription == (json['imageType'] as String))
          .description,
      image: json['image'] as String,
      matchingId: json['matchingId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageType': imageType,
      'image': image,
      'matchingId': matchingId,
    };
  }
}

enum ImageType {
  profilePicture(description: "PROFILE_PICTURE", dbDescription: "Profile Pic"),
  quoteRequest(description: "QUOTE_REQUEST", dbDescription: "Quote request");

  const ImageType({
    required this.description,
    required this.dbDescription,
  });

  final String description;
  final String dbDescription;
}
