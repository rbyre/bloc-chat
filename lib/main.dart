import 'package:flutter/material.dart';

import 'package:bloc_chat/cubit/counter_cubit.dart';
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
        home: MyHomePage(title: 'Bloc Concepts'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Wrap widget that shall be rebuilt with changing state with BlocBuilder
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('counterValue er ${state.counterValue}'),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('counterValue er ${state.counterValue}'),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                }
              },
              builder: (context, state) {
                // Access with state.
                if (state.counterValue <= 0) {
                  return Text(
                    'Verdien på counterValue er: ${state.counterValue.toString()}',
                    style: TextStyle(color: Colors.blue, fontSize: 28),
                  );
                } else {
                  return Text(
                    'Verdien på counterValue er: ${state.counterValue.toString()}',
                    style: TextStyle(color: Colors.red, fontSize: 28),
                  );
                }
              },
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // alt. context.bloc<CounterCubit>().decrement();
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Minus',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    //
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Pluss',
                  child: Icon(Icons.add),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
