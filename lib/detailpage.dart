import 'dart:convert';

import 'package:contact_list/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class DetailPage extends StatefulWidget {
  final String? id;
  const DetailPage({Key? key, this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

String baseUrl = 'https://628dd82ca339dfef87a17642.mockapi.io';

class _DetailPageState extends State<DetailPage> {
  List<User> users = [];
  List<User> id = [];
  User? user;
  String? name = '';
  String? mobile = '';

  bool _isLoading = false;
  bool _isdeleting = false;

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
              onPressed: () {
                showUpdateAlert(
                  id: user?.id,
                  name: user?.name,
                  mobile: user?.mobile,
                );
              },
              icon: const Icon(Icons.edit)),
          const SizedBox(width: 15),
          IconButton(
              onPressed: _isdeleting
                  ? null
                  : () {
                      deleteEntry(user?.id);
                    },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
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
                child: Text(user?.name ?? '',
                    style: const TextStyle(fontSize: 25)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 5, left: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.green,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  user?.mobile ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(width: 90),
                const Icon(
                  Icons.video_call,
                  color: Colors.green,
                  size: 30,
                ),
                const SizedBox(width: 5),
                const Icon(
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
                  children: [
                    const Icon(
                      Icons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Voice Call',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '+${user?.mobile ?? ''}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Video Call',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '+${user?.mobile ?? ''}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    const Icon(
                      Icons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Message',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '+${user?.mobile ?? ''}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
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
    users.clear();
    setState(() => _isLoading = true);
    users.clear();
    http.Response res =
        await http.get(Uri.parse('$baseUrl/users/${widget.id}'));

    debugPrint(widget.id);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      setState(() {
        user = User(
          id: decoded['id'],
          name: decoded['name'],
          mobile: decoded['mobile'],
          url: decoded['avatar'],
          createdAt: decoded['createdAt'],
        );
      });
      setState(() => _isLoading = false);
    }
  }

  void deleteEntry(String? id) async {
    setState(() => _isdeleting = true);
    http.Response res = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (res.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
      getUser();
      setState(() => _isdeleting = false);
    }
  }

  void showUpdateAlert({String? name, String? mobile, String? id}) async {
    var res = await showDialog(
        context: context,
        builder: (context) => UpdateScreen(
              name: name,
              mobile: mobile,
              id: id,
            ));
    if (res != null && res == true) {
      getUser();
    }
  }
}
