import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone_flutter/core/theme/app_theme.dart';
import 'package:x_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:x_clone_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:x_clone_flutter/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter X',
      theme: AppTheme.darModeTheme,
      debugShowCheckedModeBanner: false,
      home: ref.watch(authStateChangeProvider).when(
            data: (data) {
              if (data != null) {
                return Scaffold(
                  body: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(data.photoURL ?? ""),
                        ),
                        Text(data.uid),
                        Text(data.displayName ?? ""),
                        Text(data.phoneNumber ?? "")
                      ],
                    ),
                  ),
                );
              } else {
                return const LoginScreen();
              }
            },
            error: (error, st) {
              Text(error.toString());
              return null;
            },
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
