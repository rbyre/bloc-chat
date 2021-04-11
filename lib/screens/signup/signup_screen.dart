// import 'package:bloc_chat/constants/constants.dart';
import 'package:bloc_chat/repositories/repositories.dart';
import 'package:bloc_chat/screens/signup/cubit/signup_cubit.dart';
import 'package:bloc_chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_button/nice_button.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignupCubit>(
        create: (_) =>
            SignupCubit(authRepository: context.read<AuthRepository>()),
        child: SignupScreen(),
      ),
    );
  }

  // static const String id = 'registration_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignupStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  content: state.failure.message,
                ),
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
                        color: Colors.white,
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
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12.0),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Username'),
                                  onChanged: (value) => context
                                      .read<SignupCubit>()
                                      .usernameChanged(value),
                                  validator: (value) => value.trim().isEmpty
                                      ? 'Please enter a valid username.'
                                      : null,
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Email'),
                                  onChanged: (value) => context
                                      .read<SignupCubit>()
                                      .emailChanged(value),
                                  validator: (value) => !value.contains('@')
                                      ? 'Please enter a valid email.'
                                      : null,
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
                                  obscureText: true,
                                  onChanged: (value) => context
                                      .read<SignupCubit>()
                                      .passwordChanged(value),
                                  validator: (value) => value.length < 6
                                      ? 'Must be at least 6 characters.'
                                      : null,
                                ),
                                const SizedBox(height: 28.0),
                                NiceButton(
                                  text: 'Registrer',
                                  elevation: 8.0,
                                  radius: 52.0,
                                  background: Colors.orange[500],
                                  onPressed: () => _submitForm(
                                    context,
                                    state.status == SignupStatus.submitting,
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                NiceButton(
                                  text: 'Tilbake til Innlogging',
                                  elevation: 8.0,
                                  radius: 52.0,
                                  background: Colors.orange[500],
                                  onPressed: () => Navigator.of(context).pop(),
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
      context.read<SignupCubit>().signUpWithCredentials();
    }
  }
}




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Flexible(
//               child: Hero(
//                 tag: 'naeva',
//                 child: Container(
//                   height: 200.0,
//                   child: Image.asset('images/naeva.png'),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 48.0,
//             ),
//             TextField(
//               style: TextStyle(color: Colors.white),
//               keyboardType: TextInputType.emailAddress,
//               textAlign: TextAlign.center,
//               onChanged: (value) {
//                 email = value;
//               },
//               decoration:
//                   kTextFieldDecoration.copyWith(hintText: 'Skriv inn e-post'),
//             ),
//             SizedBox(
//               height: 8.0,
//             ),
//             TextField(
//               style: TextStyle(color: Colors.white),
//               obscureText: true,
//               textAlign: TextAlign.center,
//               onChanged: (value) {
//                 password = value;
//               },
//               decoration: kTextFieldDecoration.copyWith(
//                   hintText: 'Skriv inn passord'),
//             ),
//             SizedBox(
//               height: 24.0,
//             ),
//             NiceButton(
//               text: 'Registrer',
//               elevation: 8.0,
//               radius: 52.0,
//               background: Colors.orange[500],
//               onPressed: () async {
//                 setState(() {
//                   showSpinner = true;
//                 });
//                 try {
//                   final newUser = await _auth.createUserWithEmailAndPassword(
//                       email: email, password: password);
//                   if (newUser != null) {
//                     Navigator.of(context).pushNamed('/lobby');
//                     // Navigator.pushNamed(context, ChatScreen.id);
//                   }

//                   setState(() {
//                     showSpinner = false;
//                   });
//                 } catch (e) {
//                   print(e);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
