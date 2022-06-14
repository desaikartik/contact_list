import 'dart:convert';

import 'package:contact_list/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'addscreen.dart';
import 'detailpage.dart';

void main() {
  runApp(const MyApp());
}

String baseUrl = 'https://628dd82ca339dfef87a17642.mockapi.io';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  User? user;
  bool _isLoading = false;
  String name = '';
  String mobile = '';
  bool _isdeleting = false;

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Contact',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {},
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAlert(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => Card(
                color: Colors.black45,
                child: ListTile(
                  onTap: () {
                    //inavigate with id
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailPage(id: users[index].id)));
                  },
                  leading:
                      //CircleAvatar(
                      //child:  ClipRRect(child: Image.network('${users[index].url}',fit: BoxFit.cover,)),),
                      const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    '${users[index].name}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.call),
                ),
              ),
            ),
    );
  }

  void getUsers() async {
    users.clear();
    setState(() => _isLoading = true);
    http.Response res = await http.get(Uri.parse('$baseUrl/users/'));

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((v) {
        setState(() {
          users.add(User(
            id: v['id'],
            name: v['name'],
          ));
        });
      });
      setState(() => _isLoading = false);
    }
  }

  showAlert() async {
    var res = await showDialog(
        builder: (context) => const AddUpdateScreen(), context: context);
    if (res != null && res == true) {
      getUsers();
    }
  }
}

// model
class User {
  final String? id;
  final String? name;
  final String? mobile;
  final String? url;
  final String? createdAt;

  User({this.id, this.name, this.url, this.createdAt, this.mobile});
}
