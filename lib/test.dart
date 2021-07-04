import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:day12_login/AddWallet.dart';
// import 'package:day12_login/Category.dart';
// import 'package:day12_login/Order.dart';
// import 'package:day12_login/Cart.dart';
// import 'package:day12_login/Profiles.dart';
// import 'package:day12_login/Startingpage.dart';
// import 'package:day12_login/Wallet.dart';
// import 'package:day12_login/string.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  dynamic userId = "";
  dynamic myPieval;

  List<GDPData> _chartData;
  // TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    getCalory();
    // _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: SingleChildScrollView(
            child: WillPopScope(
          onWillPop: _onBackPressed,
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/fruits.jpg",
                      width: 52.0,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Welcome To Dashboard..!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Center(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 20.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Category(),
                          //     ));
                        },
                        child: SizedBox(
                          width: 100.0,
                          height: 130.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/home.png",
                                    width: 64.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Order(),
                          //     ));
                        },
                        child: SizedBox(
                          width: 100.0,
                          height: 130.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/order.png",
                                    width: 60.0,
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Center(
                                    child: Text(
                                      "Order History",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Wallet(),
                          //     ));
                        },
                        child: SizedBox(
                          width: 100.0,
                          height: 130.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/wallet.png",
                                    width: 60.0,
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Center(
                                    child: Text(
                                      "Wallet History",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Profiles(),
                          //     ));
                        },
                        child: SizedBox(
                          width: 100.0,
                          height: 130.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/profile.png",
                                    width: 64.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => AddWalletPage(),
                          //     ));
                        },
                        child: SizedBox(
                          width: 100.0,
                          height: 130.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/profile.png",
                                    width: 60.0,
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Center(
                                    child: Text(
                                      "Add wallet",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       settings: RouteSettings(name: "/StartingPage"),
                          //       builder: (context) => StartingPage(),
                          //     ));
                        },
                        child: SizedBox(
                          width: 100.0,
                          height: 130.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/profile.png",
                                    width: 64.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      // Container(
                      //     color: Colors.white,
                      //     width: 400,
                      //     child: SfCircularChart(
                      //       title: ChartTitle(text: 'Calories of Fruits'),
                      //       legend: Legend(
                      //           isVisible: true,
                      //           overflowMode: LegendItemOverflowMode.wrap),
                      //       series: <CircularSeries>[
                      //         PieSeries<GDPData, String>(
                      //             dataSource: _chartData,
                      //             xValueMapper: (GDPData data, _) =>
                      //                 data.continent,
                      //             yValueMapper: (GDPData data, _) => data.gdp,
                      //             dataLabelSettings:
                      //                 DataLabelSettings(isVisible: true))
                      //       ],
                      //     ))
                    ],
                  ),
                ),
              ),
            ],
          )),
        )));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You Are Going To Log Out?!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (context) => StartingPage()),
                  //     (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        });
  }

  showAlertDialog(msgQuote) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(msgQuote),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // _save(userName, userId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('user_name', userName);
  //   prefs.setString('_id', userId);
  // }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Apple Calory in grams', 235),
      GDPData('Pear Calory in grams', 78),
      GDPData('Chikoo', 29),
      GDPData('Banana', 23),
      GDPData('Strawberry', 24),
      GDPData('Guava', 34),
    ];
    return chartData;
  }

  getCalory() async {
    print('userId$userId');
    String myurl;
    // String myurl = Strings.baseOrigin + "/api/itemsWithStock/" + userId;
    http.get(myurl, headers: {'Accept': 'application/json'}).then((response) {
      log('pvn');
      List<GDPData> _chartData1 = [];
      if (response.statusCode == 200) {
        var bodyele = jsonDecode(response.body);
        if (bodyele["status"]) {
          dynamic allCalory = bodyele["data"];
          _chartData1.clear();
          allCalory.forEach((element) {
            print(element['name']);
            print(element['cal']);
            _chartData1.add(GDPData(
                element['name'].toString(), int.parse(element['cal']) + 1000));
          });
          setState(() {
            myPieval = allCalory;
            _chartData = _chartData1;
          });
        }
      }
    });
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
