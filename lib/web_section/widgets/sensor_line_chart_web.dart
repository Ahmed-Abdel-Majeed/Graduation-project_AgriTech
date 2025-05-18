import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/sensor_reading.dart';

class SensorLineChartWeb extends StatelessWidget { // إنشاء ويدجت لعرض الخط البياني بنسخة الويب
  final List<SensorReading> readings; // القائمة التي تحتوي على قراءات الحساسات

  const SensorLineChartWeb({super.key, required this.readings}); // الكونستركتر لاستقبال القراءات

  @override
  Widget build(BuildContext context) {
    final sorted = readings..sort((a, b) => a.time.compareTo(b.time)); // ترتيب القراءات حسب الزمن

    // دالة لتحويل قائمة من القيم إلى نقاط FlSpot لعرضها على الخط البياني
    List<FlSpot> generateSpots(List<double> values) {
      return List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i]));
    }

    return Container( // حاوية تحتوي على كل المحتوى
      padding: const EdgeInsets.all(24), // مسافة داخلية من جميع الجهات
      decoration: BoxDecoration( // تنسيق شكل الحاوية
        color: const Color(0xFF1E1E1E), // لون الخلفية رمادي غامق
        borderRadius: BorderRadius.circular(16), // زوايا دائرية
      ),
      child: Column( // ترتيب العناصر بشكل عمودي
        crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النصوص من اليسار
        children: [
          const Text(
            "Sensor Trends Over Time", // عنوان الرسم البياني
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), // تنسيقه
          ),
          const SizedBox(height: 16), // مسافة عمودية
          SizedBox(
            height: 450, // ارتفاع الرسم البياني
            child: LineChart( // ويدجت الرسم البياني
              LineChartData( // بيانات الرسم
                minX: 0, // أقل قيمة لمحور X (الزمن)
                maxX: (readings.length - 1).toDouble(), // أكبر قيمة لمحور X بناءً على عدد القراءات
                minY: 0, // أقل قيمة لمحور Y (قيم الحساسات)
                backgroundColor: const Color(0xFF1E1E1E), // خلفية الرسم (مطابقة للخلفية الخارجية)

                // إعدادات العناوين على المحاور
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true, // عرض عناوين المحور السفلي
                      interval: (readings.length / 6).clamp(1, 10).toDouble(), // الفاصل بين العناوين
                      getTitlesWidget: (value, _) { // توليد عنوان لكل نقطة على محور X
                        int i = value.toInt();
                        if (i < 0 || i >= sorted.length) return const SizedBox(); // تجاهل النقاط خارج المدى
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            DateFormat("hh:mm a").format(sorted[i].time), // تنسيق الوقت كنص
                            style: const TextStyle(fontSize: 12, color: Colors.white70), // تنسيق الخط
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles( // إعدادات المحور العمودي (Y)
                    sideTitles: SideTitles(
                      // showTitles: true, // عرض العناوين
                      interval: 1, // الفاصل بين كل عنوان
                      getTitlesWidget: (value, _) => Text(
                        value.toStringAsFixed(0), // عرض القيم بشكل رقمي بدون فاصلة عشرية
                        style: const TextStyle(fontSize: 12, color: Colors.white70), // تنسيق الخط
                      ),
                    ),
                  ),
                ),

                // إعدادات الخطوط داخل الشبكة
                gridData: FlGridData(
                  show: true, // عرض الشبكة
                  drawVerticalLine: true, // رسم خطوط عمودية
                  getDrawingHorizontalLine: (_) => FlLine(color: Colors.white10, strokeWidth: 1), // إعداد خطوط Y
                  getDrawingVerticalLine: (_) => FlLine(color: Colors.white10, strokeWidth: 1), // إعداد خطوط X
                ),

                // إعداد شكل الإطار الخارجي للرسم
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.white24), // لون الإطار
                ),

                // الخطوط البيانية الخاصة بكل متغير
                lineBarsData: [
                  // خط الحموضة pH
                  LineChartBarData(
                    spots: generateSpots(sorted.map((e) => e.ph).whereType<double>().toList()), // تحويل القيم لنقاط
                    isCurved: true, // جعل الخط منحني
                    color: Colors.blueAccent, // اللون
                    barWidth: 2, // عرض الخط
                    dotData: FlDotData(show: false), // إخفاء النقاط على الخط
                  ),
                  // خط درجة الحرارة
                  LineChartBarData(
                    spots: generateSpots(sorted.map((e) => e.airtemp).whereType<double>().toList()),
                    isCurved: true,
                    color: Colors.redAccent,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                  ),
                  // خط التوصيل الكهربائي EC
                  LineChartBarData(
                    spots: generateSpots(sorted.map((e) => e.ec).whereType<double>().toList()),
                    isCurved: true,
                    color: Colors.greenAccent,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                  ),
                  // خط مستوى الماء
                  LineChartBarData(
                    spots: generateSpots(sorted.map((e) => e.waterLevel).whereType<double>().toList()),
                    isCurved: true,
                    color: Colors.orangeAccent,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
