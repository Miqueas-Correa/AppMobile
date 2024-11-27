import 'package:appanimals/helpers/peces/fishes_future.dart';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/search/peces/search_fishes.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';


class ListViewSeparatedScreen extends StatefulWidget {
  const ListViewSeparatedScreen({super.key});

  @override
  State<ListViewSeparatedScreen> createState() =>
      _ListViewSeparatedScreenState();
}

class _ListViewSeparatedScreenState extends State<ListViewSeparatedScreen> {
  late Future<List<Fishes>?> listaPeces;
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    if (isLoading) return;

    isLoading = true;
    setState(() {});

    listaPeces = futureFishesList(page);
    isLoading = false;
    page++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.separated'),
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: SearchFishesDelegate()),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Fishes>?>(
          future: listaPeces,
          builder: (context, AsyncSnapshot<List<Fishes>?> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final fishes = snapshot.data![index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, 'fishes_screen',
                          arguments: <String, dynamic>{'id': fishes.id});
                    },
                    onLongPress: () {
                      print('Long press.....');
                    },
                    leading:
                        Text(fishes.id, style: const TextStyle(fontSize: 15)),
                    title: Text(
                      '${fishes.especie} ${fishes.nombre}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(fishes.color),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: BotoneraNavigation(),
    );
  }
}