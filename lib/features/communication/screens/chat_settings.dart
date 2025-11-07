import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';

class ChatSettingsScreen extends StatefulWidget {
  const ChatSettingsScreen({super.key});

  @override
  State<ChatSettingsScreen> createState() => _ChatSettingsScreenState();
}

class _ChatSettingsScreenState extends State<ChatSettingsScreen> {
  bool _enableNotifications = true;
  bool _chatSounds = true;
  bool _vibration = false;
  bool _messagePreview = true;
  bool _unreadBadge = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: Custom_appbar(title: "Chat Settings"),

      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 12),
            child: Text(
              "Message notification",
              style: AppTextStyle.f18W500().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          Divider(color: AppColors.dividerColor, height: 1),

          _buildSwitchListTile(
            title: 'Enable Message Notifications',
            subtitle: 'Receive notifications when new messages arrive',
            value: _enableNotifications,
            onChanged: (value) {
              setState(() {
                _enableNotifications = value;
              });
            },
          ),
          _buildSwitchListTile(
            title: 'Chat Sounds',
            subtitle: 'Play sound when receiving new messages',
            value: _chatSounds,
            onChanged: (value) {
              setState(() {
                _chatSounds = value;
              });
            },
          ),
          _buildSwitchListTile(
            title: 'Vibration',
            subtitle: 'Vibrate device when receiving messages (mobile only)',
            value: _vibration,
            onChanged: (value) {
              setState(() {
                _vibration = value;
              });
            },
          ),
          _buildSwitchListTile(
            title: 'Message Preview',
            subtitle: 'Show message content in notification previews',
            value: _messagePreview,
            onChanged: (value) {
              setState(() {
                _messagePreview = value;
              });
            },
          ),
          _buildSwitchListTile(
            title: 'Unread Chat Badge',
            subtitle: 'Show red badge with unread message count',
            value: _unreadBadge,
            onChanged: (value) {
              setState(() {
                _unreadBadge = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      children: [
        Card(
          color: AppColors.primaryBackground,
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: SwitchListTile(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.border2,
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
            value: value,
            onChanged: onChanged,
            inactiveThumbColor: AppColors.primaryBackground,
            activeThumbColor: AppColors.primaryBackground,
          ),
        ),
        Divider(color: AppColors.dividerColor, height: 1),
      ],
    );
  }
}
