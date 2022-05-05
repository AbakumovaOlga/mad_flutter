import 'package:enum_to_string/enum_to_string.dart';

abstract class FilmAbstract {
  final String id;
  final String title;
  final String picture;
  final double voteVerage;
  final String releaseDate;
  final String description;
  final String language;

  const FilmAbstract(this.id, this.title, this.picture, this.voteVerage,
      this.releaseDate, this.description, this.language);
}

class Film extends FilmAbstract with ConvertLanguage {
  const Film(
      {required String id,
      required String title,
      required String picture,
      required double voteVerage,
      required String releaseDate,
      required String description,
      required String language})
      : super(
            id, title, picture, voteVerage, releaseDate, description, language);

  /*Film(String id, String title, String picture, double voteVerage, String releaseDate, String description, String language)
      :super (id, title,picture,voteVerage,releaseDate,description,language){
    this.id=id;
    this.title=title;
    this.picture=picture;
    this.voteVerage=voteVerage;
    this.releaseDate=releaseDate;
    this.description=description;
    this.language=language;
  }*/

  @override
  String toString() {
    return id +
        " " +
        title +
        " " +
        convert(language)!.toPrettyString(convert(language)) +
        " ";
  }
}

enum Language { russian, english }

mixin ConvertLanguage {
  Language? convert(String language) {
    return EnumToString.fromString(Language.values, language);
  }
}

extension PrettyLanguage on Language {
  String toPrettyString(Language? language) {
    switch (language) {
      case Language.russian:
        return "Русский";
      case Language.english:
        return "Английский";
      default:
        return "Null";
    }
  }
}
