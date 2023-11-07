
import 'dart:convert';

import 'package:bespoke_bakes/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'main.dart';

class OccasionData {
  String occasion;
  OccasionData({required this.occasion});
}

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key, required this.title});

  final String title;

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Map<String, dynamic>>> getQuoteRequests() async {
    //this query needs to pull quote requests and responses that have been accepted
    var baseUrl = "https://bespokebakes.azurewebsites.net/admin/quote-request";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> items = [];
      List<Map<String, dynamic>> filteredList = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      for(var item in items){
        if (item['quoteAccepted'] = true) {
          filteredList.add(item);
        }
      }
      return filteredList;
    } else {
      throw response.statusCode;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldKey,
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
            //Notifications
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp())); // change to Notification Panel
              },
              icon: const Tooltip(
                  message: 'Notifications',
                  child: Icon(
                    Icons.notifications,
                    color: Color(0xFF76C6C5),
                    size: 24,
                  )),
            ),
            //Exit
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              icon: const Tooltip(
                  message: 'Logout',
                  child: Icon(
                    Icons.logout,
                    color: Color(0xFF76C6C5),
                    size: 24,
                  )),
            )
          ]),
      body:
      SingleChildScrollView(
        child:
        Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 396,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFFC4C69),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Tooltip(
                                  message: 'Back',
                                  child: Icon(
                                    Icons.arrow_back_sharp,
                                    color: Color(0xFF76C6C5),
                                    size: 24,
                                  )),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'My Orders',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ),
                    ),          ],
                ),
              ),

              //Quote requests List

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(),
                    child:
                    FutureBuilder<List<Map<String, dynamic>>>(
                        future: getQuoteRequests(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!;
                            return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 5,
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: data.length,
                                itemBuilder: (context, gridViewIndex) {
                                  Map qrMap = data[gridViewIndex];
                                  final gridViewOccasion = qrMap["occasion"];
                                  final gridViewDateReqdDateTime = DateFormat("yyyy-MM-dd").parse(qrMap["dateTimeRequired"]);
                                  final gridViewDateReqd = DateFormat("yyyy-MM-dd").format(gridViewDateReqdDateTime);
                                  final selectedQuoteRequestId = qrMap["id"];

                                  return GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Gesture Detected!')));

                                        /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QuoteResponsePage(title: 'bespoke.bakes', quoteRequestId: selectedQuoteRequestId)),
                                        );*/
                                      },
                                      child: Card (
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
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              // icon
                                              Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment:
                                                    AlignmentDirectional(-0.5, 0.00),
                                                    child: Padding(padding: EdgeInsetsDirectional
                                                        .fromSTEB(5, 5, 5, 5),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(0),
                                                        child: Image.asset(
                                                          'assets/images/$gridViewOccasion.png',
                                                          width: 30,
                                                          height: 30,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              //occasion
                                              Expanded(
                                                flex: 2,
                                                child:
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children:  [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                      child: Text(gridViewOccasion.isNotEmpty? gridViewOccasion: "Loading",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: 'Urbanist',
                                                          color: Color(0xFF76C6C5),
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                      child: Text(gridViewDateReqd.isNotEmpty? gridViewDateReqd: "Loading",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
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
                ),),
            ]
        ),

      ),
    );
  }
}