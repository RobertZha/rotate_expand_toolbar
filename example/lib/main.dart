import 'package:flutter/material.dart';
import 'package:rotate_expand_toolbar/rotate_expand_toolbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotate Expand Toolbar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rotate Expand Toolbar'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            RotateExpandToolbar(
              expandDuration: const Duration(milliseconds: 500),
              color: Colors.blue,
              iconSize: 24,
              children: [
                RotateExpandToolbarItem(
                  icon: Icons.play_circle_outline_outlined,
                  color: Colors.amber,
                  onTap: () {},
                ),
                RotateExpandToolbarItem(
                  icon: Icons.circle_notifications_outlined,
                  color: Colors.green,
                  onTap: () {},
                ),
                RotateExpandToolbarItem(
                  icon: Icons.flag_circle_outlined,
                  color: Colors.red,
                  onTap: () {},
                ),
                RotateExpandToolbarItem(
                  icon: Icons.add_shopping_cart_outlined,
                  tooltip: "Shopping Cart",
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
