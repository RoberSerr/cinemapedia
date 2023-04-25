import 'dart:async';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

import 'package:cinemapedia/domain/entities/movie.dart';



typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();



  Timer? _debounceTimer;

  SearchMovieDelegate({ 
    required this.searchMovies,
    required this.initialMovies
  });


  void clearStreams(){
    debouncedMovies.close();
  }


  void _onQueryChanged( String query ) {

    isLoadingStream.add(true);

    if ( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer( const Duration( milliseconds: 500 ), () async {

      // if( query.isEmpty ) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await searchMovies( query);
      
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);

    });

  }

  @override
  String get searchFieldLabel => 'Buscar película...';
  
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [

      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if( snapshot.data ?? false ) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '', 
                icon: const Icon(Icons.refresh_rounded)
              )
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '', 
              icon: const Icon(Icons.clear)
            ),
          );
        },
      ),
      

    ]; 

  }

  @override
  Widget? buildLeading(BuildContext context) {
    
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {

              clearStreams();

              close(context, movie);

            }
          ),
        );
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);
    
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {

              clearStreams();

              close(context, movie);

            }
          ),
        );
      },
    );

  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          onMovieSelected(context, movie);
        },
        child: Row(
          children: [
      
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
      
            const SizedBox(width: 10),
      
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( movie.title, style: textStyles.titleMedium ),
                  const SizedBox(height: 2),
                  Text(movie.overview, maxLines: 3, overflow: TextOverflow.ellipsis),
      
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 3),
                      Text( 
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            ),
            
      
          ],
        ),
      ),
    );
  }
}