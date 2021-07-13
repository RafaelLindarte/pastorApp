import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';
import 'package:push_notificaction/src/data/notificaciones.dart';
import 'package:push_notificaction/src/pages/home.dart';
import 'package:push_notificaction/src/pages/login.dart';
import 'package:push_notificaction/src/pages/registro.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:push_notificaction/amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = Preferences();
  pref.intPreferencrs();
  await Notificaciones.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _amplifyConfigured = false;
  Amplify _amplifyInstance = Amplify();

  Future<void> _configureAmplify() async {
    try {
      AmplifyAuthCognito auth = AmplifyAuthCognito();
      _amplifyInstance.addPlugin(
        authPlugins: [auth],
      );
      await _amplifyInstance.configure(amplifyconfig);

      setState(() => _amplifyConfigured = true);
    } catch (e) {
      print(e);
      setState(() => _amplifyConfigured = false);
    }
    setState(() => _amplifyConfigured = true);
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    final pref = Preferences();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        )
      ],
      child: MaterialApp(title: 'Material App', initialRoute: '/', routes: {
        '/': (BuildContext context) {
          if (pref.uId != null && pref.uId.toString().isNotEmpty) {
            return HomePage();
          } else {
            return Login();
          }
        },
        'login': (BuildContext context) => Login(),
        'registro': (BuildContext context) => Registro(),
        'home': (BuildContext context) => HomePage(),
      }),
    );
  }
}
