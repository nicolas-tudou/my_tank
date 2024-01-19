import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/game_model.dart';
import 'pages/main.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [Provider(create: (context) => GameModel())],
      child: MaterialApp(
        home: GamgeWidget(),
      ),
    ),
  );
}
