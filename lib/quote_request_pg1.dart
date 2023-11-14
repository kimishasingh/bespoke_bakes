import 'package:bespoke_bakes/domain/quote_request_data.dart';
import 'package:bespoke_bakes/lookup_service.dart';
import 'package:bespoke_bakes/quote_request_pg2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'domain/user_data.dart';

class QuoteRequestPage extends StatefulWidget {
  const QuoteRequestPage(
      {super.key,
      required this.title,
      required this.occasion,
      required this.loggedInUser});

  final String title;
  final String occasion;
  final UserData loggedInUser;

  @override
  State<QuoteRequestPage> createState() => _QuoteRequestPageState();
}

class _QuoteRequestPageState extends State<QuoteRequestPage> {
  String selectedOccasion = "";
  String selectedCakeFlavour = "Chocolate";
  String selectedCakeSize = "10cm";
  String selectedGenderIndicator = "Boy";
  String selectedIcingFlavour = "Cream cheese";
  String selectedIcingType = "Buttercream";
  String selectedItemType = "Cake";
  String selectedNoOfTiers = "1";
  int selectedQuantity = 1;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController icingColourController = TextEditingController();
  TextEditingController orderNicknameController = TextEditingController();

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
        iconTheme: const IconThemeData(
          color: Color(0xFFFC4C69), //change your color here
        ),
        leading: const BackButton(),
        title: const Text('Share your cake vision',
            style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                color: Color(0xFFFC4C69),
                fontWeight: FontWeight.w400)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Container(
                height: double.maxFinite,
                decoration: const BoxDecoration(),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
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
    formWidget.add(_buildNicknameTextFormField());

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
    formWidget.add(_buildIcingColourTextFormField());
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildDescriptionTextFormField());
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
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
              hintStyle: Theme.of(context).textTheme.titleMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            value: selectedOccasion,
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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
              hintStyle: Theme.of(context).textTheme.titleMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            // Initial Value
            value: selectedGenderIndicator,
            hint: const Text(' '),

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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
              hintStyle: Theme.of(context).textTheme.titleMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            value: selectedItemType,
            hint: const Text(' '),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
              hintStyle: Theme.of(context).textTheme.titleMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            // Initial Value
            value: selectedCakeSize,
            hint: const Text(' '),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildQuantityTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction(
          (selectedQuantity, newValue) => newValue.copyWith(
            text: newValue.text.replaceAll('.', ','),
          ),
        ),
      ],
      initialValue: "1",
      // Only numbers can be entered
      decoration: InputDecoration(
        labelText: 'Quantity *',
        labelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
        hintStyle: Theme.of(context).textTheme.titleMedium,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffc4bfbf),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffc4bfbf),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
      ),
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
        labelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
        hintStyle: Theme.of(context).textTheme.titleMedium,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffc4bfbf),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffc4bfbf),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
      ),
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
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            value: selectedCakeFlavour,
            hint: const Text(' '),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            value: selectedIcingType,
            hint: const Text(' '),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
              labelStyle: Theme.of(context).textTheme.labelMedium,
              floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffc4bfbf),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            value: selectedIcingFlavour,
            hint: const Text(' '),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildIcingColourTextFormField() {
    return TextFormField(
      controller: icingColourController,
      obscureText: false,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        labelText: "Icing Colour *",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
        hintText: "List the icing colour(s) you want",
        hintStyle: Theme.of(context).textTheme.titleMedium,
        filled: true,
        fillColor: const Color(0xffffffff),
        isDense: false,
        contentPadding: const EdgeInsets.all(10),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an Icing colour';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionTextFormField() {
    return TextFormField(
      controller: descriptionController,
      obscureText: false,
      maxLines: 5,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        labelText: "Description",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
        hintText:
            "Provide any details to help explain what your baked treat should look like",
        hintStyle: Theme.of(context).textTheme.titleMedium,
        filled: true,
        fillColor: const Color(0xffffffff),
        isDense: false,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }

  Widget _buildNicknameTextFormField() {
    return TextFormField(
      controller: orderNicknameController,
      obscureText: false,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xffc4bfbf), width: 1),
        ),
        labelText: "Order Nickname",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
        hintText: "Provide a nickname for your order request",
        hintStyle: Theme.of(context).textTheme.titleMedium,
        filled: true,
        fillColor: const Color(0xffffffff),
        isDense: false,
        contentPadding: const EdgeInsets.all(10),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an Order Nickname';
        }
        return null;
      },
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(onPressed: onPressedNext, child: const Text('Next'));
  }

  void onPressedNext() {
    _formKey.currentState?.save();

    if (_formKey.currentState!.validate()) {
      QuoteRequestData pg1Obj = QuoteRequestData(
          occasion: selectedOccasion,
          itemType: selectedItemType,
          cakeFlavour: selectedCakeFlavour,
          icingType: selectedIcingType,
          icingFlavour: selectedIcingFlavour,
          icingColour: icingColourController.text,
          cakeSize: selectedCakeSize,
          quantity: selectedQuantity,
          dateTimeRequired: DateTime.now(),
          deliveryOption: "",
          budget: "",
          userId: widget.loggedInUser.userId,
          bundleId: 1,
          nickname: orderNicknameController.text);

      if (descriptionController.text.isNotEmpty) {
        pg1Obj.description = descriptionController.text;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuoteRequestPage2(
                title: 'bespoke.bakes',
                loggedInUser: widget.loggedInUser,
                quoteRequestData: pg1Obj)),
      );
    }
  }
}
