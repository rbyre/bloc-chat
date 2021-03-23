import 'package:bloc_chat/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bloc_chat/presentation/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Chat',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
