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
      imageType: json['imageType'] as String,
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
  profilePicture(description: "PROFILE_PICTURE"),
  quoteRequest(description: "QUOTE_REQUEST");

  const ImageType({required this.description});

  final String description;
}
