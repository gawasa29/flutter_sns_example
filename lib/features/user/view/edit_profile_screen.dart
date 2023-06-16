import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/common/utils/loader.dart';
import 'package:flutter_sns_example/common/utils/pickImage.dart';
import 'package:flutter_sns_example/common/validate/validate.dart';
import 'package:flutter_sns_example/features/user/command/user_command.dart';
import 'package:flutter_sns_example/features/user/query/user_query.dart';
import 'package:flutter_sns_example/features/user/view/component/user_image.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});
  static const routePath = 'EditProfile';
  static const routeFullPath = '/Profile/EditProfile';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('📱 EditProfileScreen !!! ');
    final currentName =
        ref.read(userQueryProvider.select((value) => value.value!.name));
    final currentBio =
        ref.read(userQueryProvider.select((value) => value.value!.bio));
    final currentProfilePic =
        ref.watch(userQueryProvider.select((value) => value.value!.profilePic));
    final nameController = TextEditingController(text: currentName);
    final bioController = TextEditingController(text: currentBio);
    final formKey = GlobalKey<FormState>();

    final userCommand = ref.read(userAsyncNotifierCommand.notifier);
    final state = ref.read(userAsyncNotifierCommand);
    print(state.isLoading);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    _ProfilePic(currentProfilePic),
                    const SizedBox(height: 10),
                    _NameField(nameController),
                    const SizedBox(height: 10),
                    _BioField(bioController),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await userCommand.updateUserEvent(
                              name: nameController.text,
                              bio: bioController.text,
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Submitボタンを表示する
                  ],
                ),
              ),
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

class _ProfilePic extends ConsumerWidget {
  const _ProfilePic(this.profilePic);

  final String profilePic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        UserImage(profilePic: profilePic, radius: 64),
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            final selectedImage = await pickCropImage();
            if (selectedImage != null) {
              await ref
                  .read(userAsyncNotifierCommand.notifier)
                  .updateProfilePicEvent(file: selectedImage);
            }
          },
          child: const Icon(Icons.photo),
        )
      ],
    );
  }
}

class _NameField extends ConsumerWidget {
  const _NameField(this.nameController);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: nameController,
      maxLength: 10,
      minLines: 1,
      maxLines: 5,
      decoration: const InputDecoration(labelText: 'name'),
      validator: validate,
    );
  }
}

class _BioField extends ConsumerWidget {
  const _BioField(this.nameController);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: nameController,
      maxLength: 100,
      minLines: 1,
      maxLines: 5,
      decoration: const InputDecoration(labelText: 'bio'),
      validator: validate,
    );
  }
}
