import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas ...',
      'Haciendo palomitas ...',
      'Llama a tu madre ...',
      'Cargando populares ...',
      'Casi estamos ...',
      'Aguanta, que seguro que llega ...',
      'Un informático, el Papa y un mapache entran a un bar ...'
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Un segundito pls'),
          const SizedBox(height: 20),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if ( !snapshot.hasData ) return const Text('Cargando ...');

              return Text( snapshot.data! );
            },
          )
        ],
      ),
    );
  }
}
