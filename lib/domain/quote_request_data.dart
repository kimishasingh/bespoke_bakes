class QuoteRequestData {
  String occasion;
  String itemType;
  String cakeFlavour;
  String icingType;
  String icingFlavour;
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

  QuoteRequestData({
    required this.occasion,
    required this.itemType,
    required this.cakeFlavour,
    required this.icingType,
    required this.icingFlavour,
    required this.cakeSize,
    required this.quantity,
    required this.dateTimeRequired,
    required this.deliveryOption,
    required this.budget,
  });
}
