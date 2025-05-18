import 'package:agri/features/camera/screens/crop_scan_page.dart';
import 'package:agri/presentation/dashboard/screens/plant_monitoring_page.dart';
import 'package:agri/web_section/widgets/ai_insights_section_web.dart';
import 'package:flutter/material.dart';
import 'package:agri/web_section/screens/sensor_dashboard_web_page.dart';

class WebDashboardLayout extends StatefulWidget {
  const WebDashboardLayout({super.key});

  @override
  State<WebDashboardLayout> createState() => _WebDashboardLayoutState();
}

class _WebDashboardLayoutState extends State<WebDashboardLayout> {
  int _selectedIndex = 0;
  bool _isExpanded = false;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      SensorsDashboardWeb(),
      AiInsightsSectionWeb(),
      CropScanPage(),
      PlantMonitoringPage(),
      const Center(child: Text('Coming Soon', style: TextStyle(fontSize: 24))),
    ];
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(IconData icon, String title, int index, bool isExpanded) {
    return Tooltip(
      message: title,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: isExpanded ? Text(title, style: const TextStyle(color: Colors.black,fontSize: 13)) : null,
        selected: _selectedIndex == index,
        selectedTileColor: Colors.deepPurpleAccent,
        onTap: () {
          setState(() {
            _selectedIndex = index;
            if (MediaQuery.of(context).size.width < 700) Navigator.pop(context);
          });
        },
      ),
    );
  }

  Widget _buildSidebarContent({required bool isExpanded, required bool isMobile}) {
    return Column(

      children: [
        Card(child: Image.asset("assets/images/logo.png")),
        Divider(color: Colors.black.withOpacity(0.5)),
        const SizedBox(height: 30),
        _buildNavItem(Icons.dashboard, 'Dashboard', 0, isExpanded),
        _buildNavItem(Icons.analytics, 'Ai Analysis', 1, isExpanded),
        _buildNavItem(Icons.camera, 'Scan Crop', 2, isExpanded),
        _buildNavItem(Icons.photo, 'PlantMonitoring', 3, isExpanded),
        const Spacer(),
        if (!isMobile)
          IconButton(
            icon: Icon(
      
              isExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isMobile = screenWidth < 700;
    bool isSmallScreen = screenWidth < 1100;

    _isExpanded = !isSmallScreen && _isExpanded;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.black,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              title: const Text("Dashboard", style: TextStyle(color: Colors.white)),
            )
          : null,
      drawer: isMobile
          ? Drawer(
              child: Container(
                color: Colors.black,
                child: _buildSidebarContent(isExpanded: true, isMobile: true),
              ),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            AnimatedContainer(
              
              duration: const Duration(milliseconds: 300),
              width: _isExpanded ? 190 : 70,
              color: Color(0xFFFFFFFF),
              child: _buildSidebarContent(isExpanded: _isExpanded, isMobile: false),
            ),
          if (!isMobile) const VerticalDivider(width: 1),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}
