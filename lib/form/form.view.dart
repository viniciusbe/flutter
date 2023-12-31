import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_flutter/form/form.viewmodel.dart';
import 'package:hello_flutter/shared/movie.model.dart';
import 'package:provider/provider.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Criar Filme';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(appTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const MovieForm(),
    );
  }
}

class MovieForm extends StatefulWidget {
  const MovieForm({super.key});

  @override
  MovieFormState createState() => MovieFormState();
}

class MovieFormState extends State<MovieForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _durationController = TextEditingController();
  final _ageController = TextEditingController();

  late FormViewModel viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    int? movieId = ModalRoute.of(context)!.settings.arguments as int?;
    viewModel = Provider.of<FormViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchData(movieId);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
          padding: const EdgeInsets.all(8),
          child: Consumer<FormViewModel>(
            builder: (context, value, child) {
              if (value.isLoading()) {
                return const CircularProgressIndicator();
              }
              if (value.isCreated()) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filme criado com sucesso!')),
                  );
                  Navigator.of(context).pop();
                });
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Movie movie = value.formModel.movie;
                _nameController.text = movie.name ?? '';
                _synopsisController.text = movie.synopsis ?? '';
                _durationController.text = (movie.duration ?? '').toString();
                _ageController.text = (movie.age ?? '').toString();
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Nome', hintText: 'Openheimer'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    controller: _nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Sinopse',
                        hintText:
                            'Oppenheimer é um filme histórico de drama dirigido por ...'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    controller: _synopsisController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Duração (minutos)', hintText: '120'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _durationController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Classificação indicativa'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    controller: _ageController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Criando Filme...')),
                          );
                          viewModel.createData(
                              _nameController.text,
                              _synopsisController.text,
                              int.parse(_durationController.text),
                              int.parse(_ageController.text));
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
