import 'package:firebase_core/firebase_core.dart';
import 'package:fluchat/dependencies.dart';
import 'package:fluchat/ui/app_theme_cubit.dart';
import 'package:fluchat/ui/splash/splash_view.dart';
import 'package:fluchat/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _streamChatClient = StreamChatClient('mvsh2q8qc7az');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: BlocProvider(
        create: (context) => AppThemeCubit(context.read())..init(),
        child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
          return MaterialApp(
            title: 'FluChat',
            home: SplashView(),
            theme: snapshot ? Themes.themeDark : Themes.themeLight,
            builder: (context, child) {
              return StreamChat(
                child: child,
                client: _streamChatClient,
                streamChatThemeData: StreamChatThemeData.fromTheme(Theme.of(context)).copyWith(
                  ownMessageTheme: MessageTheme(
                    messageBackgroundColor: Theme.of(context).accentColor,
                    messageText: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
