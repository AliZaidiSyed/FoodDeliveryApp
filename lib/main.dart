import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:firebasestorage/adminscreens/adminboard.dart';
import 'package:firebasestorage/adminscreens/adminlogin.dart';
import 'package:firebasestorage/adminscreens/mainpage.dart';
import 'package:firebasestorage/adminscreens/resturants.dart';
import 'package:firebasestorage/adminscreens/menus.dart';

import 'package:firebasestorage/uiscreens/cart.dart';
import 'package:firebasestorage/uiscreens/history.dart';
import 'package:firebasestorage/uiscreens/home.dart';
import 'package:firebasestorage/uiscreens/menu.dart';
import 'package:firebasestorage/uiscreens/profilescreen.dart';

import 'package:firebasestorage/userscreens/login.dart';
import 'package:firebasestorage/userscreens/sign.dart';
import 'package:firebasestorage/userscreens/welcome.dart';

import 'package:firebasestorage/models/cart_model.dart';
import 'package:firebasestorage/models/menu_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
  } catch (e) {
    print('Firebase initialization error: $e');
  }
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/mainpage',
    routes: [
      GoRoute(path: '/mainpage', builder: (context, state) => const MainPage()),
      GoRoute(path: '/adminlogin', builder: (context, state) => const AdminLogin()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      GoRoute(path: '/adminboard', builder: (context, state) =>  AdminScreen()),
      GoRoute(path: '/resturants', builder: (context, state) =>  ManageRestaurants()),
      GoRoute(
        path: '/menus',
        builder: (context, state) {
          final restaurantId = state.uri.queryParameters['restaurantId'] ?? '';
          final restaurantName = state.uri.queryParameters['restaurantName'] ?? '';
          return ManageMenus(restaurantId: restaurantId, restaurantName: restaurantName);
        },
      ),
    

      GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
      GoRoute(path: '/profilescreen', builder: (context, state) => const ProfileScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),

      GoRoute(
        path: '/menu',
        builder: (context, state) {
          final restaurantId = state.uri.queryParameters['restaurantId'] ?? '';
          final restaurantName = state.uri.queryParameters['restaurantName'] ?? '';
          return MenuScreen(restaurantId: restaurantId, restaurantName: restaurantName);
        },
      ),
      GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
      GoRoute(path: '/history', builder: (context, state) => const OrderHistory()),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => MenuModel(restaurantId: '')), 
        ChangeNotifierProxyProvider<MenuModel, CartModel>(
          create: (_) => CartModel(),
          update: (context, menu, cart) {
            cart!.menu = menu;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
      ),
    );
  }
}