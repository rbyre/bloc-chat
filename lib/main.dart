import 'package:bloc_chat/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:bloc_chat/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap Materialapp in BlocProvider to make CounterCubit() available to subtree below.
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Chat',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: MyHomeScreen(
          title: 'Hjem Skjerm',
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}
