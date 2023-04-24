import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    
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
                        onPressed: () {},
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
