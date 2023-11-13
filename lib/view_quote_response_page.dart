import 'package:bespoke_bakes/domain/quote_request_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'baker_landing_page.dart';
import 'domain/quote_response_data.dart';
import 'domain/user_data.dart';
import 'lookup_service.dart';

class ViewQuoteResponsePage extends StatefulWidget {
  const ViewQuoteResponsePage(
      {super.key,
      required this.title,
      required this.loggedInUser,
      required this.selectedQuoteResponse});

  final String title;
  final UserData loggedInUser;
  final QuoteResponseData selectedQuoteResponse;

  @override
  State<ViewQuoteResponsePage> createState() => _ViewQuoteResponsePageState();
}

class _ViewQuoteResponsePageState extends State<ViewQuoteResponsePage> {
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
        title: Text('Quote Request #${widget.selectedQuoteResponse.quoteRequestId}',
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
    //Todo fix this to ref bakerProfile

    formWidget.add(_buildTextFieldDisplay(
        "Baker", widget.selectedQuoteResponse.userId.toString()));
    formWidget.add(_buildSizedBox(10));

    formWidget.add(_buildTextFieldDisplay(
        "Quoted Amount", widget.selectedQuoteResponse.quoteRequestTotal.toString()));

    formWidget.add(ElevatedButton(
      onPressed: () async {
        onPressedAccept(context);
      },
      child: const Text('Accept and confirm order'),
    ));

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

  Widget _buildTextFormField(String label) {
    return TextFormField(
      controller: quoteResponseTotalController,
      keyboardType: TextInputType.number,
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
        labelText: label,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
        hintText: "Amount in Rands",
        hintStyle: Theme.of(context).textTheme.titleMedium,
        filled: true,
        fillColor: const Color(0xffffffff),
        isDense: false,
        contentPadding: const EdgeInsets.all(10),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please capture the quote total';
        }
        return null;
      },
    );
  }

  Future<void> onPressedAccept(BuildContext buildContext) async {
    _formKey.currentState?.save();

    if (_formKey.currentState!.validate()) {
      QuoteResponseData quoteResponseObg = QuoteResponseData(
          active: widget.selectedQuoteResponse.active,
          bundleTotal: widget.selectedQuoteResponse.bundleTotal,
          discountAppliedPercentage: widget.selectedQuoteResponse.discountAppliedPercentage,
          quoteAccepted: true,
          quoteRequestId: widget.selectedQuoteResponse.quoteRequestId,
          quoteRequestTotal: widget.selectedQuoteResponse.quoteRequestTotal,
          bundleId: widget.selectedQuoteResponse.bundleId,
          userId: widget.loggedInUser.userId);

      QuoteResponseData? response =
          await lookupService.updateQuoteResponse(quoteResponseObg);
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
