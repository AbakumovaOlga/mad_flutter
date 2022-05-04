
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
      debugShowCheckedModeBanner: false,
      title: "Films",
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ConvertLanguage {
  List<Film> films = [];
  bool filterWeight = false;
  Language? filterLanguage;

  @override
  void initState() {
    _getFilms().then((value) {
      setState(() {
        films = value;
      });
    });
    super.initState();
  }

  Future<List<Film>> _getFilms() async {
    await Future.delayed(const Duration(seconds: 1));
    return [

      const Film(
          id: "id3",
          title: "title3",
          picture: "picture3",
          voteVerage: 3.3,
          releaseDate: "releaseDate3",
          description: "description3",
          language: "english"),
      const Film(
          id: "id2",
          title: "title2",
          picture: "picture2",
          voteVerage: 2.2,
          releaseDate: "releaseDate2",
          description: "description2",
          language: "russian"),
      const Film(
          id: "id1",
          title: "title1",
          picture: "picture1",
          voteVerage: 1.1,
          releaseDate: "releaseDate1",
          description: "description1",
          language: "russian"),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('To do list'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Checkbox(
                    value: filterWeight,
                    onChanged: (bool? changeValue) {
                      setState(() {
                        filterWeight = changeValue ?? false;
                      });
                    }),
                const Text("Only good")
              ],
            ),
            ...List.generate(Language.values.length, (index) {
              return ListTile(
                title: Text(Language.values[index].toString()),
                leading: Radio<Language>(
                  value: Language.values[index],
                  groupValue: filterLanguage,
                  onChanged: (Language? value) {
                    setState(() {
                      filterLanguage = value;
                    });
                  },
                ),
              );
            }),
            ElevatedButton(
              onPressed: filterFilms,
              child: const Text('Find'),
            ),

            ...List.generate(films.length, (index) {
              return Flexible(
                  child: FilmWidget(films[index].title, films[index].picture,
                      convert(films[index].language)));
            })
          ],
        ));
  }

  Future<void> filterFilms() async {
    await _getFilms().then((valueFilms) {
      setState(() {
        if (filterWeight) {
          films =
              valueFilms.where((element) => element.voteVerage > 2 && (convert(element.language)==filterLanguage)).toList();
        } else {
          films = valueFilms.where((element) => convert(element.language)==filterLanguage).toList();
        }
      });
    });
  }
}

class FilmWidget extends StatefulWidget {
  String _title;
  String _picture;
  Language? _language;

  @override
  _FilmWidget createState() => _FilmWidget(_title, _picture, _language);

  FilmWidget(this._title, this._picture, this._language);
}

class _FilmWidget extends State<FilmWidget> {
  String _title;
  String _picture;
  Language? _language;

  _FilmWidget(this._title, this._picture, this._language);

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(children: [
        Text(
          _title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        Flexible(
            child: Image.asset(
          "assets/images/$_picture.png",
          height: 100,
          width: 100,
        )),
        Text(
          _language!.toPrettyString(_language),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
