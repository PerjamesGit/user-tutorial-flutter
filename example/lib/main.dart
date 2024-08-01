import 'package:flutter/material.dart';
import 'package:tutorial/tutorial.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TutorialService.init(
        padding: const EdgeInsets.all(12),
      );
      TutorialService.startTutorial(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Tutorial(
              builder: (context, key) {
                return Text(
                  key: key,
                  'You have pushed the button this many times:',
                );
              },
              order: 1,
              instruction: 'This is a text field',
              category: 'home',
            ),
          ],
        ),
      ),
      floatingActionButton: Tutorial(
        category: 'home',
        order: 0,
        instruction: 'This is Floating Action Button',
        builder: (BuildContext context, GlobalKey<State<StatefulWidget>> key) {
          return FloatingActionButton(
            key: key,
            tooltip: 'Increment',
            onPressed: () {},
            child: const Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
