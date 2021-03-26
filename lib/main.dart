import 'package:bloc_chat/logic/cubit/firebase_cubit.dart';
import 'package:bloc_chat/users.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bloc_chat/presentation/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCubit.addRandomUsers(Users.initUsers);
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key key,
    @required this.appRouter,
    @required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FirebaseCubit>(
          create: (context) => FirebaseCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
