import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:badone/connectionLinks/mongoDBModel.dart';
import 'package:badone/connectionLinks/mongoDbFunctions.dart';
import 'package:badone/router/auto_route.gr.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 33, 33, 33),
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Color.fromARGB(255, 24, 24, 24),
          automaticallyImplyLeading: false,
          title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                  onTap: () => context.router.push(SearchRoute()),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 61, 61, 61),
                      ),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 30,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Search Product",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 184, 184, 184)),
                          ))))),
        ),
        body: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: MongoDatabase.getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      var totalData = snapshot.data.length;
                      print("Total Data" + totalData.toString());
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          MongoDbModel data1 =
                              MongoDbModel.fromJson(snapshot.data[index]);
                          print(data1.name);

                          return displayCard(
                            MongoDbModel.fromJson(snapshot.data[index]),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("no data"),
                      );
                    }
                  }
                }),
          )
        ]));
  }

  Widget displayCard(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Row(children: []),
      ),
    );
  }
}

// Text("${data.name}"),
//           Spacer(),
//           Text("${data.subject}"),
//           Spacer(),
//           Text("${data.grade}"),
//           Spacer(),
//           IconButton(
//               onPressed: () async {
//                 print("${data.id}");
//                 await MongoDatabase.delete(data);
//                 setState(() {});
//               },
//               icon: Icon(Icons.delete)),
//           GestureDetector(
//               child: Text(
//                 'Edit',
//                 style: TextStyle(color: Colors.blue),
//               ),
//               onTap: () async {
//                 // await context.router.push(ThirdRoute(id: data.id));
//                 setState(() {});
//               }),
