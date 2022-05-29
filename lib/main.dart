import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        title:const  Text(
          'Contact',
          style:  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
      floatingActionButton: FloatingActionButton(onPressed: (){},child: const Icon(Icons.add,color: Colors.white,size: 30,),),
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
                  trailing: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }

  void getUsers() async {
    setState(() => _isLoading = true);
    http.Response res = await http.get(Uri.parse('$baseUrl/users/'));

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((v) {
        setState(() {
          users.add(User(
            id: v['id'],
            name: v['name'],
            url: v['avatar'],
            createdAt: v['createdAt'],
          ));
        });
      });
      setState(() => _isLoading = false);
    }
  }
}

// model
class User {
  final String? id;
  final String? name;
  final String? url;
  final String? createdAt;

  User({this.id, this.name, this.url, this.createdAt});
}

class DetailPage extends StatefulWidget {
  final String? id;
  const DetailPage({Key? key, this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(96, 89, 83, 83),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 175, 111),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {},
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        // leading: Icon(Icons.more_horiz),
      ),
      body: Column(
        children: [
          Container(
            height: 270,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 175, 111),
                borderRadius: BorderRadius.circular(3)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child:
                    Text("${user?.name}", style: const TextStyle(fontSize: 25)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
            child: Row(
              children: const [
                Icon(
                  Icons.phone,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Phone',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(width: 180),
                Icon(
                  Icons.video_call,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.message,
                  color: Colors.blue,
                  size: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Voice Call',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Video Call',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: const [
                    Icon(
                      Icons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Message',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 100, right: 150),
            child: Text(
              'QR code business card',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  void getUser() async {
    http.Response res =
        await http.get(Uri.parse('$baseUrl/users/${widget.id}'));

    print(widget.id);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      setState(() {
        user = User(
          name: decoded['name'],
          url: decoded['avatar'],
          createdAt: decoded['createdAt'],
        );
      });
    }
  }
}
