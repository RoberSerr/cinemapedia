import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../delegates/search_movie_delegate.dart';
import '../../providers/providers.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class CustomAppbar extends ConsumerWidget {
  
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.movie_outlined, color: colors.primary),
                    const SizedBox(width: 10),
                    const Text('Cinemapedia'),
                    const Spacer(),
                    IconButton(
                        onPressed: () {

                          final searchedMovies = ref.read( searchedMoviesProvider );

                          final searchQuery = ref.read( searchQueryProvider );

                        showSearch<Movie?>(
                          query: searchQuery,
                          context: context,
                          delegate: SearchMovieDelegate(
                            initialMovies: searchedMovies,
                            searchMovies: ref.read( searchedMoviesProvider.notifier ).searchMoviesByQuery
                          )
                        ).then((movie) {
                          if( movie == null ) return;
                          context.push('/movie/${ movie.id }');
                        });
                        },
                        icon: Icon(Icons.search, color: colors.primary))
                  ],
                ),
                const SizedBox( height: 20 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
