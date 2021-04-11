// import 'package:bloc_chat/constants/constants.dart';
import 'package:bloc_chat/repositories/repositories.dart';
import 'package:bloc_chat/screens/login/cubit/login_cubit.dart';
import 'package:bloc_chat/screens/signup/signup_screen.dart';
import 'package:bloc_chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_button/nice_button.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScreen(),
      ),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(content: state.failure.message),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.black,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Flexible(
                        child: Hero(
                          tag: 'naeva',
                          child: Container(
                            height: 200.0,
                            child: Image.asset('images/naeva.png'),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Chat',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12.0),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.orange,
                                      hintText: 'Epost',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: Colors.orange,
                                      )),
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .emailChanged(value),
                                  validator: (value) => !value.contains('@')
                                      ? 'Skriv inn en gyldig epost.'
                                      : null,
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.orange,
                                      hintText: 'Passord',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                  obscureText: true,
                                  onChanged: (value) => context
                                      .read<LoginCubit>()
                                      .passwordChanged(value),
                                  validator: (value) => value.length < 6
                                      ? 'Must be at least 6 characters.'
                                      : null,
                                ),
                                const SizedBox(height: 28.0),
                                NiceButton(
                                  text: 'Logg inn',
                                  elevation: 8.0,
                                  radius: 52.0,
                                  background: Colors.orange[500],
                                  onPressed: () => _submitForm(
                                    context,
                                    state.status == LoginStatus.submitting,
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                NiceButton(
                                  text: 'Ingen Konto? Registrer',
                                  elevation: 8.0,
                                  radius: 52.0,
                                  background: Colors.orange[500],
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(SignupScreen.routeName),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}
