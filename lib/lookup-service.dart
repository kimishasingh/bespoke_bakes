import 'package:bespoke_bakes/quote-request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LookupService {
  Future<List<String>> getBudgetValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/budget";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getCakeFlavourValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/cake-flavour";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getCakeSizeValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/cake-size";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getDeliveryOptionValues() async {
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/delivery-option";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getGenderIndicatorValues() async {
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/gender-indicator";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getIcingFlavourValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/icing-flavour";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getIcingTypeValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/icing-type";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getItemTypeValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/item-type";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getOccasionValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/occasion";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<http.Response> createQuoteRequest(QuoteRequestData quoteRequestData) {
    return http.post(
      Uri.parse('https://bespokebakes.azurewebsites.net/quote-request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(quoteRequestData),
    );
  }
}