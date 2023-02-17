import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _searchcontroller = TextEditingController();
  String title = "";
  String year = "";
  String actors = "";
  var poster = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search App',
      theme: new ThemeData(
        scaffoldBackgroundColor: Colors.yellow.shade100, 
        primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Search App'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                TextField(
                    controller: _searchcontroller,
                    decoration: InputDecoration(
                        hintText: "Search Movie Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
                MaterialButton(
                    color: Colors.amber,
                    onPressed: () {
                      _loadMovie(_searchcontroller.text);
                    },
                    child: const Text("Press Here")),
                const SizedBox(height: 10),
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(children: [
                      Image.network(
                        poster,
                        height: 250,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              height: 350,
                              width: 350,
                              fit: BoxFit.cover,
                              'assets/moviePic/2503508.png');
                        },
                      ),

                      //Image.asset(posters),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(year),
                      Text(actors),
                    ]),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMovie(String search) async {
    var url = Uri.parse('https://www.omdbapi.com/?t=$search&apikey=c0abbc67');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      var genre = parsedJson['Genre'];
      title = parsedJson['Title'];
      year = parsedJson['Year'];
      actors = parsedJson['Actors'];
      poster = parsedJson['Poster'];


      setState(() {});
      print(response.body);
    } else {
      print("Failed");
    }
  }
}
