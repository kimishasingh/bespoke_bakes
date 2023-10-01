import 'package:bespoke_bakes/lookup-service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class QuoteRequestPg2Data {
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

  QuoteRequestPg2Data({required this.occasion, required this.itemType});
}

class QuoteRequestPage2 extends StatefulWidget {
  QuoteRequestPage2({super.key, required this.title, required this.occasion});

  final String title;
  String occasion;

  @override
  State<QuoteRequestPage2> createState() => _QuoteRequestPage2State();
}

class _QuoteRequestPage2State extends State<QuoteRequestPage2> {
  String? selectedOccasion;
  String? selectedBudget;
  String? selectedCakeFlavour;
  String? selectedCakeSize;
  String? selectedDeliveryOption;
  String? selectedGenderIndicator;
  String? selectedIcingFlavour;
  String? selectedIcingType;
  String? selectedItemType;
  TextEditingController dateinput = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
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
                    height: 600,
                    decoration: BoxDecoration(),
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: getFormWidget(),
                        ))),
              ),
            ],
          ),
        ));
  }

  List<Widget> getFormWidget() {
  final LookupService lookupService = LookupService();
    List<Widget> formWidget = [];

    formWidget.add(
      const SizedBox(height: 10),
    );

    //Date picker
    formWidget.add(
      TextFormField(
        controller: dateinput, //editing controller of this TextField
        decoration: InputDecoration(
          //icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Date order required", //label text of field
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
        ),
      readOnly: true,  //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2024)
        );

        if(pickedDate != null ){
          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            dateinput.text = formattedDate; //set output date to TextField value.
          });
        }
        else{
          print("Date is not selected");
        }
      },
      )
    );

  formWidget.add(
    const SizedBox(height: 10),
  );
  //Location picker
    //TODO


  formWidget.add(
    const SizedBox(height: 10),
  );

  //Delivery Options
    formWidget.add(
      FutureBuilder<List<String>>(
        future: lookupService.getDeliveryOptionValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Delivery Options',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xFF76C6C5),
                ),
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
      const SizedBox(height: 10),
    );


    //Budget
    formWidget.add(
      FutureBuilder<List<String>>(
        future: lookupService.getBudgetValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Budget Range',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xFF76C6C5),
                ),
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
      const SizedBox(height: 10),
    );

    //Additional Info
    formWidget.add(
      TextFormField(
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
          labelText: "Additional Info",
          floatingLabelAlignment: FloatingLabelAlignment.start,
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
      )

    );


    formWidget.add(
      const SizedBox(height: 20),
    );

    void onPressedSubmit() {
      _formKey.currentState?.save();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Form Submitted')));
    }

    formWidget.add(ElevatedButton(
        onPressed: onPressedSubmit, child: const Text('Submit Request'))
    );

    return formWidget;
  }
}
