import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/common/utils/loader.dart';
import 'package:flutter_sns_example/common/validate/validate.dart';
import 'package:flutter_sns_example/features/auth/command/auth_command.dart';
import 'package:go_router/go_router.dart';

class ForgottenPasswordScreen extends ConsumerWidget {
  const ForgottenPasswordScreen({super.key});
  static const routePath = 'ForgottenPassword';
  static const routeFullPath = '/SignIn/ForgottenPassword';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('📱 ForgottenPasswordScreen !!! ');
    final state = ref.watch(authAsyncNotifierCommand);
    final authCommand = ref.read(authAsyncNotifierCommand.notifier);
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                      children: <Widget>[
                        const Text(
                          'Forgotten password',
                          style: TextStyle(fontSize: 25),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Provide your email and we will send you a link to reset your password',
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: 'Email'),
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await authCommand.resetPasswordEvent(
                                  email: emailController.text,
                                  context: context,
                                );
                              }
                            },
                            child: const Text('Reset password'),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text('Go back'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
