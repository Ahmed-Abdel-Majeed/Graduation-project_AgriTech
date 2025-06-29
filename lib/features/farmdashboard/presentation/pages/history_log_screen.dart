import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../domain/models/farm_history_item.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<FarmHistoryItem>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _fetchHistory();
  }

  Future<List<FarmHistoryItem>> _fetchHistory() async {
    final response = await FarmAPI.getFarmControl();
    return response.history;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: 
      FutureBuilder<List<FarmHistoryItem>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
                child: Lottie.asset(
                  'assets/Animation - 1750348692344.json',
                  width: 250.w,
                  height: 250.h,
                ),
              );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No history found'));
          }

          final history = snapshot.data!;

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              final time = item.timestamp;

              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(item.action),
                subtitle: Text('Source: ${item.sourceIsAi ? "AI" : "Manual"}'),
                trailing: Text('${time.hour}:${time.minute.toString().padLeft(2, '0')}'),
              );
            },
          );
        },
      ),
    );
  }
}
