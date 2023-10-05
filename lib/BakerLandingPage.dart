
import 'dart:convert';

import 'package:bespoke_bakes/login.dart';
import 'package:bespoke_bakes/quote-request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'LandingPage.dart';


class OccasionData {
  String occasion;
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

  OccasionData({required this.occasion});
}

class BakerLandingPage extends StatefulWidget {
  const BakerLandingPage({super.key, required this.title});

  final String title;

  @override
  State<BakerLandingPage> createState() => _BakerLandingPageState();
}

class _BakerLandingPageState extends State<BakerLandingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<String>> getOccasionValues() async {
    var baseUrl = "https://bespokebakes.azurewebsites.net/api/v1/lookup/occasion";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
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
      key:scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 1,
          title: Image.asset('assets/images/Picture5.png', fit: BoxFit.fitHeight,height: 40),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const LoginPage()
                  )
              );}
              , icon: Icon(
              Icons.person,
              color: Color(0xFF76C6C5),
              size: 24,
            ),
            )
          ]
      ),
      body:
      SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x39000000),
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
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
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Quote Requests',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                          FutureBuilder<List<String>>(
                              future: getOccasionValues(),
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
                                        final gridViewOccasion =
                                        data[gridViewIndex];
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
                                                        QuoteRequestPage(title: 'bespoke.bakes', occasion: gridViewOccasion.isNotEmpty? gridViewOccasion: 'Loading')),
                                              );
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
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
                                                Expanded(
                                                    flex: 2,
                                                    child:
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children:  [
                                                        Padding(
                                                          padding: EdgeInsetsDirectional
                                                              .fromSTEB(5, 5, 5, 5),
                                                          child: Text(gridViewOccasion.isNotEmpty? gridViewOccasion: "Loading",
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
                                                Expanded(
                                                    flex: 1,
                                                    child:
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Padding(padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                                            child:
                                                            ElevatedButton(
                                                                child: const Text('View'),
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                        const LandingPage(title: 'bespoke.bakes')),
                                                                  );
                                                                }
                                                            )
                                                        )],
                                                    )
                                                )
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
                      ),),
            ]
        ),

      ),
    );
  }
}