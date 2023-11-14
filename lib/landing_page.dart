import 'package:bespoke_bakes/my_orders.dart';
import 'package:bespoke_bakes/my_quote_requests_page.dart';
import 'package:bespoke_bakes/domain/user_data.dart';
import 'package:bespoke_bakes/main.dart';
import 'package:bespoke_bakes/quote_request_pg1.dart';
import 'package:flutter/material.dart';

import 'lookup_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage(
      {super.key, required this.title, required this.loggedInUser});

  final String title;
  final UserData loggedInUser;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final LookupService lookupService = LookupService();

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
                /*Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 40, 0, 0),
                      child: Image.asset(
                        'assets/images/Picture5.png',
                        width: 160,
                        height: 50,
                        fit: BoxFit.fitWidth,
                      ),
                    ),*/
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
                        'Let\'s bring your cake visions to life!',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
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
                        'What\'s the occasion?',
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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 500,
                decoration: const BoxDecoration(),
                child: FutureBuilder<List<String>>(
                    future: lookupService.getOccasionValues(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!;
                        return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data.length,
                            itemBuilder: (context, gridViewIndex) {
                              final gridViewOccasion = data[gridViewIndex];
                              return Card(
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
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuoteRequestPage(
                                                  title: 'bespoke.bakes',
                                                  occasion: gridViewOccasion
                                                          .isNotEmpty
                                                      ? gridViewOccasion
                                                      : 'Loading',
                                                  loggedInUser:
                                                      widget.loggedInUser)),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          child: Image.asset(
                                            'assets/images/$gridViewOccasion.png',
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                              child: Text(
                                                gridViewOccasion.isNotEmpty
                                                    ? gridViewOccasion
                                                    : "Loading",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  color: Color(0xFF76C6C5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
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
                        builder: (context) =>  MyQuoteRequestsPage(
                            title: "My Quote Requests", loggedInUser: widget.loggedInUser)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text(' My Orders '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                         MyOrdersPage(title: "My Orders", loggedInUser: widget.loggedInUser)
                    )
                );
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
      ), //Drawer
    );
  }
}
