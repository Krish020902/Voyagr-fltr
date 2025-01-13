import 'package:Voyagr/pages/ratings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileContainer extends GetxController {
  // Map<String, dynamic>? _userData;

  var userData = <String, dynamic>{}.obs;
  final Color _tealColor = Colors.teal;
  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      userData.value = jsonDecode(userString);
    }
  }
}

class ProfilePage extends StatelessWidget {
  final ProfileContainer profileContainer = Get.put(ProfileContainer());

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(width: 16),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profileContainer.userData['first_name'] ?? ''} ${profileContainer.userData['last_name'] ?? ''}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profileContainer.userData['email']?.toString() ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool showDivider = true,
    bool showChevron = false,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: profileContainer._tealColor),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          trailing:
              trailing ?? (showChevron ? Icon(Icons.chevron_right) : null),
          onTap: onTap,
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileContainer.userData.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(color: profileContainer._tealColor))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildSectionTitle('My Account'),
                  _buildListItem(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    subtitle: 'Manage your personal information',
                  ),
                  _buildListItem(
                    onTap: () => Get.to(() => RatingsPage()),
                    icon: Icons.rate_review,
                    title: 'My Ratings',
                    subtitle: 'Manage and track your ratings',
                  ),
                  _buildListItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    subtitle: 'Manage travel settings and preferences',
                    showChevron: true,
                  ),
                  _buildListItem(
                      icon: Icons.location_on_outlined,
                      title: 'Add dream destinations',
                      subtitle: 'Access saved favourite places and trips',
                      showChevron: true),
                  _buildListItem(
                    icon: Icons.bookmark_outline,
                    title: 'My Favourites',
                    subtitle: 'Access saved favourite places and trips',
                  ),
                  _buildListItem(
                    icon: Icons.card_giftcard,
                    title: 'Refer & Earn',
                    subtitle: 'Earn rewards by referring friends',
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'New',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  _buildSectionTitle('Help'),
                  _buildListItem(
                    icon: Icons.help_center_outlined,
                    title: 'FAQs',
                    subtitle: 'Find answers to your questions',
                  ),
                  _buildListItem(
                    icon: Icons.support_agent,
                    title: 'Customer Support',
                    subtitle: 'Customer support and assistance',
                    showDivider: false,
                  ),
                  _buildSectionTitle('Settings'),
                  _buildListItem(
                    icon: Icons.delete_forever_outlined,
                    title: 'Delete Account',
                    subtitle: 'Permanently delete your account',
                  ),
                  _buildListItem(
                    icon: Icons.description_outlined,
                    title: 'Terms and Conditions',
                    subtitle: 'Review our terms and conditions',
                  ),
                  _buildListItem(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      subtitle: 'Review our privacy policy',
                      showChevron: true),
                  _buildListItem(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    subtitle: 'App logout',
                    showDivider: false,
                  ),
                ],
              ),
            ),
    );
  }

  // _ProfilePageState createState() => _ProfilePageState();
}

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _userData = jsonDecode(prefs.getString('user') ?? '{}');
//     });
//   }
// }
