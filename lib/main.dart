import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
        actions: const [
          Icon(
            Icons.search,
            size: 30,
          )
        ],
      ),
      body: ListView(
        children: [
          _listItem(name: 'Ridhi', gmail: 'ridhi16@gmail.com'),
          _listItem(name: 'Mansi', gmail: 'mansi126@gmail.com'),
          _listItem(name: 'Shhradha', gmail: 'shhradha1116@gmail.com'),
          _listItem(name: 'Tulsi', gmail: 'tulsi346@gmail.com'),
          _listItem(name: 'Nilesh sir', gmail: 'nilesh786@gmail.com'),
          _listItem(name: 'Paresh sir', gmail: 'paresh987@gmail.com'),
          _listItem(name: 'Janvi', gmail: 'janvi456@gmail.com'),
          _listItem(name: 'Adnan sir', gmail: 'adnan566@gmail.com'),
          _listItem(name: 'Bhoomika', gmail: 'bhoomi456@gmail.com'),
          _listItem(name: 'Kartik', gmail: 'kartik07@gmail.com'),
          _listItem(name: 'Khushbu', gmail: 'khushi09@gmail.com'),
          _listItem(name: 'mumma', gmail: 'bharti09@gmail.com'),
          _listItem(name: 'mansi', gmail: 'mansi65@gmail.com'),
          _listItem(name: 'pa', gmail: 'keshu45@gmail.com'),
          _listItem(name: 'dadu'),
        ],
      ),
    );
  }
}

Widget _listItem({String? name, String? gmail}) {
  return Card(
    color: Colors.amber[300],
    child: ListTile(
        dense: true,
        onTap: () => ("$name pressed"),
        leading: const Icon(Icons.person),
        //  CircleAvatar(
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(30),
        //     ),
        // ),
        title: Text(
          "$name",
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          "$gmail",
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        trailing: const Icon(Icons.phone)),
  );
}
