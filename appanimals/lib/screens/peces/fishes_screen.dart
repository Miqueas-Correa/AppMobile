import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/providers/peces/fishes_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FishesDetailScreen extends StatelessWidget {
  final Fishes? fishes;

  const FishesDetailScreen({super.key, this.fishes});

  @override
  Widget build(BuildContext context) {
    // Obtiene los argumentos pasados
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Size size = MediaQuery.of(context).size;
    final fishesProvider = Provider.of<FishesProvider>(context);

    return Scaffold(
        body: FutureBuilder(
            future: fishesProvider.getFishesById(int.parse(args['id'])),
            builder: (context, AsyncSnapshot<Fishes?> snapshot) {
              final Fishes? data = snapshot.data;
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                );
              }
            }));
  }
}

// ignore: unused_element
class _SliverGrid extends StatelessWidget {
  const _SliverGrid({
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250.0,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15.0,
          childAspectRatio: 4.0,
          mainAxisExtent: 200),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.greenAccent[100 * (index % 9)],
            child: Text('grid item $index'),
          );
        },
        childCount: 20,
      ),
    );
  }
}

class _SliverBody extends StatelessWidget {
  final Size size;
  final Fishes? data;

  // ignore: use_super_parameters
  const _SliverBody(
    this.size,
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text("No hay detalles para mostrar"),
      ),
      Container(
        width: size.width * 0.30,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                height: 150,
                width: 100,
                placeholder: const AssetImage('assets/images/loading.gif'),
                image: const NetworkImage('https://via.placeholder.com/150'),
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/images/placeholder_card.png'),
                fit: BoxFit.cover,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width * 0.65),
              child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text(
                    'Sit qui officia minim incididunt nostrud ad proident Lorem voluptate. Et dolor quis pariatur dolore voluptate Lorem anim incididunt. Adipisicing esse velit mollit id. Adipisicing reprehenderit mollit elit nisi mollit excepteur reprehenderit ullamco commodo ipsum et.Adipisicing reprehenderit mollit elit nisi mollit excepteur reprehenderit ullamco commodo ipsum et.',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ],
        ),
      ),
    ]));
  }
}

class _SliverAppBar extends StatelessWidget {
  final Size size;
  final Fishes? data;

  // ignore: use_super_parameters
  const _SliverAppBar(
    this.size,
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey,
      elevation: 10,
      title: Text(
        '${data?.especie} ${data?.nombre}',
        style: const TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
      ),
      titleSpacing: 30,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 25,
          )),
      leadingWidth: 30,
      centerTitle: true,
      floating: true,
      pinned: true,
      snap: false,
      toolbarHeight: 80,
      expandedHeight: 250,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            color: const Color.fromRGBO(0, 0, 0, 0.3),
            child: Text(
              data?.color ?? '',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          //background: FadeInImage(
           // width: double.infinity,
           // height: 250,
            //placeholder: const AssetImage('assets/images/loading.gif'),
            //imageErrorBuilder: (context, error, stackTrace) =>
                //Image.asset('assets/images/placeholder.png'),
            //image: NetworkImage('${data?.image}'),
            //fit: BoxFit.cover,
          //)
          ),
    );
  }
}