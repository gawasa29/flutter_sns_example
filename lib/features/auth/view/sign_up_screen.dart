import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/common/utils/loader.dart';
import 'package:flutter_sns_example/common/validate/validate.dart';
import 'package:flutter_sns_example/features/auth/command/auth_command.dart';
import 'package:flutter_sns_example/features/auth/view/sign_in_screen.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});
  static const routePath = '/SignUp';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('📱 SignUpScreen !!! ');
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final state = ref.watch(authAsyncNotifierCommand);
    final authCommand = ref.read(authAsyncNotifierCommand.notifier);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sign up', style: TextStyle(fontSize: 25)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              child: const Text('Sing in'),
                              onPressed: () {
                                context.go(SignInScreen.routePath);
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: 'Email'),
                          validator: validateEmail,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                          validator: validatePassword,
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Confirm password',
                          ),
                          validator: (value) => confirmValidatePassword(
                            value,
                            passwordController.text,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await authCommand.signUpEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              }
                            },
                            child: const Text('Sign up'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Image.asset(
                              'assets/images/google_logo.png',
                              height: 30,
                            ),
                            label: const Text(
                              'Sign in with Google',
                            ),
                            onPressed: () async {
                              await authCommand.signInGoogleEvent(
                                context: context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            child: state.isLoading ? const Loader() : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
