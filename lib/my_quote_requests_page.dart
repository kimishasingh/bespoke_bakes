import 'dart:convert';

import 'package:bespoke_bakes/view_all_responses_for_quote_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'domain/user_data.dart';
import 'landing_page.dart';
import 'main.dart';
import 'my_orders.dart';

class OccasionData {
  String occasion;

  OccasionData({required this.occasion});
}

class MyQuoteRequestsPage extends StatefulWidget {
  MyQuoteRequestsPage(
      {super.key, required this.title, required this.loggedInUser});

  final String title;
  final UserData loggedInUser;

  @override
  State<MyQuoteRequestsPage> createState() => _MyQuoteRequestsPageState();
}

class _MyQuoteRequestsPageState extends State<MyQuoteRequestsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Map<String, dynamic>>> getQuoteRequests() async {
    var baseUrl =
        "https://bespokebakes.azurewebsites.net/admin/quote-request/user/${widget.loggedInUser.userId}";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 1,
          title: Image.asset('assets/images/Picture5.png',
              fit: BoxFit.fitHeight, height: 40),
          centerTitle: false,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Color(0xFF76C6C5)),
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          actions: <Widget>[
            //Notifications
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyApp())); // change to Notification Panel
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
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                  return const MyApp();
                }), (r){
                  return false;
                });
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
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                        'My Quote Requests',
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

          //Quote requests List

          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 500,
                decoration: const BoxDecoration(),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: getQuoteRequests(),
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
                              Map qrMap = data[gridViewIndex];
                              final gridViewOccasion = qrMap["occasion"];
                              final gridViewNickname = qrMap["nickname"];
                              final gridViewDateReqdDateTime =
                                  DateFormat("yyyy-MM-dd")
                                      .parse(qrMap["dateTimeRequired"]);
                              final gridViewDateReqd = DateFormat("yyyy-MM-dd")
                                  .format(gridViewDateReqdDateTime);
                              final selectedQuoteRequestId = qrMap["id"];

                              return GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Gesture Detected!')));

                                    // Should navigate to view of quote responses for the selected quote as well as a summary of the quote
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyQuoteResponsesPage(title: 'Quote Responses', loggedInUser: widget.loggedInUser, selectedQuoteRequestId: selectedQuoteRequestId)),
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
                                                        ? gridViewNickname
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
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                accountName: Text(
                  "${widget.loggedInUser.name} ${widget.loggedInUser.surname}",
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFFFC4C69)),
                ),
                accountEmail: Text(widget.loggedInUser.emailAddress,
                    style: const TextStyle(
                        fontSize: 18, color: Color(0xFFFC4C69))),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: const Color(0xFF76C6C5),
                  child: Text(
                    widget.loggedInUser.name.substring(0, 1),
                    style: const TextStyle(fontSize: 30.0, color: Colors.white),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' Home '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  LandingPage(
                            title: "Home", loggedInUser: widget.loggedInUser)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.request_quote),
              title: const Text(' My Quote Requests '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyQuoteRequestsPage(
                            title: "My Quote Requests",
                            loggedInUser: widget.loggedInUser)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text(' My Orders '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyOrdersPage(
                            title: "My Orders",
                            loggedInUser: widget.loggedInUser)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                  return const MyApp();
                }), (r){
                  return false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
