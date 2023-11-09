import 'package:bespoke_bakes/domain/location_data.dart';
import 'package:bespoke_bakes/domain/quote_request_data.dart';
import 'package:bespoke_bakes/login.dart';
import 'package:bespoke_bakes/lookup_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'capture_quote_response_page.dart';

class BakerLandingPage extends StatefulWidget {
  const BakerLandingPage({super.key, required this.title});

  final String title;

  @override
  State<BakerLandingPage> createState() => _BakerLandingPageState();
}

class _BakerLandingPageState extends State<BakerLandingPage> {
  final LookupService lookupService = LookupService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedLocationId = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 1,
          title: Image.asset('assets/images/Picture5.png',
              fit: BoxFit.fitHeight, height: 40),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(
                Icons.person,
                color: Color(0xFF76C6C5),
                size: 24,
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x39000000),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Color(0xFFFC4C69),
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Here are the latest available quote requests',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 396,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFC4C69),
                    ),
                    child: const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'Available Quote Requests',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Location Selector
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 15, 12, 12),
            child: FutureBuilder<List<LocationData>>(
              future: lookupService.getLocationValues(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  selectedLocationId = data[0].id.toString();
                  return DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Filter by Location',
                      labelStyle: Theme.of(context).textTheme.labelSmall,
                      floatingLabelStyle: Theme.of(context).textTheme.labelSmall,
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
                        borderRadius: BorderRadius.circular(0),
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
                    value: selectedLocationId,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: data.map((LocationData item) {
                      return DropdownMenuItem(
                        value: item.id.toString(),
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocationId = newValue!;
                      });
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),

          //Quote requests List

          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 500,
                decoration: const BoxDecoration(),
                child: FutureBuilder<List<QuoteRequestData>>(
                    future: lookupService.getQuoteRequests(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!;
                        return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 5,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data.length,
                            itemBuilder: (context, gridViewIndex) {
                              QuoteRequestData currentQuoteRequest =
                                  data[gridViewIndex];
                              final gridViewOccasion =
                                  currentQuoteRequest.occasion;
                              final gridViewDateReqd = DateFormat("yyyy-MM-dd")
                                  .format(currentQuoteRequest.dateTimeRequired);
                              final selectedQuoteRequest = currentQuoteRequest;

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuoteResponsePage(
                                          title: 'bespoke.bakes',
                                          selectedQuoteRequest:
                                              selectedQuoteRequest,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Colors.white,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // icon
                                          Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        -0.5, 0.00),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(5, 5, 5, 5),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    child: Image.asset(
                                                      'assets/images/$gridViewOccasion.png',
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          //occasion
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Text(
                                                    gridViewOccasion.isNotEmpty
                                                        ? gridViewOccasion
                                                        : "Loading",
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontFamily: 'Urbanist',
                                                      color: Color(0xFF76C6C5),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Text(
                                                    gridViewDateReqd.isNotEmpty
                                                        ? gridViewDateReqd
                                                        : "Loading",
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontFamily: 'Urbanist',
                                                      color: Color(0xFF76C6C5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            });
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
