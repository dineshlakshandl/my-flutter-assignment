import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/routes.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _editFormKey = GlobalKey<FormState>();

  void _showEditProfileBottomSheet(BuildContext context, ProfileViewModel profileVM) {
    final userProfile = profileVM.userProfile;
    final nameController = TextEditingController(text: userProfile?.name);
    final phoneController = TextEditingController(text: userProfile?.phone);
    final addressController = TextEditingController(text: userProfile?.address);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _editFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Edit Profile Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'serif',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white10, thickness: 1, height: 24),
                  
                
                  const Text(
                    "Full Name",
                    style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      hintText: "Enter your full name",
                      hintStyle: const TextStyle(color: Colors.white30),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFF97316)),
                      ),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? "Name is required" : null,
                  ),
                  const SizedBox(height: 16),

                
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: phoneController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      hintText: "Enter phone number",
                      hintStyle: const TextStyle(color: Colors.white30),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFF97316)),
                      ),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? "Phone number is required" : null,
                  ),
                  const SizedBox(height: 16),

              
                  const Text(
                    "Delivery Address",
                    style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: addressController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      hintText: "Enter delivery address",
                      hintStyle: const TextStyle(color: Colors.white30),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFF97316)),
                      ),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? "Address is required" : null,
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (!_editFormKey.currentState!.validate()) return;
                      
                      final success = await profileVM.updateProfile(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        address: addressController.text.trim(),
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Profile updated successfully!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to update profile."),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileVM = Provider.of<ProfileViewModel>(context);
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    final bool isUserLoggedIn = profileVM.isLoggedIn;
    final userProfile = profileVM.userProfile;

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
              padding: const EdgeInsets.only(top: 24, bottom: 32),
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
                  
                  Text(
                    isUserLoggedIn && userProfile != null
                        ? (userProfile.name.isNotEmpty ? userProfile.name : "Fashion Lover")
                        : "Welcome, Guest",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  if (isUserLoggedIn && userProfile != null)
                    Text(
                      userProfile.email,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontFamily: 'serif',
                      ),
                    )
                  else
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
              iconBgColor: Colors.orange.withValues(alpha: 0.15),
              title: "My Orders",
              onTap: () => Navigator.pushNamed(context, Routes.orders),
            ),

            if (isUserLoggedIn)
              _buildMenuItem(
                context: context,
                icon: Icons.edit_note_outlined,
                iconColor: const Color(0xFFF97316),
                iconBgColor: const Color(0xFFF97316).withValues(alpha: 0.15),
                title: "Edit Profile Details",
                onTap: () => _showEditProfileBottomSheet(context, profileVM),
              ),
            
            _buildMenuItem(
              context: context,
              icon: Icons.favorite,
              iconColor: Colors.pinkAccent,
              iconBgColor: Colors.pinkAccent.withValues(alpha: 0.15),
              title: "Wishlist",
              onTap: () => Navigator.pushNamed(context, Routes.wishlist),
            ),
            
            _buildMenuItem(
              context: context,
              icon: Icons.location_on,
              iconColor: Colors.pinkAccent[100]!,
              iconBgColor: Colors.green[900]!.withValues(alpha: 0.3),
              title: "Delivery Addresses",
              onTap: () => Navigator.pushNamed(context, Routes.addresses),
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
              iconBgColor: Colors.amber.withValues(alpha: 0.15),
              title: "Notifications",
              onTap: () => Navigator.pushNamed(context, Routes.notifications),
            ),

            _buildMenuItem(
              context: context,
              icon: Icons.chat_bubble,
              iconColor: Colors.blue[100]!,
              iconBgColor: Colors.blue.withValues(alpha: 0.15),
              title: "Help & Support",
              onTap: () => Navigator.pushNamed(context, Routes.home),
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
                  onPressed: () async {
                    if (isUserLoggedIn) {
                  
                      await authVM.logoutUser();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, Routes.login);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Signed out successfully"),
                            backgroundColor: Color(0xFFF97316),
                          ),
                        );
                      }
                    } else {
                      
                      Navigator.pushNamed(context, Routes.login);
                    }
                  },
                  child: Text(
                    isUserLoggedIn ? "Sign Out" : "Log In / Register",
                    style: const TextStyle(
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
    required VoidCallback onTap,
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
          trailing: Icon(Icons.chevron_right, size: 18, color: Colors.grey[600]),
          onTap: onTap,
        ),
      ),
    );
  }
}