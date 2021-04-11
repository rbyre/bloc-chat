import 'package:bloc_chat/blocs/auth/auth_bloc.dart';
import 'package:bloc_chat/config/custom_router.dart';
import 'package:bloc_chat/enums/enums.dart';
import 'package:bloc_chat/repositories/repositories.dart';
import 'package:bloc_chat/screens/chats/cubit/chats_cubit.dart';
import 'package:bloc_chat/screens/lobby/cubit/lobby_cubit.dart';
import 'package:bloc_chat/screens/profile/bloc/profile_bloc.dart';
import 'package:bloc_chat/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders[initialRoute](context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.lobby:
        return BlocProvider<LobbyCubit>(
          create: (context) => LobbyCubit()..getUsers(),
          child: LobbyScreen(),
        );
      case BottomNavItem.chats:
        return BlocProvider<MessagesBloc>(
          create: (context) => MessagesBloc()..add(LoadMessagesEvent()),
          child: ChatsScreen(),
        );
      case BottomNavItem.search:
        return SearchScreen();
      case BottomNavItem.profile:
        return BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
            userRepository: context.read<UserRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user.uid)),
          child: ProfileScreen(),
        );
      default:
        return Scaffold();
    }
  }
}
