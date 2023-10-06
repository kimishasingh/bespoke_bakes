import 'package:bespoke_bakes/lookup_service.dart';
import 'package:bespoke_bakes/quote_request_pg2.dart';
import 'package:flutter/material.dart';

class QuoteRequestPage extends StatefulWidget {
  const QuoteRequestPage(
      {super.key, required this.title, required this.occasion});

  final String title;
  final String occasion;

  @override
  State<QuoteRequestPage> createState() => _QuoteRequestPageState();
}

class _QuoteRequestPageState extends State<QuoteRequestPage> {
  String? selectedOccasion;
  String? selectedCakeFlavour;
  String? selectedCakeSize;
  String? selectedGenderIndicator;
  String? selectedIcingFlavour;
  String? selectedIcingType;
  String? selectedItemType;
  String? selectedNoOfTiers;
  String? selectedQuantity;

  final LookupService lookupService = LookupService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above

    selectedOccasion = widget.occasion;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: BackButton(),
        title: Text('Tell us more',
            style: TextStyle(
                fontFamily: 'Urbanist',
                color: Colors.black,
                fontWeight: FontWeight.w400)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Container(
                height: double.maxFinite,
                decoration: BoxDecoration(),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: getFormWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildOccasionDropDown());

    formWidget.add(_buildVisibility(
      _showGenderIndicator(),
      _buildSizedBox(10),
    ));

    formWidget.add(_buildVisibility(
      _showGenderIndicator(),
      _buildGenderIndicatorDropDown(),
    ));

    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildItemTypeDropDown());

    formWidget.add(
      _buildVisibility(
        _isItemTypeCake(),
        _buildSizedBox(10),
      ),
    );

    formWidget.add(
      _buildVisibility(
        _isItemTypeCake(),
        _buildCakeSizeDropDown(),
      ),
    );

    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildQuantityTextFormField());

    formWidget.add(
      _buildVisibility(
        _isItemTypeCake(),
        _buildSizedBox(10),
      ),
    );

    formWidget.add(
      _buildVisibility(
        _isItemTypeCake(),
        _buildNoOfTiersTextFormField(),
      ),
    );

    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildCakeFlavourDropDown());
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildIcingTypeDropDown());
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildIcingFlavourDropDown());
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildAdditionalInfoTextFormField());
    formWidget.add(_buildSizedBox(20));
    formWidget.add(_buildNextButton());

    return formWidget;
  }

  bool _showGenderIndicator() {
    return selectedOccasion == 'Gender reveal' ||
        selectedOccasion == 'Baby shower';
  }

  bool _isItemTypeCake() {
    return selectedItemType == 'Cake';
  }

  Widget _buildVisibility(bool condition, Widget child) {
    return Visibility(
      visible: condition,
      child: child,
    );
  }

  Widget _buildSizedBox(double height) {
    return SizedBox(height: height);
  }

  Widget _buildOccasionDropDown() {
    return FutureBuilder<List<String>>(
      future: lookupService.getOccasionValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          selectedOccasion = widget.occasion;
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Occasion *',
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8)),
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
            value: selectedOccasion ?? data[0],
            icon: const Icon(Icons.keyboard_arrow_down),
            items: data.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedOccasion = newValue!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an Occasion';
              }
              return null;
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildGenderIndicatorDropDown() {
    return FutureBuilder<List<String>>(
      future: lookupService.getGenderIndicatorValues(),
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
            // Initial Value
            value: selectedGenderIndicator,
            hint: Text(' '),

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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if ((value == null || value.isEmpty) &&
                  selectedOccasion == 'Gender reveal') {
                return 'Please select a Gender';
              }
              return null;
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildItemTypeDropDown() {
    return FutureBuilder<List<String>>(
      future: lookupService.getItemTypeValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Item Type *',
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
            value: selectedItemType,
            hint: Text(' '),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: data.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedItemType = newValue!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an Item type';
              }
              return null;
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildCakeSizeDropDown() {
    return FutureBuilder<List<String>>(
      future: lookupService.getCakeSizeValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Cake Size *',
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
            // Initial Value
            value: selectedCakeSize,
            hint: Text(' '),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: data.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCakeSize = newValue!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a Cake size';
              }
              return null;
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildQuantityTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Quantity *',
        floatingLabelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        hintStyle: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
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
        contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
      ),
      style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
      initialValue: selectedQuantity,
      onChanged: (String? newValue) {
        setState(() {
          selectedQuantity = newValue!;
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a Quantity';
        }
        return null;
      },
    );
  }

  Widget _buildNoOfTiersTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'No. of Tiers *',
        floatingLabelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        hintStyle: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
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
        contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
      ),
      style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
      initialValue: selectedNoOfTiers,
      onChanged: (String? newValue) {
        setState(() {
          selectedNoOfTiers = newValue!;
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the No. of tiers';
        }
        return null;
      },
    );
  }

  Widget _buildCakeFlavourDropDown() {
    return FutureBuilder<List<String>>(
      future: lookupService.getCakeFlavourValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Cake Flavour *',
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
            value: selectedCakeFlavour,
            hint: Text(' '),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: data.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCakeFlavour = newValue!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a Cake flavour';
              }
              return null;
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildIcingTypeDropDown() {
    return FutureBuilder<List<String>>(
      future: lookupService.getIcingTypeValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Icing Type *',
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
            value: selectedIcingType,
            hint: Text(' '),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: data.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedIcingType = newValue!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an Icing Type';
              }
              return null;
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildIcingFlavourDropDown() {
    return FutureBuilder<List<String>>(
      future: lookupService.getIcingFlavourValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Icing Flavour *',
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
            value: selectedIcingFlavour,
            hint: Text(' '),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: data.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedIcingFlavour = newValue!;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an Icing flavour';
              }
              return null;
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildAdditionalInfoTextFormField() {
    return TextFormField(
      controller: TextEditingController(),
      obscureText: false,
      maxLines: 5,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: Color(0xff000000),
      ),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        labelText: "Description",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: TextStyle(fontSize: 16, color: Color(0xffc4bfbf)),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xFF76C6C5),
        ),
        hintText: "Enter Text",
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 12,
          color: Color(0xff000000),
        ),
        filled: true,
        fillColor: Color(0xffffffff),
        isDense: false,
        contentPadding: EdgeInsets.all(10),
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(onPressed: onPressedNext, child: const Text('Next'));
  }

  void onPressedNext() {
    _formKey.currentState?.save();

    if (_formKey.currentState!.validate()) {
      print('Form is valid');

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuoteRequestPage2(title: 'bespoke.bakes')),
      );
    } else {
      print('Form is not valid');
    }
  }
}
