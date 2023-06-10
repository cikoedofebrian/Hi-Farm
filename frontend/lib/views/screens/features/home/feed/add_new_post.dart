import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/feed_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({super.key});

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  final List<File> _photoList = [];
  late final PageController _controller;
  bool _isShowed = false;
  int _currentPage = 1;
  LatLng? _draggedLatlng;
  String? _draggedAddress;
  final TextEditingController _textController = TextEditingController();
  final FeedController _feedController = Get.find();

  @override
  void initState() {
    _controller = PageController();

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.toInt() + 1;
        if ((_controller.page! < _photoList.length) && _isShowed != true) {
          _isShowed = true;
        } else if (_controller.page!.toInt() == _photoList.length) {
          _isShowed = false;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _imagePicker() async {
    final ImagePicker picker = ImagePicker();
    File? photo;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(
                  'Pilih salah satu metode dibawah :',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil foto baru'),
                onTap: () async {
                  final XFile? pickedPhoto = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 50);
                  if (pickedPhoto != null) {
                    photo = File(pickedPhoto.path);
                    Get.back();
                  }
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                leading: const Icon(Icons.image),
                title: const Text('Pilih dari galeri'),
                onTap: () async {
                  final XFile? pickedPhoto = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 50);
                  if (pickedPhoto != null) {
                    photo = File(pickedPhoto.path);
                    Get.back();
                  }
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        );
      },
    );
    if (photo != null) {
      setState(() {
        _isShowed = true;
        _photoList.add(photo!);
      });
    }
  }

  Widget getImageView(File photo) {
    return Image.file(
      photo,
      fit: BoxFit.cover,
    );
  }

  void _deletePhoto() {
    setState(() {
      _photoList.removeAt(_controller.page!.toInt());
      if (_controller.page!.toInt() == _photoList.length) {
        _isShowed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColor.secondary,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 60, bottom: 20),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.navigate_before_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Buat Post',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const RoundedTopPadding(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jumlah Foto',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text('${_photoList.length}/5'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) => SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxWidth,
                            child: PageView(
                              controller: _controller,
                              children: [
                                ...List.generate(
                                  _photoList.length,
                                  (index) => getImageView(_photoList[index]),
                                ),
                                if (_photoList.length < 5)
                                  addPhotoContainer(context)
                              ],
                            ),
                          ),
                        ),
                        if (_isShowed)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.secondary),
                                    child: Text(
                                      "$_currentPage/${_photoList.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: _deletePhoto,
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColor.tertiary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Image.asset(
                            'assets/home_images/Rectangle 160.png',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            minLines: 1,
                            maxLines: 10,
                            decoration: const InputDecoration.collapsed(
                              hintText:
                                  'Tuliskan deskripsi dari postinganmu disini...',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.location_on,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                Get.toNamed(addPostLocation)!.then((value) {
                              if (value != null) {
                                setState(() {
                                  _draggedLatlng = value[0];
                                  _draggedAddress = value[1];
                                });
                              }
                            }),
                            child: Text(
                              _draggedAddress == null
                                  ? "Pilih Lokasi"
                                  : _draggedAddress!,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => _feedController.addNewPost(
                          _textController.text, _draggedLatlng, _photoList),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.secondary,
                        ),
                        child: Text(
                          "Kirim Postingan",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell addPhotoContainer(BuildContext context) {
    return InkWell(
      onTap: _imagePicker,
      child: Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.photo,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Tambahkan Foto',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
