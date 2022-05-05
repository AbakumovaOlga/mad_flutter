class FilmCardModel {
  const FilmCardModel({
    required this.id,
    required this.title,
    this.picture = '',
    this.description = '',
    this.releaseDate = '',
    this.voteAverage = 0,
  });

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
}
