import 'package:flutter/foundation.dart';
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
  
  try {
    if (kIsWeb) {
      // Use web options if running on Web
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAM5hYllMO_PUIIrEH0LL4jYnRMQY-9W6M", 
          appId: "1:890588121660:web:d2ee7f4362b5d4bfb85139", 
          messagingSenderId: "890588121660",
          projectId: "fashion-store-app-e89e6",
          authDomain: "fashion-store-app-e89e6.firebaseapp.com",
          storageBucket: "fashion-store-app-e89e6.appspot.com",
        ),
      );
    } else {
      // Try to initialize using standard native configurations first (highly recommended for Android/iOS)
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint("Firebase primary initialization failed: $e");
    
    // Fallback block if default initialization throws an error (e.g. if plugin config is missing on mobile)
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAM5hYllMO_PUIIrEH0LL4jYnRMQY-9W6M", 
          appId: "1:890588121660:android:c9712e2f5ea5a76eb85139", // Correct App ID matching com.example.flutterapp
          messagingSenderId: "890588121660",
          projectId: "fashion-store-app-e89e6",
          authDomain: "fashion-store-app-e89e6.firebaseapp.com",
          storageBucket: "fashion-store-app-e89e6.appspot.com",
        ),
      );
    } catch (fallbackError) {
      debugPrint("Firebase fallback initialization failed: $fallbackError");
    }
  }
  
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