import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'LDSW Actividad Widgets + API',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  String pokemonName = "";
  String imageUrl = "";
  bool loading = false;

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  Future<void> fetchPokemon(String name) async {
    loading = true;
    notifyListeners();

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      pokemonName = data['name'];
      imageUrl = data['sprites']['front_default'];
    } else {
      pokemonName = "Pokémon no encontrado";
      imageUrl = "";
    }

    loading = false;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets y API en Flutter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(3, 3),
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ejemplo con Widgets + API',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lightbulb, color: Colors.amber, size: 30),
                    const SizedBox(width: 10),
                    Text(
                      'Palabra aleatoria:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  appState.current.asPascalCase,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 22,
                        color: Colors.deepOrange,
                      ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.getNext();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Generar nueva palabra'),
                ),
                const Divider(height: 40, thickness: 2),
                const Text(
                  'Consulta de Pokémon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre del Pokémon (en inglés)',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    final name = _controller.text.trim().toLowerCase();
                    if (name.isNotEmpty) {
                      appState.fetchPokemon(name);
                    }
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar Pokémon'),
                ),
                const SizedBox(height: 20),
                if (appState.loading)
                  const CircularProgressIndicator()
                else if (appState.pokemonName.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        appState.pokemonName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (appState.imageUrl.isNotEmpty)
                        Image.network(appState.imageUrl, height: 120),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
