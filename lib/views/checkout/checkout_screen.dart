import 'package:flutter/material.dart';
import '../../app/routes.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Delivery Address",
                style: TextStyle(color: Colors.white, fontSize: 18)),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dinesh Lakshan",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 5),
                  Text("Colombo, Sri Lanka",
                      style: TextStyle(color: Colors.white54)),
                  Text("0771234567",
                      style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text("Payment Method",
                style: TextStyle(color: Colors.white, fontSize: 18)),

            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.credit_card, color: Color.fromARGB(255, 222, 103, 6)),
                    title: Text("Credit / Debit Card",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Divider(color: Colors.grey),
                  ListTile(
                    leading: Icon(Icons.money, color: Color.fromARGB(238, 213, 92, 5)),
                    title: Text("Cash on Delivery",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text("Order Summary",
                style: TextStyle(color: Colors.white, fontSize: 18)),

            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  ListTile(
                    title: Text("Jacket",
                        style: TextStyle(color: Colors.white)),
                    trailing: Text("\$120",
                        style: TextStyle(color: Color.fromARGB(255, 233, 104, 5))),
                  ),
                  ListTile(
                    title: Text("T-Shirt",
                        style: TextStyle(color: Colors.white)),
                    trailing: Text("\$50",
                        style: TextStyle(color: Color.fromARGB(255, 225, 82, 5))),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                Text("\$170",
                    style: TextStyle(color: Color.fromARGB(255, 243, 109, 6), fontSize: 18)),
              ],
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 222, 86, 7),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Order placed successfully!",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  Routes.home, 
                  (route) => false,
                );
              },
              child: const Text(
                "Place Order",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}