import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_assessment/features/Home/Models/user_model.dart';
import 'package:touch_assessment/features/Home/home_provider.dart';

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
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Text(extractInitials(userModel.name)),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(userModel.name),
                    Text(userModel.occupation),
                    SelectableText(
                      userModel.email,
                      style: TextStyle(
                        color: Theme.of(context).hintColor.withOpacity(0.5),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      userModel.bio,
                      maxLines: userModel.id == provider.maxedID ? null : 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).hintColor.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
