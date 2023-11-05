class QuoteResponseData {
  bool active;
  int bundleId;
  int bundleTotal;
  int? discountAppliedPercentage;
  bool quoteAccepted;
  int quoteRequestId;
  int quoteRequestTotal;
//don't we need user id of baker?

  QuoteResponseData({
    required this.active,
    required this.bundleId,
    required this.bundleTotal,
    required this.quoteAccepted,
    required this.quoteRequestId,
    required this.quoteRequestTotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'bundleId': bundleId,
      'bundleTotal': bundleTotal,
      'discountAppliedPercentage': discountAppliedPercentage,
      'quoteAccepted': quoteAccepted,
      'quoteRequestId': quoteRequestId,
      'quoteRequestTotal': quoteRequestTotal
    };
  }

  factory QuoteResponseData.fromJson(Map<String, dynamic> json) {
    QuoteResponseData obj = QuoteResponseData(
        active: json['active'] as bool,
        bundleId: json['bundleId'] as int,
        bundleTotal: json['bundleTotal'] as int,
        quoteAccepted: json['quoteAccepted'] as bool,
        quoteRequestId: json['quoteRequestId'] as int,
        quoteRequestTotal: json['quoteRequestTotal'] as int);

    obj.discountAppliedPercentage = json['discountAppliedPercentage'] as int?;


    return obj;
  }
}
