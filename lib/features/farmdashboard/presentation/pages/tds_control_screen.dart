import 'package:agri/features/farmdashboard/domain/models/tds_control.dart';
import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/tds/tds_control_body.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';

class TDSControlScreen extends StatefulWidget {
  const TDSControlScreen({super.key});

  @override
  State<TDSControlScreen> createState() => _TDSControlScreenState();
}

class _TDSControlScreenState extends State<TDSControlScreen> {
  bool isLoading = false;

  Future<void> _saveControl(TDSControl control) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.updateTDSControl(control);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('TDS settings updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _cancelDose() async {
    try {
      await FarmAPI.updateTDSControlDose(0.0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dose cancelled')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _scheduleDose(TimeOfDay time) async {
    // Just for demo purpose — trigger dose amount > 0
    try {
      await FarmAPI.updateTDSControlDose(0.4);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dose scheduled')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TDS Control",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<TDSControl>(
        future: FarmAPI.fetchTDSControl(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final control = snapshot.data!;
            return TDSControlBody(
              control: control,
              onControlChange: _saveControl,
              onScheduleDose: _scheduleDose,
              onCancelDose: _cancelDose,
              isLoading: isLoading,
            );
          }
        },
      ),
    );
  }
}