import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/routes.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/order_viewmodel.dart';
import '../../viewmodels/profile_viewmodel.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;
  String _selectedPaymentMethod = "Credit / Debit Card";

  @override
  void initState() {
    super.initState();
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final userProfile = profileVM.userProfile;

    _nameController = TextEditingController(text: userProfile?.name.isNotEmpty == true ? userProfile!.name : "Dinesh Lakshan");
    _addressController = TextEditingController(text: userProfile?.address.isNotEmpty == true ? userProfile!.address : "123 Galle Road, Kalutara, Western Province, Sri Lanka");
    _phoneController = TextEditingController(text: userProfile?.phone.isNotEmpty == true ? userProfile!.phone : "0771234567");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handlePlaceOrder(CartViewModel cartVM, OrderViewModel orderVM) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (cartVM.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your cart is empty!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final success = await orderVM.placeOrder(
      recipientName: _nameController.text.trim(),
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
      paymentMethod: _selectedPaymentMethod,
      items: cartVM.cartItems,
      total: cartVM.getTotal(),
      cartVM: cartVM,
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order placed successfully!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
          context, 
          Routes.home, 
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to place order. Please try again."),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartVM = Provider.of<CartViewModel>(context);
    final orderVM = Provider.of<OrderViewModel>(context);
    final cartItems = cartVM.cartItems;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: orderVM.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFF97316)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Delivery Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'serif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF1E1E1E),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFF97316)),
                        ),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty ? "Name is required" : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _addressController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: "Delivery Address",
                        labelStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF1E1E1E),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFF97316)),
                        ),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty ? "Address is required" : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _phoneController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF1E1E1E),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFF97316)),
                        ),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty ? "Phone number is required" : null,
                    ),
                    
                    const SizedBox(height: 24),
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'serif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            activeColor: const Color(0xFFF97316),
                            title: const Text("Credit / Debit Card", style: TextStyle(color: Colors.white)),
                            secondary: const Icon(Icons.credit_card, color: Color(0xFFF97316)),
                            value: "Credit / Debit Card",
                            groupValue: _selectedPaymentMethod,
                            onChanged: (val) {
                              setState(() {
                                _selectedPaymentMethod = val!;
                              });
                            },
                          ),
                          const Divider(color: Colors.white10, height: 1),
                          RadioListTile<String>(
                            activeColor: const Color(0xFFF97316),
                            title: const Text("Cash on Delivery", style: TextStyle(color: Colors.white)),
                            secondary: const Icon(Icons.payments_outlined, color: Color(0xFFF97316)),
                            value: "Cash on Delivery",
                            groupValue: _selectedPaymentMethod,
                            onChanged: (val) {
                              setState(() {
                                _selectedPaymentMethod = val!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'serif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 1),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return ListTile(
                            title: Text(
                              "${item.product.name} (${item.size}) x${item.quantity}",
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              item.product.brand.toUpperCase(),
                              style: TextStyle(color: Colors.grey[500], fontSize: 10, letterSpacing: 1.0),
                            ),
                            trailing: Text(
                              "\$${(item.product.price * item.quantity).toStringAsFixed(0)}",
                              style: const TextStyle(color: Color(0xFFF97316), fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Amount",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        Text(
                          "\$${cartVM.getTotal().toStringAsFixed(0)}",
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF97316),
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => _handlePlaceOrder(cartVM, orderVM),
                      child: const Text(
                        "Place Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}