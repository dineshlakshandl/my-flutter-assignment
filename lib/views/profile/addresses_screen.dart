import 'package:flutter/material.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  int _selectedAddressId = 1;

  final List<Map<String, dynamic>> savedAddresses = [
    {
      "id": 1,
      "label": "Home",
      "icon": Icons.home_filled,
      "name": "Dinesh Lakshan",
      "street": "123 Main Street, Apartment 4B",
      "city": "Colombo 03, Western Province",
      "phone": "+94 77 123 4567",
    },
    {
      "id": 2,
      "label": "Work",
      "icon": Icons.work,
      "name": "Dinesh Lakshan",
      "street": "Tech Park Building, 5th Floor",
      "city": "Colombo 01, Western Province",
      "phone": "+94 77 987 6543",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), 
      
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Delivery Addresses",
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'serif', 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      body: savedAddresses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedAddresses.length,
              itemBuilder: (context, index) {
                final address = savedAddresses[index];
                final isSelected = _selectedAddressId == address["id"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAddressId = address["id"];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E), 
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFF97316) : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  address["icon"], 
                                  color: isSelected ? const Color(0xFFF97316) : Colors.white70,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  address["label"],
                                  style: TextStyle(
                                    color: isSelected ? const Color(0xFFF97316) : Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                              color: isSelected ? const Color(0xFFF97316) : Colors.grey[600],
                              size: 22,
                            ),
                          ],
                        ),
                        
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Colors.white10, thickness: 1),
                        ),
                        
                        Text(
                          address["name"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          address["street"],
                          style: TextStyle(color: Colors.grey[400], fontSize: 14, height: 1.5),
                        ),
                        Text(
                          address["city"],
                          style: TextStyle(color: Colors.grey[400], fontSize: 14, height: 1.5),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Phone: ${address["phone"]}",
                          style: TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF141414),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF97316), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Add New Address",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_outlined, 
              size: 60, 
              color: Color(0xFFF97316), 
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "No Saved Addresses",
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add an address to speed up checkout.",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}