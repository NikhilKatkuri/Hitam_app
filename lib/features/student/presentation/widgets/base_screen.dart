import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hitam_app/core/constants/app_colors.dart';
import 'package:hitam_app/core/routes/app_routes.dart';
import 'package:hitam_app/core/utils/app_vectors.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _navItems = [
    _NavItem(
      route: AppRoutes.studentDashboardRoute,
      icon: AppVectors.homeOutline,
      activeIcon: AppVectors.home,
      label: 'Home',
    ),
    _NavItem(
      route: '${AppRoutes.studentDashboardRoute}/${AppRoutes.studentCourseRoute}',
      icon: AppVectors.courseOutline,
      activeIcon: AppVectors.course,
      label: 'Courses',
    ),
    _NavItem(
      route: '${AppRoutes.studentDashboardRoute}/${AppRoutes.studentChatRoute}',
      icon: AppVectors.chatOutline,
      activeIcon: AppVectors.chat,
      label: 'Chat',
    ),
    _NavItem(
      route: '${AppRoutes.studentDashboardRoute}/${AppRoutes.studentProfileRoute}',
      icon: AppVectors.userOutline,
      activeIcon: AppVectors.user,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    final selectedIndex = _navItems.indexWhere(
      (item) => currentPath == item.route || currentPath.endsWith('/${item.route.split('/').last}'),
    );
    final activeIndex = selectedIndex == -1 ? 0 : selectedIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: AppColors.dark,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'poppins',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        currentIndex: activeIndex,
        onTap: (index) => context.go(_navItems[index].route),
        items: _navItems.asMap().entries.map((entry) {
          final item = entry.value;
          final isSelected = activeIndex == entry.key;
          return BottomNavigationBarItem(
            icon: AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(
                item.icon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                placeholderBuilder: (context) {
                  debugPrint('Failed to load SVG: ${item.icon}');
                  return const Icon(Icons.error, size: 24);
                },
              ),
            ),
            activeIcon: AnimatedScale(
              scale: 1.1,
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(
                item.activeIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
                placeholderBuilder: (context) {
                  debugPrint('Failed to load SVG: ${item.activeIcon}');
                  return const Icon(Icons.error, size: 24);
                },
              ),
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final String route;
  final String icon;
  final String activeIcon;
  final String label;

  const _NavItem({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
