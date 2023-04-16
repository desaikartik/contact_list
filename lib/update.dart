import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateScreen extends StatefulWidget {
  final String? name;
  final String? mobile;
  final String? id;
  const UpdateScreen({Key? key, this.name, this.mobile, this.id})
      : super(key: key);
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

String baseUrl = 'https://628dd82ca339dfef87a17642.mockapi.io';

class _UpdateScreenState extends State<UpdateScreen> {
  String? name = '';
  String? mobile = '';
  bool _isLoading = false;
  @override
  void initState() {
    if (widget.name != null && widget.mobile != null) {
      setState(() {
        name = widget.name;
        mobile = widget.mobile;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 40, 40),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        title: const Text(
          'Edit Contact',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (widget.name != null && widget.mobile != null) {
                        updateUser();
                      } else {
                        addUser();
                      }
                    },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 90)),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 220, 175, 111)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 40, left: 40),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              // keyboardType: TextInputType.text,
              initialValue: name,
              decoration: const InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  )),
              onChanged: (n) => name = n,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 50),
            child: TextFormField(
              //  keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              initialValue: mobile,
              decoration: const InputDecoration(
                  hintText: 'mobile',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.call,
                    color: Colors.grey,
                  )),
              onChanged: (m) => mobile = m,
            ),
          ),
        ],
      ),
    );
  }

  void addUser() async {
    if (name!.isNotEmpty && mobile!.isNotEmpty) {
      setState(() => _isLoading = true);
      http.Response res = await http.post(
        Uri.parse('$baseUrl/users'),
        body: {
          "name": "$name",
          "avatar": "$mobile",
        },
      );

      if (res.statusCode == 201) {
        Navigator.pop(context, true);
        // https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/559.jpg
        setState(() => _isLoading = false);
      }
    }
  }

  void updateUser() async {
    if (name!.isNotEmpty && mobile!.isNotEmpty) {
      setState(() => _isLoading = true);
      http.Response res = await http.put(
        Uri.parse('$baseUrl/users/${widget.id}'),
        body: {
          "name": "$name",
          "avatar": "$mobile",
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        Navigator.pop(context, true);
        // https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/559.jpg
        setState(() => _isLoading = false);
      }
    }
  }
}
