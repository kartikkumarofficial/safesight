import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/user_controller.dart';
import '../../controllers/theme_controller.dart';
import '../widgets/fadedDivider.dart';
import '../widgets/profile_tile.dart';
import 'edit_accountdetails_screen.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ThemeController themeController = Get.find<ThemeController>();
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    userController.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: userController.fetchUserProfile,
        child: Stack(
          children: [
            Obx(() => userController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView(
              children: [
                const SizedBox(height: 45),
                Center(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(2.5), // space between image and border
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: Get.width * 0.18,
                        backgroundImage: userController.profileImageUrl.value.isNotEmpty
                            ? NetworkImage(userController.profileImageUrl.value)
                            : const AssetImage('assets/default_profile.png') as ImageProvider,
                      ),
                    ),
                  ),

                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    userController.userName.value,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    userController.email.value,
                    style: GoogleFonts.barlow(color: Colors.grey[700]),
                  ),
                ),
                const SizedBox(height: 28),




                //floating stats section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Journeys Taken
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              userController.journeysTaken.value
                                  .toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              "Journeys Taken",
                              style: GoogleFonts.labrada(
                                color: Colors.grey[600],
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadedDividerVertical(),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              userController.rating.value
                                  .toStringAsFixed(1),
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              "Rating",
                              style: GoogleFonts.labrada(
                                color: Colors.grey[600],
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      FadedDividerVertical(),

                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userController.milesTraveled.value.toInt()} ",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              "Miles Traveled",
                              style: GoogleFonts.labrada(
                                color: Colors.grey[600],
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                FadedDividerHorizontal(),


                // about me
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Me",
                        style: GoogleFonts.barlow(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Text(
                        userController.about.value.isNotEmpty
                            ? userController.about.value
                            : "No description added yet.",
                        style: GoogleFonts.barlow(
                          color: Colors.grey[700],
                          fontSize: 15,
                          height: 1.5,
                        ),
                      )),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // account option

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileTile(
                        onTap: () async {
                          final result = await Get.to(() => EditAccountPage());
                          if (result == true) {
                            userController.fetchUserProfile();
                          }
                        },
                        icon: Icons.settings,
                        label: "Edit Account Details",
                      ),


                      // New Tiles
                      ProfileTile(
                        icon: Icons.help_outline,
                        label: "Help & Support",
                        onTap: () {

                        },
                      ),
                      ProfileTile(
                        icon: Icons.card_giftcard,
                        label: "Refer & Earn",
                        onTap: () {

                        },
                      ),
                    ],
                  ),
                ),


                // const SizedBox(height: 24),

                TextButton.icon(
                  onPressed: () {
                    userController.logout();
                  },
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                // const SizedBox(height: 5),
                Center(
                  child: Text(
                    "v1.0.0 • SafeSight",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
