import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class QuoteRequestData {
  String occasion;
  String itemType;
  // String cakeFlavour;
  // String icingType;
  // String icingFlavour;
  // String cakeSize;
  // int numOfTiers;
  // String description;
  // int quantity;
  // String genderIndicator;
  // DateTime dateTimeRequired;
  // double locationLongitude;
  // double locationLatitude;
  // String deliveryOption;
  // String budget;
  // String additionalInfo;

  QuoteRequestData({required this.occasion, required this.itemType});
}

class QuoteRequestPage extends StatefulWidget {
  const QuoteRequestPage({super.key, required this.title});

  final String title;

  @override
  State<QuoteRequestPage> createState() => _QuoteRequestPageState();
}

class _QuoteRequestPageState extends State<QuoteRequestPage> {
  String? selectedOccasion;

  final _formKey = GlobalKey<FormState>();

  Future<List<String>> getBudgetValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/lookup/budget";

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
    var baseUrl = "https://bespokebakes.azurewebsites.net/lookup/cake-flavour";

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
    var baseUrl = "https://bespokebakes.azurewebsites.net/lookup/cake-size";

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
        "https://bespokebakes.azurewebsites.net/lookup/delivery-option";

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
        "https://bespokebakes.azurewebsites.net/lookup/gender-indicator";

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
    var baseUrl = "https://bespokebakes.azurewebsites.net/lookup/icing-flavour";

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
    var baseUrl = "https://bespokebakes.azurewebsites.net/lookup/icing-type";

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
    var baseUrl = "https://bespokebakes.azurewebsites.net/lookup/item-type";

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
    var baseUrl = "https://bespokebakes.azurewebsites.net/lookup/occasion";

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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Request Form"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: getFormWidget(),
            )));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(
      FutureBuilder<List<String>>(
        future: getOccasionValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButton(
              style: const TextStyle(fontSize: 20, color: Colors.black),
              // Initial Value
              value: selectedOccasion ?? data[0],

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: data.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  selectedOccasion = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );

    void onPressedSubmit() {
      _formKey.currentState?.save();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Form Submitted')));
    }

    formWidget.add(ElevatedButton(
        onPressed: onPressedSubmit, child: const Text('Submit Request')));

    return formWidget;
  }
}
