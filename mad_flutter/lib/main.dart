import 'package:flutter/material.dart';

import 'film.dart';

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
    _getFilms().then((valueFilms) {
      setState(() {
        films = valueFilms;
      });
    });
    super.initState();
  }

  void allFilms() {
    _getFilms().then((valueFilms) {
      setState(() {
        films = valueFilms;
        filterLanguage = null;
        filterWeight = false;
      });
    });
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Films'),
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: filterFilms,
                  child: const Text('Find'),
                ),
                ElevatedButton(
                  onPressed: allFilms,
                  child: const Text('All'),
                ),
              ],
            ),
            ...List.generate(films.length, (index) {
              return Flexible(
                  child: FilmWidget(
                      title: films[index].title,
                      picture: films[index].picture,
                      language: convert(films[index].language)));
            })
          ],
        ));
  }

  Future<void> filterFilms() async {
    await _getFilms().then((valueFilms) {
      setState(() {
        if (filterWeight) {
          films = valueFilms
              .where((element) =>
                  element.voteVerage > 2 &&
                  (convert(element.language) == filterLanguage))
              .toList();
        } else {
          films = valueFilms
              .where((element) => convert(element.language) == filterLanguage)
              .toList();
        }
      });
    });
  }
}

class FilmWidget extends StatelessWidget {
  const FilmWidget({
    Key? key,
    required this.title,
    required this.language,
    required this.picture,
  }) : super(key: key);

  final String title;
  final String picture;
  final Language? language;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(children: [
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        Flexible(
            child: Image.asset(
          "assets/images/$picture.png",
          height: 100,
          width: 100,
        )),
        Text(
          language!.toPrettyString(language),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
