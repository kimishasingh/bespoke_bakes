import 'package:bespoke_bakes/domain/image_data.dart';
import 'package:bespoke_bakes/domain/location_data.dart';
import 'package:bespoke_bakes/domain/login_data.dart';
import 'package:bespoke_bakes/domain/quote_request_data.dart';
import 'package:bespoke_bakes/domain/user_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'domain/quote_response_data.dart';

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

  Future<List<LocationData>> getLocationValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/admin/location";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Iterable decodeJson = jsonDecode(response.body);
      return decodeJson.map((item) => LocationData.fromJson(item)).toList();
    } else {
      throw response.statusCode;
    }
  }

  Future<List<QuoteRequestData>> getQuoteRequests() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/admin/quote-request";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Iterable decodeJson = jsonDecode(response.body);
      return decodeJson.map((item) => QuoteRequestData.fromJson(item)).toList();
    } else {
      throw response.statusCode;
    }
  }

  Future<QuoteRequestData> getQuoteRequestById(int quoteRequestId) async {
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/admin/quote-request/$quoteRequestId";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return QuoteRequestData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw response.statusCode;
    }
  }

  Future<QuoteRequestData?> createQuoteRequest(
      QuoteRequestData quoteRequestData) async {
    final response = await http.post(
      Uri.parse('https://bespokebakes.azurewebsites.net/admin/quote-request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(quoteRequestData),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 OK response,
      // then parse the JSON.
      return QuoteRequestData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server returned a 404 response,
      // then throw an exception.
      return null;
    }
  }

  Future<QuoteResponseData?> createQuoteResponse(
      QuoteResponseData quoteResponseData) async {
    print(jsonEncode(quoteResponseData));
    final response = await http.post(
      Uri.parse('https://bespokebakes.azurewebsites.net/admin/quote-response'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(quoteResponseData),
    );

    print(response.statusCode);
    if (response.statusCode == 201) {
      // If the server did return a 201 OK response,
      // then parse the JSON.
      return QuoteResponseData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server returned a 404 response,
      // then throw an exception.
      return null;
    }
  }

  Future<QuoteResponseData?> updateQuoteResponse(
      QuoteResponseData quoteResponseData) async {
    print(jsonEncode(quoteResponseData));
    final response = await http.put(
      Uri.parse('https://bespokebakes.azurewebsites.net/admin/quote-response'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(quoteResponseData),
    );

    print(response.statusCode);
    if (response.statusCode == 201) {
      // If the server did return a 201 OK response,
      // then parse the JSON.
      return QuoteResponseData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server returned a 404 response,
      // then throw an exception.
      return null;
    }
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
      return UserData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server returned a 404 response,
      // then throw an exception.
      return UserData(userId: 0, name: '', surname: '', emailAddress: '');
    }
  }

  Future<ImageData?> getImage(ImageType imageType, String matchingId) async {
    String imageTypeString = imageType.description;

    final response = await http.get(
      Uri.parse(
          'https://bespokebakes.azurewebsites.net/admin/image/type$imageTypeString/id/$matchingId'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ImageData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server returned a 404 response,
      // then throw an exception.
      return null;
    }
  }
}
