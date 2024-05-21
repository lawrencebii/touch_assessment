import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:touch_assessment/features/Home/Models/user_model.dart';
import 'package:touch_assessment/features/Home/Views/user_details_page.dart';
import 'package:touch_assessment/features/Home/home_provider.dart';

import 'expandable_text.dart';

class UserCard extends StatelessWidget {
  UserModel userModel;
  UserCard({super.key, required this.userModel});
  String extractInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';
    for (var part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Card(
          elevation:
              userModel.id.toString() == provider.maxedID.toString() ? 5 : 0,
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<HomeProvider>().setMaxedId(userModel.id);
                  },
                  child: CircleAvatar(
                    child: Text(extractInitials(userModel.name)),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<HomeProvider>().setMaxedId(userModel.id);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          userModel.occupation,
                          style: TextStyle(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                        SelectableText(
                          userModel.email,
                          style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontSize: 10,
                          ),
                        ),
                        ExpandableText(
                          text: userModel.bio,
                          id: userModel.id,
                        ),
                      ].animate(interval: 400.ms).fade(duration: 300.ms),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditUserPage()));

                    context
                        .read<HomeProvider>()
                        .getOneUser(context, userModel.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().scale(),
        );
      },
    );
  }
}
