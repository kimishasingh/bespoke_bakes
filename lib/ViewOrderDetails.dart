import 'package:bespoke_bakes/domain/quote_request_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'baker_landing_page.dart';
import 'domain/quote_response_data.dart';
import 'domain/user_data.dart';
import 'lookup_service.dart';

class ViewOrderPage extends StatefulWidget {
  const ViewOrderPage(
      {super.key,
        required this.title,
        required this.loggedInUser,
        required this.selectedQuoteRequest});

  final String title;
  final UserData loggedInUser;
  final QuoteRequestData selectedQuoteRequest;

  @override
  State<ViewOrderPage> createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final LookupService lookupService = LookupService();

  TextEditingController quoteResponseTotalController = TextEditingController();

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
        leading: const BackButton(),
        title: Text('Quote Request #${widget.selectedQuoteRequest.id}',
            style: const TextStyle(
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
                height: 900,
                decoration: const BoxDecoration(),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: getFormWidget(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getFormWidget(BuildContext context) {
    List<Widget> formWidget = [];
    formWidget.add(_buildTextFieldDisplay(
        "Nickname", widget.selectedQuoteRequest.nickname.toString()));
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildTextFieldDisplay(
        "Occasion", widget.selectedQuoteRequest.occasion.toString()));
    formWidget.add(_buildSizedBox(10));
    if (widget.selectedQuoteRequest.genderIndicator != null) {
      formWidget.add(_buildTextFieldDisplay("Gender Indicator",
          widget.selectedQuoteRequest.genderIndicator.toString()));
      formWidget.add(_buildSizedBox(10));
    }

    formWidget.add(_buildTextFieldDisplay(
        "Item Type", widget.selectedQuoteRequest.itemType.toString()));
    formWidget.add(_buildSizedBox(10));

    if (widget.selectedQuoteRequest.itemType == "Cake") {
      formWidget.add(_buildTextFieldDisplay(
          "Cake Size", widget.selectedQuoteRequest.cakeSize.toString()));
      formWidget.add(_buildSizedBox(10));
    }

    formWidget.add(_buildTextFieldDisplay(
        "Quantity", widget.selectedQuoteRequest.quantity.toString()));
    formWidget.add(_buildSizedBox(10));

    if (widget.selectedQuoteRequest.itemType == "Cake" &&
        widget.selectedQuoteRequest.numOfTiers != null) {
      formWidget.add(_buildTextFieldDisplay(
          "No. of Tiers", widget.selectedQuoteRequest.numOfTiers.toString()));
      formWidget.add(_buildSizedBox(10));
    }

    formWidget.add(_buildTextFieldDisplay(
        "Cake Flavour", widget.selectedQuoteRequest.cakeFlavour.toString()));
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildTextFieldDisplay(
        "Icing Type", widget.selectedQuoteRequest.icingType.toString()));
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildTextFieldDisplay(
        "Icing Flavour", widget.selectedQuoteRequest.icingFlavour.toString()));
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildTextFieldDisplay(
        "Icing Colour", widget.selectedQuoteRequest.icingColour.toString()));
    formWidget.add(_buildSizedBox(10));

    if (widget.selectedQuoteRequest.description != null) {
      formWidget.add(_buildTextFieldDisplay(
          "Description", widget.selectedQuoteRequest.description.toString()));
      formWidget.add(_buildSizedBox(10));
    }

    formWidget.add(_buildTextFieldDisplay(
        "Date/Time Required",
        DateFormat("yyyy-MM-dd HH:mm")
            .format(widget.selectedQuoteRequest.dateTimeRequired)));
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildTextFieldDisplay("Delivery Option",
        widget.selectedQuoteRequest.deliveryOption.toString()));
    formWidget.add(_buildSizedBox(10));
    formWidget.add(_buildTextFieldDisplay(
        "Budget", widget.selectedQuoteRequest.budget.toString()));

    if (widget.selectedQuoteRequest.additionalInfo != null) {
      formWidget.add(_buildSizedBox(10));
      formWidget.add(_buildTextFieldDisplay("Additional Info",
          widget.selectedQuoteRequest.additionalInfo.toString()));
    }

    formWidget.add(_buildSizedBox(20));

    return formWidget;
  }

  Widget _buildSizedBox(double height) {
    return SizedBox(height: height);
  }

  Widget _buildTextFieldDisplay(String label, String initialValue) {
    return TextFormField(
      readOnly: true,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
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
  }


  Future<void> onPressedSubmit(BuildContext buildContext) async {
    _formKey.currentState?.save();

    if (_formKey.currentState!.validate()) {
      QuoteResponseData quoteResponseObg = QuoteResponseData(
          id: widget.selectedQuoteRequest.userId,
          active: true,
          bundleTotal: int.parse(quoteResponseTotalController.text),
          discountAppliedPercentage: 0,
          quoteAccepted: false,
          quoteRequestId: widget.selectedQuoteRequest.id as int,
          quoteRequestTotal: int.parse(quoteResponseTotalController.text),
          bundleId: widget.selectedQuoteRequest.bundleId,
          userId: widget.loggedInUser.userId);

      QuoteResponseData? response =
      await lookupService.createQuoteResponse(quoteResponseObg);
      if (response != null) {
        Navigator.push(
          buildContext,
          MaterialPageRoute(
              builder: (context) => BakerLandingPage(
                  title: 'bespoke.bakes', loggedInUser: widget.loggedInUser)),
        );
      }
    }
  }
}
