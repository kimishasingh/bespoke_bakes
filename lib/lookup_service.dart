import 'package:bespoke_bakes/domain/login_data.dart';
import 'package:bespoke_bakes/domain/quote_request_data.dart';
import 'package:bespoke_bakes/domain/user_data.dart';
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
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/cake-flavour";

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
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/cake-size";

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
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/icing-flavour";

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
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/icing-type";

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
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/item-type";

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
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/api/v1/lookup/occasion";

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

  Future<UserData> login(LoginData loginData) async {
    final response = await http.post(
      Uri.parse('https://bespokebakes.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginData),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return UserData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server returned a 404 response,
      // then throw an exception.
      return UserData(userId: 0, name: '', surname: '');
    }
  }
}
