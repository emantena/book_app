import 'package:book_app/core/resources/app_colors.dart';
import 'package:book_app/core/resources/app_routes.dart';
import 'package:book_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AvatarImage extends StatefulWidget {
  final String? photo;
  const AvatarImage({super.key, this.photo});

  @override
  State<AvatarImage> createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.photo == null) {
      return SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.unselectedColor,
              radius: 50,
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            _cameraButton(context)
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.unselectedColor,
              radius: 50,
              backgroundImage: NetworkImage(widget.photo!),
            ),
            _cameraButton(context)
          ],
        ),
      );
    }
  }
}

Widget _cameraButton(BuildContext context) {
  return Positioned(
    bottom: 0,
    right: -25,
    child: RawMaterialButton(
      onPressed: () {
        showBottonSheet(context: context);
      },
      elevation: 2.0,
      fillColor: AppColors.primaryBackground,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: const Icon(
        Icons.camera_alt_outlined,
        color: AppColors.primary,
      ),
    ),
  );
}

void showBottonSheet({required BuildContext context}) {
  final size = MediaQuery.of(context).size;

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.primaryBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSize.s20),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: size.height * 0.15,
        width: double.infinity,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.pushNamed(
                  AppRoutes.selfieRoute,
                );
              },
              child: const Text(
                "Tirar uma selfie",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: AppSize.s16,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final picker = ImagePicker();
                final file =
                    await picker.pickImage(source: ImageSource.gallery);

                if (file == null) {
                  // context.pushNamed(
                  //   AppRoutes.selfieRoute,
                  // );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GalleryView(
                  //       image: file,
                  //     ),
                  //     fullscreenDialog: true,
                  //   ),
                  // );
                }
              },
              child: const Text(
                "Escolher uma foto",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: AppSize.s16,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
