import 'package:flutter/material.dart';
import 'package:miogra_seller/Screens/Insights/insightsscreen.dart';
import 'package:miogra_seller/Screens/Menu/menuscreen.dart';
import 'package:miogra_seller/Screens/OrdersScreen/ordersscreen.dart';
import 'package:miogra_seller/Screens/Profile/profilescreen.dart';
import 'package:miogra_seller/Widgets/custom_gradienttext.dart';

class RestaurentBottomNavigation extends StatefulWidget {
  final int initialIndex;
  final bool? itemsAdded;
  final int initialTabInOrders;
  const RestaurentBottomNavigation(
      {super.key,
      this.initialIndex = 0,
      this.itemsAdded,
      this.initialTabInOrders = 0});

  @override
  State<RestaurentBottomNavigation> createState() =>
      _RestaurentBottomNavigationState();
}

class _RestaurentBottomNavigationState
    extends State<RestaurentBottomNavigation> {
  late int _selectedIndex;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _screens = <Widget>[
      OrdersScreen(initialTab: widget.initialTabInOrders),
      MenuScreen(
        itemsAdded: widget.itemsAdded,
      ),
      const InsightsScreen(),
      const ProfileScreen()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationItem({
    required String label,
    required String imagePath,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    final borderColor = isSelected
        ? Color(0xFF623089)
        : Colors.grey.shade200;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: borderColor,
                width: isSelected ? 2.0 : 1.0, // Thickness of the border line
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              isSelected
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                          
   Color(0xFFAE62E8),
 Color(0xFF623089)

                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Image.asset(
                        imagePath,
                        height: 24,
                      ),
                    )
                  : ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                            Colors.grey,
                            Colors.grey,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Image.asset(
                        imagePath,
                        height: 24,
                      ),
                    ),
              GradientText(
                  text: label,
                  style: const TextStyle(
                      fontSize: 13, fontFamily: 'Poppins-Regular'),
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                          
   Color(0xFFAE62E8),
 Color(0xFF623089)

                          ],
                        )
                      : const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey, // Color code for #F98322
                            Colors.grey, // End color
                          ],
                        ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavigationItem(
            label: 'Orders',
            imagePath: 'assets/images/orangebag.png',
            index: 0,
          ),
          _buildBottomNavigationItem(
            label: 'Menu',
            imagePath: 'assets/images/menu.png',
            index: 1,
          ),
          _buildBottomNavigationItem(
            label: 'Insights',
            imagePath: 'assets/images/insights.png',
            index: 2,
          ),
          _buildBottomNavigationItem(
            label: 'Profile',
            imagePath: 'assets/images/resprofile.png',
            index: 3,
          ),
        ],
      ),
    );
  }
}
