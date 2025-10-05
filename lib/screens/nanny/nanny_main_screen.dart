import 'package:flutter/material.dart';
import '../../widgets/nanny_glass_navbar.dart';
import 'nanny_home_screen.dart';
import 'nanny_calendar_screen.dart';
import 'nanny_earnings_screen.dart';
import 'nanny_profile_screen.dart';

class NannyMainScreen extends StatefulWidget {
  const NannyMainScreen({super.key});

  @override
  State<NannyMainScreen> createState() => _NannyMainScreenState();
}

class _NannyMainScreenState extends State<NannyMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const NannyHomeScreen(),
    const NannyCalendarScreen(),
    const NannyEarningsScreen(),
    const NannyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NannyGlassNavbar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
