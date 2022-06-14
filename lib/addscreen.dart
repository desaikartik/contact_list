import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'https://628dd82ca339dfef87a17642.mockapi.io';

class AddUpdateScreen extends StatefulWidget {
  const AddUpdateScreen({Key? key}) : super(key: key);

  @override
  State<AddUpdateScreen> createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {
  String? name = '';
  String? mobile = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 40, 40),
        title: const Text(
          'New Contact',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      addUser();
                    },
              icon: const Icon(
                Icons.check,
                color: Colors.grey,
              ))
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 100)),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(115, 67, 61, 61),
                  shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.blue,
                  )),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.text,
              onChanged: (n) => name = n,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: Text(
                  'Name',
                ),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (m) => mobile = m,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.call,
                  color: Colors.grey,
                ),
                labelText: 'Mobile',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addUser() async {
    if (name!.isNotEmpty && mobile!.isNotEmpty) {
      setState(() => _isLoading = true);
      http.Response res = await http.post(Uri.parse('$baseUrl/users'), body: {
        'name': '$name',
        'mobile': '$mobile',
      });
      if (res.statusCode == 201) {
        var decoded = jsonDecode(res.body);
        Navigator.pop(context, true);
        setState(() => _isLoading = false);
      }
    }
  }
}
