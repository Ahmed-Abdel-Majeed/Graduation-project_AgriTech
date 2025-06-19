// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageSourceSelectorWidget extends StatelessWidget {
//   final ImagePicker picker;

//   const ImageSourceSelectorWidget({required this.picker, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           leading: const Icon(Icons.camera),
//           title: const Text('Take a picture'),
//           onTap: () async {
//             final pickedImage = await picker.pickImage(source: ImageSource.camera);
//             Navigator.pop(context, pickedImage);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.photo_library),
//           title: const Text('Choose from gallery'),
//           onTap: () async {
//             final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//             Navigator.pop(context, pickedImage);
//           },
//         ),
//       ],
//     );
//   }
// }
