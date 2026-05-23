// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; 
import 'app/routes.dart';
import 'viewmodels/product_view_model.dart'; 
import 'viewmodels/cart_viewmodel.dart'; 
import 'viewmodels/order_viewmodel.dart'; 
import 'viewmodels/profile_viewmodel.dart'; 
import 'viewmodels/auth_viewmodel.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAM5hYllMO_PUIIrEH0LL4jYnRMQY-9W6M", 
      appId: "1:890588121660:android:7f088008aed0f0f2b85139",
      messagingSenderId: "890588121660",
      projectId: "fashion-store-app-e89e6",
      authDomain: "fashion-store-app-e89e6.firebaseapp.com",
      storageBucket: "fashion-store-app-e89e6.appspot.com",
    ),
  );
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fashion Store',
        theme: ThemeData.dark(),
        initialRoute: Routes.home,
        routes: Routes.getRoutes(),
      ),
    );
  }
}