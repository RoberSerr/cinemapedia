


import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {

  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
        : 'https://img.freepik.com/vector-gratis/poster-error-404-pagina-no-encontrada-usar-sitio-web_1284-49337.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
        : 'https://d3aa3603f5de3f81cb9fdaa5c591a84d5723e3cb.hosting4cdn.com/wp-content/uploads/2020/11/404-poster-not-found-CG17701-1.png',
        // : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound-400x559.jpg',
      releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );

    static Movie movieDetailsToEntity( MovieDetails moviedb ) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
        : 'https://img.freepik.com/vector-gratis/poster-error-404-pagina-no-encontrada-usar-sitio-web_1284-49337.jpg',
      genreIds: moviedb.genres.map((e) => e.name ).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
        : 'https://d3aa3603f5de3f81cb9fdaa5c591a84d5723e3cb.hosting4cdn.com/wp-content/uploads/2020/11/404-poster-not-found-CG17701-1.png',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );

}