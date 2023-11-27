// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/inbox/view_models/dm_vm.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";

  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  String _submitChat = "";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _submitChat = _textEditingController.text;
      });
    });
  }

  void _onChatSubmitted() {
    if (_submitChat == "") {
      return;
    }

    ref.read(dmProvider.notifier).sendDM(_submitChat);

    _textEditingController.clear();

    _onStopChat();
  }

  void _onStopChat() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(dmProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/107133642?v=4"),
                child: Text("DIO"),
              ),
              SizedBox(
                height: Sizes.size16,
                child: Container(
                  width: Sizes.size16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.solidCircle,
                      color: Colors.green,
                      size: Sizes.size10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "Ronnie James Dio (${widget.chatId})",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active Now"),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _onStopChat,
        child: Stack(
          children: [
            ref.watch(chatProvider).when(
                  data: (data) {
                    return ListView.separated(
                      reverse: false,
                      padding: EdgeInsets.only(
                        top: Sizes.size20,
                        bottom: MediaQuery.of(context).padding.bottom + Sizes.size20,
                        left: Sizes.size16,
                        right: Sizes.size16,
                      ),
                      itemBuilder: (context, index) {
                        final message = data[index];

                        final isMine =
                            message.userId == ref.watch(authRepo).user!.uid;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: isMine
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                Sizes.size14,
                              ),
                              decoration: BoxDecoration(
                                color: isMine
                                    ? Colors.blueAccent
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(
                                    Sizes.size20,
                                  ),
                                  topRight: const Radius.circular(
                                    Sizes.size20,
                                  ),
                                  bottomLeft: Radius.circular(
                                    isMine ? Sizes.size20 : Sizes.size5,
                                  ),
                                  bottomRight: Radius.circular(
                                    !isMine ? Sizes.size20 : Sizes.size5,
                                  ),
                                ),
                              ),
                              child: Text(
                                message.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemCount: data.length,
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
                ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                color: Colors.grey.shade50,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          Sizes.size10,
                        ),
                        child: SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            controller: _textEditingController,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: "Send DM!",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Sizes.size24),
                                  topRight: Radius.circular(Sizes.size24),
                                  bottomRight: Radius.circular(Sizes.size24),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                left: Sizes.size16,
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    color: Colors.black,
                                    size: Sizes.size24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h20,
                    GestureDetector(
                      onTap: isLoading ? null : _onChatSubmitted,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: Sizes.size10,
                            color: _submitChat.isNotEmpty
                                ? Colors.blueAccent
                                : Colors.grey.shade300,
                          ),
                          shape: BoxShape.circle,
                          color: _submitChat.isNotEmpty
                              ? Colors.blueAccent
                              : Colors.grey.shade300,
                        ),
                        child: FaIcon(
                          _submitChat.isNotEmpty
                              ? FontAwesomeIcons.paperPlane
                              : FontAwesomeIcons.solidPaperPlane,
                          color: Colors.white,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                    Gaps.h10,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
