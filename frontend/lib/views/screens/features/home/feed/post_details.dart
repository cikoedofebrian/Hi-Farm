import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/controllers/feed_controller.dart';
import 'package:hifarm/models/data/comment_model.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/post_comment.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final int id = Get.arguments;
  final FeedController feedController = Get.find();
  bool isScrolled = false;
  late final ScrollController _scrollController;
  late final TextEditingController _textEditingController;
  late Future future;
  List<MComment> commentData = [];

  @override
  void initState() {
    future = feedController.fetchCommentData(id);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && isScrolled == false) {
        setState(() {
          isScrolled = true;
        });
      } else if (_scrollController.offset <= 100 && isScrolled == true) {
        setState(() {
          isScrolled = false;
        });
      }
    });
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (_textEditingController.text.isNotEmpty) {
      final newComment =
          await feedController.addNewComment(_textEditingController.text, id);
      setState(() {
        commentData.add(newComment);
      });
      scrollToBottom();
      _textEditingController.clear();
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = feedController.list.firstWhere((element) => element.id == id);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: KeyboardVisibilityBuilder(builder: (p0, isKeyboardVisible) {
        if (isKeyboardVisible) {
          scrollToBottom();
        }
        return Scaffold(
          backgroundColor: AppColor.primary,
          body: FutureBuilder(
            future: future,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomLoadingIndicator();
              }
              commentData = snapshot.data! as List<MComment>;
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            color: AppColor.secondary,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 60, bottom: 20),
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.navigate_before_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                          const RoundedTopPadding(),
                          Column(
                            children: [
                              Container(
                                color: Colors.white,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage: data.user.pic !=
                                                      null
                                                  ? NetworkImage(data.user.pic!)
                                                  : const AssetImage(
                                                          'assets/home_images/empty_pic.jpg')
                                                      as ImageProvider,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(data.user.name),
                                          ],
                                        ),
                                        const Icon(Icons.more_vert_rounded)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.description,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width,
                                child: PageView.builder(
                                  itemBuilder: (context, index) =>
                                      Image.network(
                                    data.pics[index],
                                    fit: BoxFit.cover,
                                  ),
                                  itemCount: data.pics.length,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Comments (${commentData.length})',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (commentData.isEmpty) ...[
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Belum ada komentar!',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      )
                                    ],
                                    ...commentData
                                        .map((e) => PostComment(
                                            comment: e.comment,
                                            date: e.dateCreated,
                                            image: e.user.pic,
                                            name: e.user.name))
                                        .toList(),
                                    const SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (isScrolled)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: InkWell(
                              onTap: scrollToTop,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColor.secondary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.arrow_upward_rounded,
                                    color: AppColor.primary),
                              ),
                            ),
                          ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, -1),
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _textEditingController,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: sendMessage,
                                child: const Icon(
                                  Icons.send_rounded,
                                  color: AppColor.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
