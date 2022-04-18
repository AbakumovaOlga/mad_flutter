import 'package:flutter/material.dart';

import 'film.dart';
/*void main() {
  List<Film> originalFilms = [
    new Film(
        id: "id1",
        title: "title1",
        picture: "picture1",
        voteVerage: 1.1,
        releaseDate: "releaseDate1",
        description: "description1",
        language: "russian"),
    new Film(
        id: "id2",
        title: "title2",
        picture: "picture2",
        voteVerage: 2.2,
        releaseDate: "releaseDate2",
        description: "description2",
        language: "russian"),
    new Film(
        id: "id3",
        title: "title3",
        picture: "picture3",
        voteVerage: 3.3,
        releaseDate: "releaseDate3",
        description: "description3",
        language: "english")
  ];


  Future<List<Film>> listFilms() async {
    return originalFilms;
  }

  Future<String> stringFilms(List<Film> films) async {
    String res = "";
    films.forEach((element) {
      res += (element.toString()) + "\n";
    });
    return res;
  }

  List<Film> filterFilmsVoteVerage(List<Film> films, double param) {
    return films.where((element) => element.voteVerage > param).toList();
  }


  runApp(MyApp());
}*/

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "_key",
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('To do list'),
          centerTitle: true,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: FilmWidget("title1", "picture1", Language.english)),
              Flexible(
                  child: FilmWidget("title2", "picture2", Language.russian))
            ]),
      ),
    );
  }
}

class FilmWidget extends StatefulWidget {
  String _title;
  String _picture;
  Language _language;

  @override
  _FilmWidget createState() => _FilmWidget(_title, _picture, _language);

  FilmWidget(this._title, this._picture, this._language);
}

class _FilmWidget extends State<FilmWidget> {
  String _title;
  String _picture;
  Language _language;

  _FilmWidget(this._title, this._picture, this._language);

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(children: [
        Text(
          _picture,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        Image.asset(
          "assets/images/$_picture.png",
          height: 100,
          width: 100,
        ),
        Text(
          _language.toPrettyString(_language),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
