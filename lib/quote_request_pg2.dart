import 'dart:async';
import 'dart:io';

import 'package:bespoke_bakes/domain/location_data.dart';
import 'package:bespoke_bakes/domain/quote_request_data.dart';
import 'package:bespoke_bakes/lookup_service.dart';
import 'package:flutter/material.dart';
import 'package:image_field/image_field.dart';
import 'package:image_field/linear_progress_indicator_if.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

import 'landing_page.dart';
import 'domain/user_data.dart';

typedef Progress = Function(double percent);

class QuoteRequestPage2 extends StatefulWidget {
  const QuoteRequestPage2(
      {super.key,
      required this.title,
      required this.loggedInUser,
      required this.quoteRequestData});

  final String title;
  final UserData loggedInUser;
  final QuoteRequestData quoteRequestData;

  @override
  State<QuoteRequestPage2> createState() => _QuoteRequestPage2State();
}

class _QuoteRequestPage2State extends State<QuoteRequestPage2> {
  String? selectedDeliveryOption;
  String? selectedLocation;
  String? selectedBudget;

  TextEditingController dateTimeController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  final LookupService lookupService = LookupService();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  dynamic remoteFiles;

  Future<dynamic> uploadToServer(XFile? file,
      {Progress? uploadProgress}) async {
    final stream = file!.openRead();
    int length = await file.length();
    final client = HttpClient();

    final request = await client.postUrl(Uri.parse('URI'));
    request.headers.add('Content-Type', 'application/octet-stream');
    request.headers.add('Accept', '*/*');
    request.headers.add('Content-Disposition', 'file; filename="${file.name}"');
    request.headers.add('Authorization', 'Bearer ACCESS_TOKEN');
    request.contentLength = length;

    int byteCount = 0;
    double percent = 0;
    Stream<List<int>> stream2 = stream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          byteCount += data.length;
          if (uploadProgress != null) {
            percent = (byteCount / length) * 100;
            uploadProgress(percent);
          }
          sink.add(data);
        },
        handleError: (error, stack, sink) {},
        handleDone: (sink) {
          sink.close();
        },
      ),
    );

    await request.addStream(stream2);
  }

  void initState() {
    dateTimeController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          leading: BackButton(),
          title: const Text('Tell us more',
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
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                    height: 600,
                    decoration: const BoxDecoration(),
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
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
    List<Widget> formWidget = [];

    formWidget.add(
      const SizedBox(height: 10),
    );

    formWidget.add(
      //Remote Image upload
      ImageField(
          texts: const {
            'fieldFormText': 'Upload images',
            'titleText': 'Upload images'
          },
          files: remoteFiles != null
              ? remoteFiles!.map((image) {
                  return ImageAndCaptionModel(
                      file: image, caption: image.alt.toString());
                }).toList()
              : [],
          remoteImage: true,
          onUpload: (dynamic pickedFile,
              ControllerLinearProgressIndicatorIF?
                  controllerLinearProgressIndicator) async {
            dynamic fileUploaded = await uploadToServer(
              pickedFile,
              uploadProgress: (percent) {
                var uploadProgressPercentage = percent / 100;
                controllerLinearProgressIndicator!
                    .updateProgress(uploadProgressPercentage);
              },
            );
            return fileUploaded;
          },
          onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
            remoteFiles = imageAndCaptionList;
          }),
    );

    formWidget.add(
      const SizedBox(height: 10),
    );

    //Date picker
    formWidget.add(TextFormField(
      controller: dateTimeController,
      //editing controller of this TextField
      decoration: InputDecoration(
        //icon: Icon(Icons.calendar_today), //icon of text field
        labelText: "Date/Time Order Required *",
        //label text of field
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DatePickerBdaya.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2024, 1, 1, 0, 0, 0),
          onConfirm: (date) {
            dateTimeController.text =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a Date/Time';
        }
        return null;
      },
    ));

    formWidget.add(
      const SizedBox(height: 10),
    );
    //Location picker
    //TO DO

    formWidget.add(
      const SizedBox(height: 10),
    );

    formWidget.add(
      FutureBuilder<List<String>>(
        future: lookupService.getDeliveryOptionValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Delivery Option *',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xFF76C6C5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedDeliveryOption,
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
                  selectedDeliveryOption = newValue!;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a Delivery option';
                }
                return null;
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

    formWidget.add(
      FutureBuilder<List<LocationData>>(
        future: lookupService.getLocationValues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Location *',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xFF76C6C5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedLocation,
              hint: const Text(' '),

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: data.map((LocationData item) {
                return DropdownMenuItem(
                  value: item.id.toString(),
                  child: Text(item.name),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a Location';
                }
                return null;
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
                labelText: 'Budget Range *',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xFF76C6C5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedBudget,
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
                  selectedBudget = newValue!;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a Budget range';
                }
                return null;
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
    formWidget.add(TextFormField(
      controller: additionalInfoController,
      obscureText: false,
      maxLines: 5,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: Color(0xff000000),
      ),
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
        labelText: "Additional Info",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xFF76C6C5),
        ),
        hintText: "Enter Text",
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 12,
          color: Color(0xff000000),
        ),
        filled: true,
        fillColor: const Color(0xffffffff),
        isDense: false,
        contentPadding: const EdgeInsets.all(10),
      ),
    ));

    formWidget.add(
      const SizedBox(height: 20),
    );

    formWidget.add(ElevatedButton(
        onPressed: () async {
          onPressedSubmit(context);
        },
        child: const Text('Submit Request')));

    return formWidget;
  }

  Future<void> onPressedSubmit(BuildContext buildContext) async {
    _formKey.currentState?.save();

    if (_formKey.currentState!.validate()) {
      var dateTime = dateTimeController.text;
      var delivery = selectedDeliveryOption.toString();
      var budget = selectedBudget.toString();
      var location =
          selectedLocation != null ? int.parse(selectedLocation!) : null;

      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);

      _formKey.currentState?.save();
      widget.quoteRequestData.dateTimeRequired = tempDate;
      widget.quoteRequestData.deliveryOption = delivery;
      widget.quoteRequestData.budget = budget;
      widget.quoteRequestData.additionalInfo = additionalInfoController.text;
      widget.quoteRequestData.locationId = location;

      QuoteRequestData? response =
          await lookupService.createQuoteRequest(widget.quoteRequestData);
      if (response != null) {
        Navigator.push(
          buildContext,
          MaterialPageRoute(
              builder: (context) => LandingPage(
                  title: 'bespoke.bakes', loggedInUser: widget.loggedInUser)),
        );
      }
    }
  }
}
