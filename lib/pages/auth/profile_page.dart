import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mumuchatapp/pages/auth/auth/login_page.dart';
import 'package:mumuchatapp/pages/auth/home_page.dart';
import 'package:mumuchatapp/service/auth_service.dart';
import 'package:mumuchatapp/widgets/widgets.dart';
import 'package:mumuchatapp/service/database_service.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.email, required this.userName})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  DatabaseService firebaseService = DatabaseService();

  File? profileImage;
  String? profileImageUrl;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey[700],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              nextScreen(context, const HomePage());
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.group, color: Color(0xFFee7b64)),
            title: const Text("Groups", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () {},
            selected: true,
            selectedColor: Theme.of(context).primaryColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.person),
            title: const Text("Profile", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: const Text(
                          "Logout",
                        ),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.exit_to_app,
                              color: Colors.green,
                            ),
                          ),
                        ]);
                  });
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    // child: profileImageUrl == null
                    child: profileImage == null
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom:
                                    MediaQuery.of(context).size.height * -0.020,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 236,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            child: ClipOval(
                              //   child: Image.network(
                              // profileImageUrl!,
                              child: Image.file(profileImage!,
                              fit: BoxFit.cover,
                              height: 236,
                              width: 236,
                            )),
                          ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.5,
                  top: MediaQuery.of(context).size.height * 0.175,
                  child: IconButton(
                    onPressed: () {
                      _showImageSourceActionSheet(context);
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Color(0xFFee7b64),
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Full Name", style: TextStyle(fontSize: 17)),
              Text(
                widget.userName,
                style: const TextStyle(fontSize: 17),
              )
            ]),
            const Divider(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Email", style: TextStyle(fontSize: 17)),
              Text(
                widget.email,
                style: const TextStyle(fontSize: 17),
              )
            ]),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        profileImage = File(image.path); // Set picked image
      });
      await firebaseService.uploadProfilePicture(File(image.path));
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Picture'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Remove Picture'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  profileImage = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
