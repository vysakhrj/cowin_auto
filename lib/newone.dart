import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String name = "Praveen";
  Color mainColor = Colors.blue.withRed(90);
  double pending = 24, approved = 36, declined = 12;
  int index = 0;

  List<ApprovaList> approvedRequests = [
    ApprovaList(
        name: "Dusthan",
        department: "department3",
        refillRequest: 14550,
        walletBalance: 10,
        date: DateTime.now(),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Kumaran",
        department: "department2",
        refillRequest: 10,
        walletBalance: 3435,
        date: DateTime.now().subtract(Duration(days: 5)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Vysakh",
        department: "department4",
        refillRequest: 1,
        walletBalance: 0,
        date: DateTime.now().subtract(Duration(days: 2)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Kanaran",
        department: "department1",
        refillRequest: 1450,
        walletBalance: 345,
        date: DateTime.now().subtract(Duration(days: 1)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
  ];
  List<ApprovaList> pendingRequests = [
    ApprovaList(
        name: "Dusthan",
        department: "department3",
        refillRequest: 14550,
        walletBalance: 10,
        date: DateTime.now(),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Kumaran",
        department: "department2",
        refillRequest: 10,
        walletBalance: 3435,
        date: DateTime.now().subtract(Duration(days: 5)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Vysakh",
        department: "department4",
        refillRequest: 1,
        walletBalance: 0,
        date: DateTime.now().subtract(Duration(days: 2)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Kanaran",
        department: "department1",
        refillRequest: 1450,
        walletBalance: 345,
        date: DateTime.now().subtract(Duration(days: 1)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
  ];
  List<ApprovaList> declinedRequests = [
    ApprovaList(
        name: "Dusthan",
        department: "department3",
        refillRequest: 14550,
        walletBalance: 10,
        date: DateTime.now(),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Kumaran",
        department: "department2",
        refillRequest: 10,
        walletBalance: 3435,
        date: DateTime.now().subtract(Duration(days: 5)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Vysakh",
        department: "department4",
        refillRequest: 1,
        walletBalance: 0,
        date: DateTime.now().subtract(Duration(days: 2)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    ApprovaList(
        name: "Kanaran",
        department: "department1",
        refillRequest: 1450,
        walletBalance: 345,
        date: DateTime.now().subtract(Duration(days: 1)),
        imgUrl:
            "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withRed(100),
        toolbarHeight: 65,
        leading: Icon(Icons.menu),
        title: Text("Admin"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(Icons.person),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  children: [
                    Text(
                      "Dear $name,",
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 26,
                          fontFamily: 'Comforta'),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  blurRadius: 4.26, // soften the shadow
                                  spreadRadius: 0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    2, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          width: 90,
                          height: 90,
                          child: Center(
                            child: Text(
                              "${pending.toInt()}",
                              style: TextStyle(
                                  color: Colors.blue.withRed(90),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Comforta'),
                            ),
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comforta'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.2),
                                  blurRadius: 4.26, // soften the shadow
                                  spreadRadius: 0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    2, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              color: Colors.green.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          width: 90,
                          height: 90,
                          child: Center(
                            child: Text(
                              "${approved.toInt()}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Comforta'),
                            ),
                          ),
                        ),
                        Text(
                          "Approved",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comforta'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.2),
                                  blurRadius: 4.26, // soften the shadow
                                  spreadRadius: 0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    2, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              color: Colors.red.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          width: 90,
                          height: 90,
                          child: Center(
                            child: Text(
                              "${declined.toInt()}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Comforta'),
                            ),
                          ),
                        ),
                        Text(
                          "Declined",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comforta'),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue.withRed(90),
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (index != 0) {
                              setState(() {
                                index = 0;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index != 0
                                    ? Colors.white
                                    : Colors.blue.withRed(90)),
                            child: Center(
                                child: Text(
                              "Pending",
                              style: TextStyle(
                                  color: index != 0
                                      ? Colors.blue.withRed(90)
                                      : Colors.white),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (index != 1) {
                              setState(() {
                                index = 1;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == 1
                                    ? Colors.blue.withRed(90)
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              "Approved",
                              style: TextStyle(
                                  color: !(index == 1)
                                      ? Colors.blue.withRed(90)
                                      : Colors.white),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (index != 2) {
                              setState(() {
                                index = 2;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == 2
                                    ? Colors.blue.withRed(90)
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              "Declined",
                              style: TextStyle(
                                  color: !(index == 2)
                                      ? Colors.blue.withRed(90)
                                      : Colors.white),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                IndexedStack(
                  index: index,
                  children: [
                    pendingList(size),
                    approvedList(size),
                    declinedList(size)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pendingList(Size size) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: size.width,
          // height: size.height,
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pendingRequests.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.26, // soften the shadow
                          spreadRadius: 0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            1, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: Image.network(
                                    pendingRequests[index].imgUrl,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${pendingRequests[index].name}"),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        "${pendingRequests[index].department}"),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text("Refill Amount"),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text("Wallet Balance"),
                                    SizedBox(
                                      height: 3,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        "${pendingRequests[index].date.toString().substring(0, 10)}"),
                                    SizedBox(
                                      height: 23,
                                    ),
                                    Text(
                                        "₹ ${pendingRequests[index].refillRequest}"),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        "₹ ${pendingRequests[index].walletBalance}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "Approve",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "Decline",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget approvedList(Size size) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: approvedRequests.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.26, // soften the shadow
                          spreadRadius: 0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            1, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              width: 64,
                              height: 64,
                              child: Image.network(
                                approvedRequests[index].imgUrl,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${pendingRequests[index].name}"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("${pendingRequests[index].department}"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("Refill Amount"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("Wallet Balance"),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "${pendingRequests[index].date.toString().substring(0, 10)}"),
                                SizedBox(
                                  height: 23,
                                ),
                                Text(
                                    "₹ ${pendingRequests[index].refillRequest}"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    "₹ ${pendingRequests[index].walletBalance}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget declinedList(Size size) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: declinedRequests.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.26, // soften the shadow
                          spreadRadius: 0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            1, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              width: 64,
                              height: 64,
                              child: Image.network(
                                declinedRequests[index].imgUrl,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${pendingRequests[index].name}"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("${pendingRequests[index].department}"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("Refill Amount"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("Wallet Balance"),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "${pendingRequests[index].date.toString().substring(0, 10)}"),
                                SizedBox(
                                  height: 23,
                                ),
                                Text(
                                    "₹ ${pendingRequests[index].refillRequest}"),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    "₹ ${pendingRequests[index].walletBalance}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}

class ApprovaList {
  String name;
  String department;
  DateTime date;
  double refillRequest;
  double walletBalance;
  String imgUrl;
  ApprovaList(
      {this.name,
      this.department,
      this.date,
      this.refillRequest,
      this.walletBalance,
      this.imgUrl});
}
