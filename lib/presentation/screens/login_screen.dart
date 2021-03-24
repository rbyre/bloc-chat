import 'package:bloc_chat/constants/enums.dart';
import 'package:bloc_chat/logic/cubit/counter_cubit.dart';
import 'package:bloc_chat/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text('Wifi');
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text('Mobile');
                } else if (state is InternetDisconnected) {
                  return Text('Disconnected');
                }
                return CircularProgressIndicator();
              },
            ),
            // Wrap widget that shall be rebuilt with changing state with BlocConsumer
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('counterValue er ${state.counterValue}'),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('counterValue er ${state.counterValue}'),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                }
              },
              builder: (context, state) {
                // Access with state.counterValue
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
            SizedBox(
              height: 24,
            ),
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;

              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Mobile) {
                return Text(
                  'Counter: ' +
                      counterState.counterValue.toString() +
                      ' Internet: Mobile',
                );
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Wifi) {
                return Text('Counter: ' +
                    counterState.counterValue.toString() +
                    ' Internet: Wifi');
              } else {
                return Text(
                  'Counter: ' +
                      counterState.counterValue.toString() +
                      'Internet Disconnected',
                );
              }
            }),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // alt. context.read <CounterCubit>().decrement();
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  backgroundColor: widget.color,
                  tooltip: 'Minus',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    //
                    // BlocProvider.of<FirebaseCubit>(context).addData();
                  },
                  backgroundColor: widget.color,
                  tooltip: 'Pluss',
                  child: Icon(Icons.add),
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            TextButton(
              child: Text('Gå til Lobby'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: widget.color,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/lobby');
              },
            ),
            SizedBox(
              height: 24,
            ),
            TextButton(
              child: Text('Gå til Chat'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: widget.color,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/chat');
              },
            ),
          ],
        ),
      ),
    );
  }
}
