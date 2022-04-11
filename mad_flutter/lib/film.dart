import 'package:enum_to_string/enum_to_string.dart';


abstract class FilmAbstract
{
  late final String id;
  late final String title;
  late final String picture;
  late final double voteVerage;
  late final String releaseDate;
  late final String description;
  late final String language;

}

class Film extends FilmAbstract with ConvertLanguage{
  Film(String id, String title, String picture, double voteVerage, String releaseDate, String description, String language){
    this.id=id;
    this.title=title;
    this.picture=picture;
    this.voteVerage=voteVerage;
    this.releaseDate=releaseDate;
    this.description=description;
    this.language=language;
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.id+" "+this.title +" " +toPrettyString(convert(this.language))+" ";
  }


}

enum Language {
  russian,
  english
}

mixin ConvertLanguage{
  Language? convert(String language){
    return EnumToString.fromString(Language.values, language);
  }
}

extension PrettyLanguage on Film {
  String toPrettyString(Language? language){
    switch (language) {
      case Language.russian : return "Русский";
      case Language.english : return "Английский";
      default: return "Null";

    }
  }
}