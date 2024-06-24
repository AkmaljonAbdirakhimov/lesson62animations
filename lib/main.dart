import 'package:flutter/material.dart';
import 'package:myapp/external_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData = ThemeData.light();

  @override
  void initState() {
    super.initState();

    // Future.delayed(const Duration(seconds: 5), () {
    //   _themeData = ThemeData.dark();
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimatedTheme(
        data: _themeData,
        duration: const Duration(seconds: 1),
        child: const ExternalAnimation(),
      ),
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  void _addItem() {
    final newIndex = _items.length; // Calculate the index for the new item
    final newItem = 'Item ${newIndex + 1}'; // Create a new item

    // Update the underlying data list
    setState(() {
      _items.add(newItem);
    });

    // Insert the new item into the AnimatedList
    _listKey.currentState!.insertItem(newIndex);
  }

  void _removeItem(int index) {
    final removedItem = _items[index];

    // Remove the item from the data list
    setState(() {
      _items.removeAt(index);
    });

    // Remove the item from the AnimatedList with animation
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => buildItem(removedItem, animation),
    );
  }

  Widget buildItem(String item, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: ListTile(
        title: Text(item), // Display the item's text
        trailing: IconButton(
          icon: Icon(Icons.delete), // Display a delete icon
          onPressed: () => _removeItem(
            _items.indexOf(item),
          ), // Remove the item when pressed
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList Example'), // Set the app bar title
      ),
      body: const Column(
        children: [
          Center(
            child: Hero(
              tag: "textHero",
              child: Material(
                child: Text("Bu HERO animatsiyasi"),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return SecondScreen();
          }));
        }, // Add a new item when the FAB is pressed
        child: Icon(Icons.add), // Display a plus icon
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Hero(
          tag: "textHero",
          child: Material(
            child: Text("Bu HERO animatsiyasi"),
          ),
        ),
      ),
    );
  }
}
