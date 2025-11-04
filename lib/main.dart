import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'LDSW Actividad Widgets',
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

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Widgets en Flutter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        // CONTAINER → actúa como contenedor principal
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: Offset(3, 3),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TEXT
              Text(
                'Ejemplo con Widgets básicos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb, color: Colors.amber, size: 30),
                  SizedBox(width: 10),
                  Text(
                    'Palabra aleatoria:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: 10),

              // TEXT dinámico
              Text(
                appState.current.asPascalCase,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 22,
                      color: Colors.deepOrange,
                    ),
              ),
              SizedBox(height: 30),

              // STACK → Superposición de elementos
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade100,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.deepOrange, size: 50),
                  Text(
                    '⭐',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  appState.getNext();
                },
                icon: Icon(Icons.refresh),
                label: Text('Generar nueva palabra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
