// ignore_for_file: avoid_print

// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/braekpoints.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

import '../../utility.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  //bool _isWriting = false;

  void _onSearchChanged(String value) {
    print("Searching for $value");
  }

  void _onSearchSubmitted(String value) {
    print("$value has submitted.");
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  /*void _startWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _textEditingController.clear();
      _isWriting = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: SizedBox(
            height: Sizes.size36,
            child: ConstrainedBox( /// Container 안에 ConstrainedBox를 담을 필요는 없음
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.sm,
              ),
              child: CupertinoSearchTextField(
                controller: _textEditingController,
                onChanged: _onSearchChanged,
                onSubmitted: _onSearchSubmitted,
                style: TextStyle(
                  color: isDarkMode(context) ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          /*TextField(
            controller: _textEditingController,
            onTap: _startWriting,
            expands: true,
            minLines: null,
            maxLines: null,
            textInputAction: TextInputAction.newline,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.grey.shade500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Sizes.size6,
                ),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.size10,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.size8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.grey.shade500,
                      size: Sizes.size16 + Sizes.size2,
                    ),
                  ],
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  right: Sizes.size8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isWriting)
                      GestureDetector(
                        onTap: _stopWriting,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size16 + Sizes.size2,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),*/
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
            labelColor: Theme.of(context).tabBarTheme.labelColor,
            unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 20,
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
              ),
              itemBuilder: (BuildContext context, int index) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Sizes.size4,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/shogun.webp",
                            image:
                                "https://i1.ruliweb.com/ori/23/02/09/18633a446364d1021.png",
                          ),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "Ride the tiger! you can see his stripes but you know he's clean.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v8,
                      /*if (constraints.maxWidth < 200 ||
                          constraints.maxWidth > 350)*/
                        DefaultTextStyle(
                          style: TextStyle(
                            color: isDarkMode(context) ? Colors.grey.shade300 : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/107133642?v=4",
                                ),
                                radius: 12,
                              ),
                              Gaps.h4,
                              const Expanded(
                                child: Text(
                                  "Ronnie James DIO",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Gaps.h4,
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size14,
                                color: Colors.grey.shade600,
                              ),
                              Gaps.h2,
                              const Text(
                                "2.5M",
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size32,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
