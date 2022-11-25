import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:onlinedataapi/student.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List map = [];

  Future get_data() async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'users');
    var response = await http.get(url);
    print('Response body: ${response.body}');
    map = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MapList")),
      body: FutureBuilder(
        future: get_data(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: map.length,
              itemBuilder: (context, index) {
                student s = student();

                student.fromJson(map[index]);
                return ExpansionTile(
                  title: Text("${s.name}"),
                  children: [
                    ListTile(
                      title: Text("${s.id}"),
                      leading: Text("${s.email}"),
                    )
                  ],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
