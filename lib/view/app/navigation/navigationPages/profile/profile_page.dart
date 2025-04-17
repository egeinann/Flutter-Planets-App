import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User? ??
        FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: user == null
            ? const Text("DATA NOT FOUND!")
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            user.photoURL != null && user.photoURL!.isNotEmpty
                                ? NetworkImage(user.photoURL!)
                                : null,
                        child: user.photoURL == null || user.photoURL!.isEmpty
                            ? const Icon(SpaceIcons.user, size: 40)
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.displayName ?? "No Name",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.email ?? "No Email",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  CustomOutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/resetPasswordPage"),
                    child: Text(
                      "Reset Password",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
