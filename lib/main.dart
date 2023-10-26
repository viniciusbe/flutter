import 'package:flutter/material.dart';
import 'package:hello_flutter/model.dart';
import 'package:hello_flutter/rest_api_service.dart';
import 'package:hello_flutter/viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Movie List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late MovieListViewModel _viewModel;
  late Future<List<Movie>> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<List<Movie>>(
              future: futureMovie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Movie> list = snapshot.data!;

                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        return ListTile(title: Text(list[index].name));
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
