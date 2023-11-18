import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/users/view_models/user_vm.dart';

class UpdateProfile extends ConsumerStatefulWidget {
  const UpdateProfile({
    super.key,
    required this.bio,
    required this.link,
  });

  final String bio;

  final String link;

  static Route route({required String bio, required String link}) =>
      MaterialPageRoute(
        builder: (BuildContext context) => UpdateProfile(
          bio: bio,
          link: link,
        ),
      );

  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends ConsumerState<UpdateProfile> {
  late final TextEditingController _bioController =
      TextEditingController(text: widget.bio);

  late final TextEditingController _linkController =
      TextEditingController(text: widget.link);

  Future<void> _onUpdateProfilePressed() async {
    await ref.read(userProvider.notifier).updateUser(
          bio: _bioController.text,
          link: _linkController.text,
        );
  }

  @override
  void initState() {
    super.initState();

    _bioController;
    _linkController;
  }

  @override
  void dispose() {
    _bioController.dispose();
    _linkController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Update User Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              right: Sizes.size20,
              left: Sizes.size20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CloseButton(),
                Gaps.v20,
                TextField(
                  controller: _bioController,
                  maxLength: 200,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "Biography",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.size14),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.size14),
                      ),
                    ),
                  ),
                ),
                Gaps.v20,
                TextField(
                  controller: _linkController,
                  maxLength: 200,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "Link",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.size14),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.size14),
                      ),
                    ),
                  ),
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: _onUpdateProfilePressed,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size14),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      "Update your profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Gaps.v20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
