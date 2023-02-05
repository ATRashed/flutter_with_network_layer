import 'package:flutter/material.dart';
import 'package:flutter_with_network_layer/pages/home_page.dart';
import 'package:flutter_with_network_layer/providers/album_details_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumDetailsProvider>(
            create: (context) => AlbumDetailsProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        home: const HomePage(),
      ),
    );
  }
}
