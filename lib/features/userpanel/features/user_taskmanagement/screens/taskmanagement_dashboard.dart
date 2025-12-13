import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart'; // Make sure GetX is in your pubspec
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/splasho_screen/controller/splasho_controller.dart';
// Import your SplashController (adjust path if needed)

class UserTaskmanagementDashboard extends StatefulWidget {
  const UserTaskmanagementDashboard({super.key});

  @override
  State<UserTaskmanagementDashboard> createState() =>
      _UserTaskmanagementDashboardState();
}

class _UserTaskmanagementDashboardState
    extends State<UserTaskmanagementDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Project> projects = [];
  bool isLoading = true;
  String? errorMessage;

  final splashController = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchProjects();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchProjects() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final token = await splashController.getAuthToken();

      if (token == null || token.isEmpty) {
        throw Exception("You are not logged in. Please login again.");
      }

      final response = await http.get(
        Uri.parse(
          'https://lgcglobalcontractingltd.com/js/employee/project/all',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;

        if (jsonData['success'] == true) {
          final List<dynamic> data = jsonData['data'];
          setState(() {
            projects = data.map((json) => Project.fromJson(json)).toList();
            isLoading = false;
          });
        } else {
          throw Exception(jsonData['message'] ?? 'Failed to load projects');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Session expired. Please login again.');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
        backgroundColor: Colors.white,
        elevation: 0.1,
        title: Text(
          'Task & Project Management',
          style: AppTextStyle.regular().copyWith(
            fontSize: Sizer.wp(20),
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: Sizer.hp(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            child: Container(
              height: Sizer.hp(48),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(Sizer.wp(8)),
                // ignore: deprecated_member_use
                border: Border.all(color: AppColors.border.withOpacity(0.3)),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(Sizer.wp(8)),
                ),
                indicatorPadding: EdgeInsets.all(Sizer.wp(4)),
                labelColor: AppColors.textWhite,
                unselectedLabelColor: AppColors.primary,
                labelStyle: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(16),
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(16),
                  fontWeight: FontWeight.w500,
                ),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: "All Projects"),
                  Tab(text: "My Tasks"),
                ],
              ),
            ),
          ),
          SizedBox(height: Sizer.hp(20)),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllProjectsContent(),
                const Center(
                  child: Text(
                    "My Tasks - Coming Soon",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllProjectsContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(Sizer.wp(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 20),
              const Text(
                "Oops! Something went wrong",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[600]),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: fetchProjects,
                icon: const Icon(Icons.refresh),
                label: const Text("Try Again"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (projects.isEmpty) {
      return const Center(
        child: Text(
          "No projects available",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchProjects,
      color: AppColors.primary,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(16),
          vertical: Sizer.hp(8),
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) => ProjectCard(project: projects[index]),
      ),
    );
  }
}

// ==================== MODEL & CARD (Perfect & Clean) ====================

class Project {
  final String id;
  final String title;
  final String projectLocation;
  final DateTime createdAt;
  final int taskCount;

  Project({
    required this.id,
    required this.title,
    required this.projectLocation,
    required this.createdAt,
    this.taskCount = 0,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled Project',
      projectLocation: json['projectLocation'] ?? 'No location',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      taskCount: (json['tasks'] as List<dynamic>?)?.length ?? 0,
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizer.hp(12)),
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(14)),
        // ignore: deprecated_member_use
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Sizer.wp(52),
                height: Sizer.wp(52),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.folder_open,
                  color: AppColors.primary,
                  size: Sizer.wp(28),
                ),
              ),
              SizedBox(width: Sizer.wp(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: AppTextStyle.regular().copyWith(
                        fontSize: Sizer.wp(18),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            project.projectLocation,
                            style: TextStyle(
                              fontSize: Sizer.wp(13.5),
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(14),
                  vertical: Sizer.hp(8),
                ),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "${project.taskCount} Tasks",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: Sizer.wp(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(height: 1, color: Colors.grey[200]),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Created ${_formatDate(project.createdAt)}",
                style: TextStyle(
                  fontSize: Sizer.wp(12.5),
                  color: Colors.grey[500],
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Yesterday";
    if (diff < 7) return "$diff days ago";
    if (diff < 30) return "${(diff / 7).floor()} weeks ago";
    return "${date.day}/${date.month}/${date.year}";
  }
}
