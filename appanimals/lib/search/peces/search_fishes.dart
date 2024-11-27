import 'package:flutter/material.dart';
import 'package:appanimals/helpers/peces/fishes_future.dart';
import 'package:appanimals/models/peces/fishes_model.dart';

class SearchFishesDelegate extends SearchDelegate {
  void reset() {
    query = '';
    clearActiveSearch();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => reset(), icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          reset();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    print('build results..............');
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List<Fishes>?>(
      future: searchFishes(query),
      builder: (context, AsyncSnapshot<List<Fishes>?> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final fishes = snapshot.data![index];
              return ListTile(
                onTap: () {
                  /* showResults(context); */
                  Navigator.pushNamed(context, 'fishes_screen',
                      arguments: <String, dynamic>{'id': fishes.id});
                },
                leading: Text(fishes.id, style: const TextStyle(fontSize: 15)),
                title: Text(
                  '${fishes.especie} ${fishes.nombre}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(fishes.color),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: 80,
            ),
          );
        } else {
          return const Center(
            child: Icon(
              Icons.find_in_page,
              size: 80,
            ),
          );
        }
      },
    );
  }
}