import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'providers/ticket_provider.dart';
import 'screens/home_screen.dart';
import 'screens/ticket_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicketProvider(),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Ticket Aéreo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const TicketFormScreen(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) => TicketFormScreen(id: state.params['id']),
    ),
  ],
);
