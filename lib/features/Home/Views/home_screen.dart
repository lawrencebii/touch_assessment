import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_assessment/features/Home/Components/text_field.dart';
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
                      color: Theme.of(context).primaryColor,
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
                      TextFormFieldCustom1(
                        controller: provider.searchController,
                        prefixIcon: Icon(Icons.search),
                        onTap: () {
                          context.read<HomeProvider>().setIsSearching();
                        },
                        onChanged: (val) {
                          context.read<HomeProvider>().searchUsersFunction(val);
                        },
                        onFieldSubmitted: (val) {
                          context.read<HomeProvider>().searchUsersFunction(val);
                        },
                        action: TextInputAction.search,
                        hintText: "Search users by name, email or occupation",
                        hintStyle: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      if (provider.searchController.text.isNotEmpty)
                        Container(
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                if (provider.searchUsers.isNotEmpty)
                                  ...List.generate(
                                      provider.searchUsers.length,
                                      (index) => UserCard(
                                          userModel:
                                              provider.searchUsers[index])),
                                if (provider.searchUsers.isEmpty)
                                  Text("No matching users found"),
                              ],
                            ),
                          ),
                        ),
                      if (provider.searchController.text.isNotEmpty) Divider(),
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
