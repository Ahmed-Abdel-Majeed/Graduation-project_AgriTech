// import 'dart:typed_data';
// import 'package:flutter/material.dart';

// class DisplayImagePage extends StatelessWidget {
//   final Uint8List imageBytes;
//   final String details;

//   const DisplayImagePage({
//     super.key,
//     required this.imageBytes,
//     required this.details,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // عرض الصورة المعدلة
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.memory(
//                   imageBytes,
//                   height: 300,
//                   width: 300,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // عنوان التفاصيل
//               Text(
//                 'Details:',
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//               ),
//               const SizedBox(height: 10),
//               // عرض التفاصيل
//               Text(
//                 details,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               // زري التحكم (اختياري)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.arrow_back),
//                     label: const Text('Back'),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       // إضافة منطق لحفظ الصورة أو تنفيذ إجراء آخر
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Save feature coming soon!')),
//                       );
//                     },
//                     icon: const Icon(Icons.save),
//                     label: const Text('Save Image'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // زر لعرض التفاصيل بشكل أكبر
//               ElevatedButton(
//                 onPressed: () {
//                   // يمكنك إضافة منطق لعرض المزيد من التفاصيل هنا
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Additional details coming soon!')),
//                   );
//                 },
//                 child: const Text('View More Details'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
