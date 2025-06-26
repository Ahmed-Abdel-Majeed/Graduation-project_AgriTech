import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // فتح روابط
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About AgriTech"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // شعار المشروع
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "🌱 Agriculture 5.0: Smart Agriculture Monitoring and Control",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const Text(
              "مشروع تخرج مقدم إلى قسم هندسة الاتصالات والإلكترونيات "
              "بمعهد الجيزة العالي للهندسة والتكنولوجيا، لعام 2024/2025.",
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 32),

            const Text(
              "👥 الفريق القائم على المشروع:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("• Amr Mohamed Mohamed Fawzy"),
            const Text("• Yousef Kamel Salah-Eldin Kamel"),
            const Text("• Abdallah Khaled Mostafa Kamel"),
            const Text("• Ahmed Abdalmageed Mashhot"),
            const Text("• Moaz Abd Elnasser Ahmed Motawee"),
            const SizedBox(height: 10),
            const Text("👨‍🏫 المشرف: Dr. Kareem A. Badawi"),

            const Divider(height: 32),

            const Text(
              "📌 رؤية المشروع:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "يهدف النظام إلى تحويل المزارع الهيدروبونية إلى بيئة ذكية قابلة للتحكم عن بعد، "
              "معتمدًا على الذكاء الاصطناعي وإنترنت الأشياء لمراقبة وتشغيل نظام الزراعة بدقة وكفاءة.",
            ),

            const Divider(height: 32),

            const Text(
              "📞 معلومات التواصل:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _launchURL("mailto:ahmedabdalmaged2002@yahoo.com"),
                  child: const Text(
                    "ahmedabdalmaged2002@yahoo.com",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.phone),
                SizedBox(width: 8),
                Text("+20 150 105 3538"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.link),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _launchURL(
                      "https://github.com/Ahmed-Abdel-Majeed/Graduation-project_AgriTech"),
                  child: const Text(
                    "GitHub Repository",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),

            const Divider(height: 32),

            const Text(
              "❤️ شكر وتقدير:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
"نتقدم بجزيل الشكر والعرفان لله عز وجل، ثم لأسرنا الكريمة، ولمشرفنا القدير، ولكل من ساندنا في رحلتنا العلمية نحو هذا الإنجاز."

            ),
            const SizedBox(height: 32),
          
          ],
        ),
      ),
    );
  }
}
