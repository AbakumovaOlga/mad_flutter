
import 'film.dart';

Future<void> main() async {
  // runApp(MyApp());

  List<Film> originalFilms = [
    new Film("id1", "title1", "picture1", 1.1, "releaseDate1", "description1",
        "russian"),
    new Film("id2", "title2", "picture2", 2.2, "releaseDate2", "description2",
        "russian"),
    new Film("id3", "title3", "picture3", 3.3, "releaseDate3", "description3",
        "english")
  ];

  Future<String> stringFilms(List<Film> films) async {
    String res = "";
    films.forEach((element) {
      res += (element.toString());
      res += "\n";
    });
    return res;
  }

  List<Film> filterFilmsVoteVerage(List<Film> films) {
    return films.where((element) => element.voteVerage>2).toList();
  }

  /* List<Film> filterFilmsCustom (List<Film> films, String param){

  }*/

  print(await stringFilms(originalFilms));
  print('\n');
  print(filterFilmsVoteVerage(originalFilms));
}
