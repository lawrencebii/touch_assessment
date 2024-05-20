import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_assessment/features/Home/Components/user_card.dart';
import 'package:touch_assessment/features/Home/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getUsers(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              if (provider.loadingUsers) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Loading users'),
                  ],
                );
              }
              if (provider.users.isNotEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(provider.users.length,
                          (index) => UserCard(userModel: provider.users[index]))
                    ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No users'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
