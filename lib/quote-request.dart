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
   QuoteRequestPage({super.key, required this.title, required this.occasion});

  final String title;
  String occasion;

  @override
  State<QuoteRequestPage> createState() => _QuoteRequestPageState();
}

class _QuoteRequestPageState extends State<QuoteRequestPage> {
  String? selectedOccasion;
  String? selectedBudget;
  String? selectedCakeFlavour;
  String? selectedCakeSize;
  String? selectedDeliveryOption;
  String? selectedGenderIndicator;
  String? selectedIcingFlavour;
  String? selectedIcingType;
  String? selectedItemType;

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();


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
      key:scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          leading: BackButton(),
          title: Text('Tell us more', style: TextStyle( fontFamily: 'Urbanist', color: Colors.black, fontWeight: FontWeight.w400 )),
          backgroundColor: Colors.white,
             ),
        body:
            SingleChildScrollView(
              child: Column(
                children:   [
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(),
                      child:  Form(
                          key: _formKey,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: getFormWidget(),
                          )
                      )
                    ),
                  ),
                ],
              ),
            )

            );

  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(
      const SizedBox(
          height: 20
      ),
    );

    formWidget.add(
      FutureBuilder<List<String>>(
        future: getOccasionValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            selectedOccasion = widget.occasion;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Occasion',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
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

    formWidget.add(
      const SizedBox(
          height: 20
      ),
    );

    formWidget.add(
      FutureBuilder<List<String>>(
        future: getBudgetValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Budget',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedBudget ?? data[0],

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
                  selectedBudget = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );

    formWidget.add(
      const SizedBox(
          height: 10
      ),
    );
    formWidget.add(
      FutureBuilder<List<String>>(
        future: getCakeFlavourValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Cake Flavour',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedCakeFlavour ?? data[0],

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
                  selectedCakeFlavour = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    formWidget.add(
      const SizedBox(
          height: 10
      ),
    );
    formWidget.add(
      FutureBuilder<List<String>>(
        future: getCakeSizeValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Cake Size',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedCakeSize ?? data[0],

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
                  selectedCakeSize = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    formWidget.add(
      const SizedBox(
          height: 10
      ),
    );

    formWidget.add(
      FutureBuilder<List<String>>(
        future: getDeliveryOptionValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Delivery Option',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedDeliveryOption ?? data[0],

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
                  selectedDeliveryOption = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    formWidget.add(
      const SizedBox(
          height: 10
      ),
    );
    formWidget.add(
      FutureBuilder<List<String>>(
        future: getGenderIndicatorValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Who is it for?',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedGenderIndicator ?? data[0],

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
                  selectedGenderIndicator = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    formWidget.add(
      const SizedBox(
          height: 10
      ),
    );
    formWidget.add(
      FutureBuilder<List<String>>(
        future: getIcingFlavourValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'IcingFlavourValues',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedIcingFlavour ?? data[0],

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
                  selectedIcingFlavour = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    formWidget.add(
      const SizedBox(
          height: 10
      ),
    );
    formWidget.add(
      FutureBuilder<List<String>>(
        future: getIcingTypeValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Icing Type',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedIcingType ?? data[0],

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
                  selectedIcingType = newValue!;
                });
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    formWidget.add(
      const SizedBox(
          height: 10
      ),
    );
    formWidget.add(
      FutureBuilder<List<String>>(
        future: getItemTypeValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Item Type',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(8 , 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedItemType ?? data[0],

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
                  selectedItemType = newValue!;
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
