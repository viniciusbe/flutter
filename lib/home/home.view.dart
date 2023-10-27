import 'package:flutter/material.dart';
import 'package:hello_flutter/form/form.view.dart';
import 'package:hello_flutter/home/home.model.dart';
import 'package:hello_flutter/home/home.viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: Consumer<HomeViewModel>(builder: (_, model, child) {
        if (model.isLoading) {
          return const CircularProgressIndicator();
        }
        List<Movie> list = model.homeModel.items;

        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              return ListTile(title: Text(list[index].name));
            });
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
