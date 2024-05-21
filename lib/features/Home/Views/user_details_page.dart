import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_assessment/features/Home/Components/field_modifier.dart';
import 'package:touch_assessment/features/Home/Components/text_field.dart';
import 'package:touch_assessment/features/Home/Components/user_card.dart';
import 'package:touch_assessment/features/Home/Models/user_model.dart';
import 'package:touch_assessment/features/Home/home_provider.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              if (provider.loadingUsers) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Loading ..'),
                    ],
                  ),
                );
              }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (provider.currentUser != null)
                      UserCard(userModel: provider.currentUser!),
                    SizedBox(
                      height: 20,
                    ),
                    ...titleAndField('Full Name', "Enter your full name",
                        provider.nameController, null),
                    ...titleAndField('Email', "Enter your email",
                        provider.emailController, null),
                    ...titleAndField('Occupation', "Enter your occupation",
                        provider.occupationController, null),
                    ...titleAndField(
                        'Bio', "Enter your bio", provider.bioController, 6),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          context
                              .read<HomeProvider>()
                              .patchUser(context, provider.currentUser!);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Update ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
