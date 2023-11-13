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

  @override
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
            color: Color(0xFFFC4C69), //change your color here
          ),
          leading: const BackButton(),
          title: const Text('Almost done...',
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

    formWidget.add(Card(
        elevation: 0,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset('assets/images/hpcake.jpg', width: 60, height: 100)
        ])));

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
                labelStyle: Theme.of(context).textTheme.labelMedium,
                floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
                hintText: 'Select your preference',
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
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedDeliveryOption,

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
                labelStyle: Theme.of(context).textTheme.labelMedium,
                floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
                hintText: 'Select your location',
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
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
              ),
              // Initial Value
              value: selectedLocation,

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
                labelStyle: Theme.of(context).textTheme.labelMedium,
                floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
                hintText: 'Select your price range',
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
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
              ),
              style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),
              // Initial Value
              value: selectedBudget,
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
      maxLines: 3,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: "Additional Info",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
        hintText:
            "Provide any additional info around allergies, delivery or collection information",
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
        const snackBar = SnackBar(
          content: Text('Quote Request Submitted!'),
          /* action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),*/
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushReplacement(
          buildContext,
          MaterialPageRoute(
              builder: (context) => LandingPage(
                  title: 'bespoke.bakes', loggedInUser: widget.loggedInUser)),
        );
      }
    }
  }
}
