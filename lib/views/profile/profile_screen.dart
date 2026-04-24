import 'package:flutter/material.dart';
import '../../app/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), 

      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF141414), 
        elevation: 0,
        automaticallyImplyLeading: false, 
      ),

      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF141414),
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          selectedItemColor: const Color(0xFFF97316),
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), 
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            if (index == 0) Navigator.pushNamed(context, Routes.home);
            if (index == 1) Navigator.pushNamed(context, Routes.search);
            if (index == 2) Navigator.pushNamed(context, Routes.cart);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              decoration: const BoxDecoration(
                color: Color(0xFF141414), 
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFF97316), width: 2), 
                    ),
                    child: const Icon(Icons.person_outline, size: 45, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  
                  const Text(
                    "Welcome, Guest",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 22,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Want to access your account? ",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                          fontFamily: 'serif',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, Routes.login),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Color(0xFFF97316),
                            fontSize: 15,
                            fontFamily: 'serif',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFF97316),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "ACCOUNT",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            
            _buildMenuItem(
              context: context,
              icon: Icons.inventory_2,
              iconColor: Colors.orange[200]!,
              iconBgColor: Colors.orange.withOpacity(0.15),
              title: "My Orders",
              targetRoute: Routes.orders, 
            ),
            
            _buildMenuItem(
              context: context,
              icon: Icons.favorite,
              iconColor: Colors.pinkAccent,
              iconBgColor: Colors.pinkAccent.withOpacity(0.15),
              title: "Wishlist",
              targetRoute: Routes.wishlist,
            ),
            
            _buildMenuItem(
              context: context,
              icon: Icons.location_on,
              iconColor: Colors.pinkAccent[100]!,
              iconBgColor: Colors.green[900]!.withOpacity(0.3),
              title: "Delivery Addresses",
              targetRoute: Routes.addresses,
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "PREFERENCES",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            _buildMenuItem(
              context: context,
              icon: Icons.notifications,
              iconColor: Colors.amber[300]!,
              iconBgColor: Colors.amber.withOpacity(0.15),
              title: "Notifications",
              targetRoute: Routes.notifications,
            ),

            _buildMenuItem(
              context: context,
              icon: Icons.chat_bubble,
              iconColor: Colors.blue[100]!,
              iconBgColor: Colors.blue.withOpacity(0.15),
              title: "Help & Support",
              targetRoute: Routes.home, 
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF97316),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, Routes.login),
                  child: const Text(
                    "Log In / Register",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 16,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String targetRoute, 
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), 
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'serif'),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chevron_right, size: 18, color: Colors.grey[600]),
            ],
          ),
          onTap: () => Navigator.pushNamed(context, targetRoute),
        ),
      ),
    );
  }
}