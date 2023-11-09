class ImageData {
  int id;
  String imageType;
  String image;

  ImageData({required this.id, required this.imageType, required this.image});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
        id: json['id'] as int,
        imageType: json['imageType'] as String,
        image: json['image'] as String);
  }
}

enum ImageType {
  profilePicture(description: "PROFILE_PICTURE");

  const ImageType({required this.description});

  final String description;
}