import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/bloc.dart';
import 'Bloc/event_bloc.dart';
import 'Presentation/HomeScreen.dart';
import 'Repository/ApiService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter BLoC Example',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PostBloc(repository: PostRepository())..add(FetchPosts()),
        child: HomePage(),
      ),
    );
  }
}

