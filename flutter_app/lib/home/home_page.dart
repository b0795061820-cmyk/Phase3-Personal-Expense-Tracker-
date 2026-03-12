import 'package:flutter/material.dart';

import '../features/expenses/presentation/pages/expenses_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';

import '../core/utils/token_storage.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../injection_container.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  final pages = [

    const ExpensesPage(),
    const DashboardPage(),

    const Center(
      child: Text("Profile Page"),
    ),

  ];

  Future<void> logout() async {

    await sl<TokenStorage>().clearToken();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => LoginPage(),
      ),
          (route) => false,
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Expense Tracker"),

        actions: [

          IconButton(

            icon: const Icon(Icons.logout),

            onPressed: logout,

          )

        ],

      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex = index;

          });

        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Expenses",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],

      ),

    );

  }

}