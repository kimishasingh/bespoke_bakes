import 'package:bespoke_bakes/lookup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'BakerLandingPage.dart';
import 'domain/quote_response_data.dart';

class QuoteResponsePage extends StatefulWidget {
  const QuoteResponsePage(
      {super.key, required this.title, required this.quoteRequestId});

  final String title;
  final int quoteRequestId;

  @override
  State<QuoteResponsePage> createState() => _QuoteResponsePageState();
}

class _QuoteResponsePageState extends State<QuoteResponsePage> {
  String selectedOccasion="";
  String selectedCakeFlavour="Chocolate";
  String selectedCakeSize="10cm";
  String selectedGenderIndicator="Boy";
  String selectedIcingFlavour="Cream cheese";
  String selectedIcingType="Buttercream";
  String selectedItemType="Cake";
  String selectedNoOfTiers="1";
  int selectedQuantity=1;
  int selectedQuoteRequest = 0;
  bool active = true;
  int bundleId = 0;
  int bundleTotal= 0;
  int? discountAppliedPercentage;
  bool quoteAccepted = false;
  int quoteRequestTotal = 0;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController icingColourController = TextEditingController();

  final LookupService lookupService = LookupService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above

    selectedQuoteRequest = widget.quoteRequestId;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: const BackButton(),
        title:  Text('Quote Request #$selectedQuoteRequest',
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
    formWidget.add(_buildOccasionDisplay());
    formWidget.add(_buildSizedBox(20));
    //formWidget.add(_buildSubmitButton());

    return formWidget;
  }

  Widget _buildSizedBox(double height) {
    return SizedBox(height: height);
  }

  Widget _buildOccasionDisplay() {
    return FutureBuilder<List<String>>(
      future: lookupService.getQuoteRequestById(selectedQuoteRequest),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return TextField(
            decoration: InputDecoration(
              labelText: 'Occasion',
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8)),
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
              contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
            ),
            style: const TextStyle(fontSize: 20, color: Color(0xFF8B97A2)),

          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

/*
  Widget _buildSubmitButton() {
    return ElevatedButton(onPressed: onPressedSubmit(context), child: const Text('Submit'));
  }
*/
  Future<void> onPressedSubmit(BuildContext buildContext) async {
    _formKey.currentState?.save();

    if (_formKey.currentState!.validate()) {
      QuoteResponseData quoteResponseObg = QuoteResponseData(
          active: active,
          bundleTotal:bundleTotal,
          quoteAccepted: quoteAccepted,
          quoteRequestId: selectedQuoteRequest,
          quoteRequestTotal:quoteRequestTotal,
          bundleId: 1
      );

      QuoteResponseData? response =
          await lookupService.createQuoteResponse(quoteResponseObg);
      if (response != null) {
        Navigator.push(
          buildContext,
          MaterialPageRoute(
              builder: (context) => const BakerLandingPage(title: 'bespoke.bakes')),
        );
      }

    }
  }
}
