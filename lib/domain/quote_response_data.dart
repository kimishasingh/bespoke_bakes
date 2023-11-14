class QuoteResponseData {
  int id;
  bool active;
  int bundleId;
  int bundleTotal;
  int discountAppliedPercentage;
  bool quoteAccepted;
  int quoteRequestId;
  int quoteRequestTotal;
  int userId;

  QuoteResponseData(
      {
        required this.id,
        required this.active,
      required this.bundleId,
      required this.bundleTotal,
      required this.discountAppliedPercentage,
      required this.quoteAccepted,
      required this.quoteRequestId,
      required this.quoteRequestTotal,
      required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'bundleId': bundleId,
      'bundleTotal': bundleTotal,
      'discountAppliedPercentage': discountAppliedPercentage,
      'quoteAccepted': quoteAccepted,
      'quoteRequestId': quoteRequestId,
      'quoteRequestTotal': quoteRequestTotal,
      'userId': userId
    };
  }

  factory QuoteResponseData.fromJson(Map<String, dynamic> json) {
    QuoteResponseData obj = QuoteResponseData(
        id: json['id'] as int,
        active: json['active'] as bool,
        bundleId: json['bundleId'] as int,
        bundleTotal: json['bundleTotal'] as int,
        discountAppliedPercentage: json['discountAppliedPercentage'] as int,
        quoteAccepted: json['quoteAccepted'] as bool,
        quoteRequestId: json['quoteRequestId'] as int,
        quoteRequestTotal: json['quoteRequestTotal'] as int,
        userId: json['userId'] as int);

    return obj;
  }
}
