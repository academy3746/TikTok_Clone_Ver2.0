import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/braekpoints.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/features/settings/settings_screen.dart';
import 'package:tiktok/features/users/view_models/user_vm.dart';
import 'package:tiktok/features/users/widgets/avatar.dart';
import 'package:tiktok/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok/features/users/widgets/update_profile.dart';
import '../../../constants/sizes.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onEditPressed({required String bio, required String link}) {
    Navigator.of(context).push(
      UpdateProfile.route(bio: bio, link: link),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ref.watch(userProvider).when(
          data: (data) {
            return Scaffold(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              body: SafeArea(
                child: DefaultTabController(
                  initialIndex: widget.tab == "likes" ? 1 : 0,
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          title: Text(data.name),
                          actions: [
                            IconButton(
                              onPressed: () => _onEditPressed(
                                bio: data.bio,
                                link: data.link,
                              ),
                              icon: const Icon(Icons.edit_note),
                            ),
                            IconButton(
                              onPressed: _onGearPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.gear,
                                size: Sizes.size20,
                              ),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Gaps.v20,

                              /// User Profile Image
                              UserAvatar(
                                name: data.name,
                                hasAvatar: data.hasAvatar,
                                uid: data.uid,
                              ),
                              Gaps.v20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "@${data.name}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Sizes.size18,
                                    ),
                                  ),
                                  Gaps.h5,
                                  FaIcon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: Colors.blue.shade200,
                                    size: Sizes.size16,
                                  ),
                                ],
                              ),
                              Gaps.v24,
                              SizedBox(
                                height: Sizes.size48,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          "150",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Sizes.size18,
                                          ),
                                        ),
                                        Gaps.v3,
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      width: Sizes.size32,
                                      thickness: Sizes.size1,
                                      color: Colors.grey.shade300,
                                      indent: Sizes.size14,
                                      endIndent: Sizes.size14,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "10M",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Sizes.size18,
                                          ),
                                        ),
                                        Gaps.v3,
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxWidth: Breakpoints.sm,
                                          ),
                                          child: Text(
                                            "Followers",
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      width: Sizes.size32,
                                      thickness: Sizes.size1,
                                      color: Colors.grey.shade300,
                                      indent: Sizes.size14,
                                      endIndent: Sizes.size14,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "150M",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Sizes.size18,
                                          ),
                                        ),
                                        Gaps.v3,
                                        Text(
                                          "Likes",
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.v14,
                              FractionallySizedBox(
                                widthFactor: 0.33,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        Sizes.size4,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Follow",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Gaps.v14,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size32,
                                ),
                                child: Text(
                                  data.bio,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.link,
                                    size: Sizes.size12,
                                  ),
                                  Gaps.h4,
                                  Text(
                                    data.link,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v20,
                            ],
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: PersistentTabBar(),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: 20,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 9 / 14,
                              crossAxisCount: width > Breakpoints.lg ? 6 : 3,
                              crossAxisSpacing: Sizes.size2,
                              mainAxisSpacing: Sizes.size2,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 9 / 14,
                                      child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            "assets/images/shogun.webp",
                                        image:
                                            "https://i1.ruliweb.com/ori/23/02/09/18633a446364d1021.png",
                                      ),
                                    ),
                                  ],
                                )),
                        GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: 20,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 9 / 14,
                              crossAxisCount: 3,
                              crossAxisSpacing: Sizes.size2,
                              mainAxisSpacing: Sizes.size2,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 9 / 14,
                                      child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            "assets/images/shogun.webp",
                                        image:
                                            "https://i1.ruliweb.com/ori/23/02/09/18633a446364d1021.png",
                                      ),
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
