class QuoteRequestData {
  String occasion;
  String itemType;
  String cakeFlavour;
  String icingType;
  String icingFlavour;
  String icingColour;
  String cakeSize;
  int? numOfTiers;
  String? description;
  int quantity;
  String? genderIndicator;
  DateTime dateTimeRequired;
  double? locationLongitude;
  double? locationLatitude;
  String deliveryOption;
  String budget;
  String? additionalInfo;
  int userId;
  int bundleId;

  QuoteRequestData(
      {required this.occasion,
      required this.itemType,
      required this.cakeFlavour,
      required this.icingType,
      required this.icingFlavour,
      required this.icingColour,
      required this.cakeSize,
      required this.quantity,
      required this.dateTimeRequired,
      required this.deliveryOption,
      required this.budget,
      required this.userId,
      required this.bundleId});

  Map<String, dynamic> toJson() {
    return {
      'occasion': occasion,
      'itemType': itemType,
      'cakeFlavour': cakeFlavour,
      'icingType': icingType,
      'icingFlavour': icingFlavour,
      'icingColour': icingColour,
      'cakeSize': cakeSize,
      'numOfTiers': numOfTiers,
      'description': description,
      'quantity': quantity,
      'genderIndicator': genderIndicator,
      'dateTimeRequired': dateTimeRequired.toIso8601String(),
      'locationLongitude': locationLongitude,
      'locationLatitude': locationLatitude,
      'deliveryOption': deliveryOption,
      'budget': budget,
      'additionalInfo': additionalInfo,
      'userId': userId,
      'bundleId': bundleId
    };
  }

  factory QuoteRequestData.fromJson(Map<String, dynamic> json) {
    QuoteRequestData obj = QuoteRequestData(
        occasion: json['occasion'] as String,
        itemType: json['itemType'] as String,
        cakeFlavour: json['cakeFlavour'] as String,
        icingType: json['icingType'] as String,
        icingFlavour: json['icingFlavour'] as String,
        icingColour: json['icingColour'] as String,
        cakeSize: json['cakeSize'] as String,
        quantity: json['quantity'] as int,
        dateTimeRequired: DateTime.parse(json['dateTimeRequired']),
        deliveryOption: json['deliveryOption'] as String,
        budget: json['budget'] as String,
        userId: 0,
        bundleId: json['bundleId'] as int);

    obj.numOfTiers = json['numOfTiers'] as int?;
    obj.description = json['description'] as String?;
    obj.genderIndicator = json['genderIndicator'] as String?;
    obj.locationLongitude = json['locationLongitude'] as double?;
    obj.locationLatitude = json['locationLatitude'] as double?;
    obj.additionalInfo = json['additionalInfo'] as String?;

    return obj;
  }
}
