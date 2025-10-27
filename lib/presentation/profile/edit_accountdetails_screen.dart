import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/editaccount_controller.dart';

class EditAccountPage extends StatelessWidget {
  final accountController = Get.put(EditAccountController());

  EditAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon:   Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Get.back(result: true),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
            () => SingleChildScrollView(
          padding:   EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                SizedBox(height: 20),

              // Profile Picture
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: accountController.pickImage,
                    child: CircleAvatar(
                      radius: Get.width * 0.18,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                      accountController.selectedImage.value != null
                          ? FileImage(accountController.selectedImage.value!)
                          : accountController
                          .userController.profileImageUrl.value
                          .isNotEmpty
                          ? NetworkImage(accountController
                          .userController.profileImageUrl.value)
                          :   AssetImage(
                          'assets/default_profile.png')
                      as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      decoration:   BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      padding:   EdgeInsets.all(6),
                      child:   Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),

                SizedBox(height: 30),

              // Name Field
              buildRoundedTextField(
                label: "Full Name",
                controller: accountController.nameController,
                icon: CupertinoIcons.person,
              ),
                SizedBox(height: 18),

              // Email Field
              buildRoundedTextField(
                label: "Email",
                controller: accountController.emailController,
                icon: CupertinoIcons.mail,
              ),
                SizedBox(height: 18),

              // About Field
              buildRoundedTextField(
                label: "About",
                controller: accountController.aboutController,
                icon: null,
                maxLines: 3,
              ),

                SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding:   EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: Obx(
                  () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: accountController.isLoading.value
                    ? null
                    : accountController.saveChanges,
                child: accountController.isLoading.value
                    ?   CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5)
                    : Text(
                  'SAVE CHANGES',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom Rounded Input Field
  Widget buildRoundedTextField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 15.5,
      ),
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.grey[600], size: 20)
            : null,
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: Colors.grey[600],
          fontSize: 14.5,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
            BorderSide(color: Colors.deepPurpleAccent, width: 1),
        ),
      ),
    );
  }
}
