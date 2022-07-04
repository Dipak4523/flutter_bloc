
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Detail"),
      ),
      body: Container(),
    );
  }
}
