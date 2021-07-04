import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController dateTextEditingController = new TextEditingController();

  bool pinSuffix = false, loading = false;
  dynamic body;
  dynamic body_state, body_district;
  int day, month, year;
  String state_id = '', district_id = '';
  String state = '', district = '';
  List<dynamic> statesss = [];
  List<dynamic> districtsss = [];
  List<String> states = [];
  List<String> districts = [];
  bool auto_search = false;
  Timer timer;

  bool district_mode = false;
  bool no_data = false;

  String _value = '';

  @override
  initState() {
    super.initState();
    checkData();
  }

  checkData() async {
    try {
      if (!kIsWeb) {
        final result = await InternetAddress.lookup('google.co.in');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          getStates();
          setState(() {
            no_data = false;
          });
        }
      } else {
        getStates();
        setState(() {
          no_data = false;
        });
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          content: Text("No Internet Connection Available!")));
      setState(() {
        no_data = true;
      });
    }
  }

  getStates() async {
    // setState(() {
    //   loading = true;
    // });]
    states.clear();
    statesss.clear();

    var response = await http
        .get("https://cdn-api.co-vin.in/api/v2/admin/location/states");

    body_state = await jsonDecode(response.body);
    // loading = false;
    statesss = await body_state['states'];
    statesss.forEach((element) {
      states.add(element['state_name']);
    });

    state = states[0];
    state_id = statesss[0]['state_id'].toString();
    getDistricts();
    setState(() {});
  }

  getDistricts() async {
    // setState(() {
    //   loading = true;
    // });
    districts.clear();
    districtsss.clear();
    var response = await http.get(
        "https://cdn-api.co-vin.in/api/v2/admin/location/districts/$state_id");
    body_district = await jsonDecode(response.body);
    // loading = false;
    districtsss = await body_district['districts'];
    districtsss.forEach((element) {
      districts.add(element['district_name']);
    });
    district = districts[0];
    district_id = districtsss[0]['district_id'].toString();
    setState(() {});
  }

  autoSearchDistrict() async {
    try {
      if (!kIsWeb) {
        final result = await InternetAddress.lookup('google.co.in');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            loading = true;
          });
          if (district_mode) {
            var response = await http.get(
                "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$district_id&date=$_value");
            setState(() {
              body = jsonDecode(response.body);
              loading = false;
            });
          } else {
            var response = await http.get(
                "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${pincodeController.text}&date=$_value");
            setState(() {
              body = jsonDecode(response.body);
              loading = false;
            });
          }
        }
      } else {
        setState(() {
          loading = true;
        });
        if (district_mode) {
          var response = await http.get(
              "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$district_id&date=$_value");
          setState(() {
            body = jsonDecode(response.body);
            loading = false;
          });
        } else {
          var response = await http.get(
              "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${pincodeController.text}&date=$_value");
          setState(() {
            body = jsonDecode(response.body);
            loading = false;
          });
          if (body["sessions"]?.length != 0) {
            flutterTts.speak("Session found");
          }
        }
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          content: Text("No Internet Connection Available!")));
      setState(() {
        no_data = true;
      });
    }
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now(),
        lastDate: new DateTime(2022));
    if (picked != null)
      setState(() {
        _value = picked.toString();
        day = picked.day;
        month = picked.month;
        year = picked.year;
        _value = day.formattime00() +
            "-" +
            month.formattime00() +
            "-" +
            year.formattime00();

        dateTextEditingController.text = _value;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: no_data
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      SizedBox(
                          height: size.height * 0.4,
                          width: size.width * 0.7,
                          child: Image.asset("assets/images/no_net.gif")),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "No Internet Connection Available...",
                        style: TextStyle(fontFamily: "Gilroy", fontSize: 21),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          checkData();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Text(
                            "Retry",
                            style: TextStyle(
                                fontFamily: "Gilroy",
                                fontSize: 21,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Find Vaccine",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 35,
                                    fontFamily: 'proximanova'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "V 1.0.1",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                    fontFamily: 'proximanova'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.8,
                                child: Text(
                                  "Made using Setu Cowin API",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontFamily: 'proximanova'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunch(
                                "https://selfregistration.cowin.gov.in/")) {
                              await launch(
                                  "https://selfregistration.cowin.gov.in/");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              "Open COWIN Portal",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFF0A1F59))),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (district_mode == true) {
                                      setState(() {
                                        district_mode = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: district_mode
                                          ? Colors.white
                                          : primaryColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Pin Code",
                                      style: TextStyle(
                                          color: district_mode
                                              ? Color(0xFF0A1F59)
                                              : Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (district_mode != true) {
                                      setState(() {
                                        district_mode = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: district_mode
                                            ? Color(0xFF0A1F59)
                                            : Colors.white),
                                    child: Center(
                                        child: Text(
                                      "District",
                                      style: TextStyle(
                                          color: !district_mode
                                              ? Color(0xFF0A1F59)
                                              : Colors.white),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        district_mode
                            ? Column(
                                children: [
                                  Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 0,
                                          bottom: 2,
                                          right: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            margin: EdgeInsets.all(6),
                                            // padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Icon(Icons.location_city,
                                                  size: 18,
                                                  color: Colors.grey[200]),
                                            ),
                                          ),
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                hint: Text("Select State"),
                                                value: state,
                                                icon: Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                                iconSize: 24,
                                                elevation: 16,
                                                underline: Container(
                                                  height: 0,
                                                ),
                                                isExpanded: true,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Heading',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.8,
                                                    fontSize: 15),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    state = newValue;
                                                    state_id = statesss[
                                                                states.indexOf(
                                                                    newValue)]
                                                            ['state_id']
                                                        .toString();
                                                    getDistricts();
                                                  });
                                                  // getSubData();
                                                },
                                                items: states.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (dynamic value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2,
                                          left: 0,
                                          bottom: 2,
                                          right: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            margin: EdgeInsets.all(6),
                                            // padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Icon(
                                                  Icons.local_attraction,
                                                  size: 18,
                                                  color: Colors.grey[200]),
                                            ),
                                          ),
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                hint: Text("Select State"),
                                                value: district,
                                                icon: Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                                iconSize: 24,
                                                elevation: 16,
                                                underline: Container(
                                                  height: 0,
                                                ),
                                                isExpanded: true,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Heading',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.8,
                                                    fontSize: 15),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    district = newValue;
                                                    district_id = districtsss[
                                                                districts.indexOf(
                                                                    newValue)]
                                                            ['district_id']
                                                        .toString();
                                                  });
                                                  // getSubData();
                                                },
                                                items: districts.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (dynamic value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    // validator: (val) {
                                    //   return val!.length <= 3 ? "Enter College" : null;
                                    // },
                                    readOnly: true,
                                    controller: dateTextEditingController,
                                    obscureText: false,
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                    cursorColor: Colors.grey[800],
                                    decoration: InputDecoration(
                                        // enabled: false,
                                        hintText: "No Date Selected",
                                        labelText: "Select Date",
                                        prefixIcon: Container(
                                          width: 20,
                                          height: 20,
                                          margin: EdgeInsets.all(7),
                                          // padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Icon(Icons.calendar_today,
                                              size: 18,
                                              color: Colors.grey[200]),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _selectDate();
                                          },
                                          child: Container(
                                              width: 50,
                                              height: 20,
                                              margin: EdgeInsets.all(7),
                                              // padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Select",
                                                  style: TextStyle(
                                                      fontFamily: 'proximanova',
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              )),
                                        ),
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color(0xff121212))),
                                        labelStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        focusColor: Colors.grey[800]),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  TextFormField(
                                    validator: (val) {
                                      return val.length != 6
                                          ? "Enter valid Pin Code"
                                          : null;
                                    },
                                    controller: pincodeController,
                                    keyboardType: TextInputType.number,
                                    obscureText: false,
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                    onChanged: (String query) {
                                      if (query.length == 6) {
                                        setState(() {
                                          pinSuffix = true;
                                        });
                                      } else {
                                        setState(() {
                                          pinSuffix = false;
                                        });
                                      }
                                    },
                                    cursorColor: Colors.grey[800],
                                    decoration: InputDecoration(
                                        labelText: "Pin Code",
                                        prefixIcon: Container(
                                          width: 20,
                                          height: 20,
                                          margin: EdgeInsets.all(7),
                                          // padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Icon(Icons.location_on,
                                                size: 18,
                                                color: Colors.grey[200]),
                                          ),
                                        ),
                                        suffixIcon: pinSuffix
                                            ? Icon(Icons.check_circle,
                                                size: 20, color: primaryColor)
                                            : null,
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                            )),
                                        labelStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        focusColor: Colors.grey[800]),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    // validator: (val) {
                                    //   return val!.length <= 3 ? "Enter College" : null;
                                    // },
                                    readOnly: true,
                                    controller: dateTextEditingController,
                                    obscureText: false,
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                    cursorColor: Colors.grey[800],
                                    decoration: InputDecoration(
                                        // enabled: false,
                                        hintText: "No Date Selected",
                                        labelText: "Select Date",
                                        prefixIcon: Container(
                                          width: 20,
                                          height: 20,
                                          margin: EdgeInsets.all(7),
                                          // padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Icon(Icons.calendar_today,
                                              size: 18,
                                              color: Colors.grey[200]),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _selectDate();
                                          },
                                          child: Container(
                                              width: 50,
                                              height: 20,
                                              margin: EdgeInsets.all(7),
                                              // padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Select",
                                                  style: TextStyle(
                                                      fontFamily: 'proximanova',
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              )),
                                        ),
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color(0xff121212))),
                                        labelStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        focusColor: Colors.grey[800]),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (auto_search) {
                              timer.cancel();
                              setState(() {
                                auto_search = false;
                              });
                            } else {
                              setState(() {
                                auto_search = true;
                              });
                              timer = new Timer.periodic(Duration(seconds: 1),
                                  (Timer t) => autoSearchDistrict());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              auto_search
                                  ? "Cancel Auto Search"
                                  : "Auto Search  \u1d2e\u1d31\u1d40\u1d2c",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                            onTap: () async {
                              timer.cancel();
                              try {
                                if (!kIsWeb) {
                                  final result = await InternetAddress.lookup(
                                      'google.co.in');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (district_mode) {
                                      var response = await http.get(Uri.parse(
                                          "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$district_id&date=$_value"));
                                      setState(() {
                                        body = jsonDecode(response.body);
                                        loading = false;
                                      });
                                    } else {
                                      var response = await http.get(
                                          "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${pincodeController.text}&date=$_value");
                                      setState(() {
                                        body = jsonDecode(response.body);
                                        loading = false;
                                      });
                                    }
                                  }
                                } else {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (district_mode) {
                                    var response = await http.get(
                                        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$district_id&date=$_value");
                                    setState(() {
                                      body = jsonDecode(response.body);
                                      loading = false;
                                    });
                                  } else {
                                    var response = await http.get(
                                        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${pincodeController.text}&date=$_value");
                                    setState(() {
                                      body = jsonDecode(response.body);
                                      loading = false;
                                    });
                                  }
                                }
                              } on SocketException catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: primaryColor,
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                            "No Internet Connection Available!")));
                                setState(() {
                                  no_data = true;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: loading
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Continue",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'proximanova',
                                                fontSize: 18),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        body == null
                            ? Container()
                            : body['sessions'] != null
                                ? body['sessions'].length != 0
                                    ? ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: body["sessions"].length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(width: 0.4)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment
                                                    //         .start,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.3,
                                                        child: Text(
                                                          body["sessions"]
                                                              [index]["name"],
                                                          textScaleFactor: 1.0,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: body["sessions"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "fee_type"] ==
                                                                    "Free"
                                                                ? Colors
                                                                    .green[500]
                                                                : Colors
                                                                    .red[500]),
                                                        child: Text(
                                                          body["sessions"]
                                                                  [index]
                                                              ["fee_type"],
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Age: ${body["sessions"][index]["min_age_limit"]}+',
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Vaccine: ${body["sessions"][index]["vaccine"]}',
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Available",
                                                    textScaleFactor: 1.0,
                                                    style:
                                                        TextStyle(fontSize: 9),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      border: Border.all(
                                                          color:
                                                              Colors.grey[200]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      body["sessions"][index][
                                                              "available_capacity"]
                                                          .round()
                                                          .toString(),
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        child: Center(
                                          child: Text(
                                            "No Vaccination Centers available in this date with existing stock. \n Try again later",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                : Container(
                                    child: Text(
                                      "Invalid Data.\nRetry!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

extension IntExtension on int {
  String formattime00() {
    return this < 10 ? "0" + this.toString() : this.toString();
  }
}

class ListItem {
  String value;
  String name;

  ListItem(this.value, this.name);
}
