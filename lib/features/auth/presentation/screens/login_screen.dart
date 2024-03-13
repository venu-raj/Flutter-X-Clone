import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:x_clone_flutter/features/auth/presentation/widgets/auth_icon_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo/x-logo.png", height: 35),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              "See what's happening in the\nworld right now.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            AuthIconButton(
              onpressed: () {
                ref.read(userGoogleLoginProviderr(context));
              },
              imagePath: "assets/logo/ig_google.png",
              text: "Continue With Google",
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
