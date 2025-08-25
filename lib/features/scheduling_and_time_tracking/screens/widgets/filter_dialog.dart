import 'package:flutter/material.dart';
import '../../../../core/utils/constants/sizer.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/common/styles/global_text_style.dart';

/// Comprehensive filter dialog for employee assignment
/// Allows filtering by assigned status, completion status, publish state and more
class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  // Filter states for each dropdown section
  bool showAssignedDropdown = false;
  bool showStatusDropdown = false;
  bool showPublishedDropdown = false;
  bool showAvailableUsersDropdown = false;
  bool showWithShiftsDropdown = false;
  bool showGroupDropdown = false;

  // Selected filter values
  Set<String> selectedAssigned = {};
  Set<String> selectedStatus = {};
  Set<String> selectedPublished = {};
  Set<String> selectedAvailableUsers = {};
  Set<String> selectedWithShifts = {};
  Set<String> selectedGroups = {};

  /// Toggles dropdown visibility and closes others
  void _toggleDropdown(String dropdownType) {
    setState(() {
      // Check if the current dropdown is already open
      bool isCurrentlyOpen = false;

      switch (dropdownType) {
        case 'assigned':
          isCurrentlyOpen = showAssignedDropdown;
          break;
        case 'status':
          isCurrentlyOpen = showStatusDropdown;
          break;
        case 'published':
          isCurrentlyOpen = showPublishedDropdown;
          break;
        case 'availableUsers':
          isCurrentlyOpen = showAvailableUsersDropdown;
          break;
        case 'withShifts':
          isCurrentlyOpen = showWithShiftsDropdown;
          break;
        case 'group':
          isCurrentlyOpen = showGroupDropdown;
          break;
      }

      // Close all dropdowns first
      showAssignedDropdown = false;
      showStatusDropdown = false;
      showPublishedDropdown = false;
      showAvailableUsersDropdown = false;
      showWithShiftsDropdown = false;
      showGroupDropdown = false;

      // If the dropdown was closed, open it; if it was open, keep it closed
      if (!isCurrentlyOpen) {
        switch (dropdownType) {
          case 'assigned':
            showAssignedDropdown = true;
            break;
          case 'status':
            showStatusDropdown = true;
            break;
          case 'published':
            showPublishedDropdown = true;
            break;
          case 'availableUsers':
            showAvailableUsersDropdown = true;
            break;
          case 'withShifts':
            showWithShiftsDropdown = true;
            break;
          case 'group':
            showGroupDropdown = true;
            break;
        }
      }
    });
  }

  /// Builds a filter section header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizer.hp(16)),
      child: Text(
        title,
        style: AppTextStyle.f16W600().copyWith(
          fontSize: Sizer.wp(16),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Builds a dropdown button with selected count indicator
  Widget _buildDropdownButton({
    required String label,
    required String dropdownType,
    required Set<String> selectedItems,
    required bool isOpen,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _toggleDropdown(dropdownType),
          behavior: HitTestBehavior.opaque, // Prevent tap propagation
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(16),
              vertical: Sizer.hp(12),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isOpen ? AppColors.primary : AppColors.border,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedItems.isEmpty
                      ? label
                      : '$label (${selectedItems.length})',
                  style: AppTextStyle.f14W400().copyWith(
                    color: selectedItems.isEmpty
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: Sizer.wp(20),
                ),
              ],
            ),
          ),
        ),
        if (isOpen) _buildDropdownContent(dropdownType, selectedItems),
      ],
    );
  }

  /// Builds dropdown content based on type
  Widget _buildDropdownContent(String dropdownType, Set<String> selectedItems) {
    List<String> options;

    switch (dropdownType) {
      case 'assigned':
        options = ['Assigned', 'Unassigned'];
        break;
      case 'status':
        options = ['Completed', 'Incompleted'];
        break;
      case 'published':
        options = ['Published', 'Draft'];
        break;
      case 'availableUsers':
        options = ['Available', 'Unavailable', 'Busy'];
        break;
      case 'withShifts':
        options = ['With Shifts', 'Without Shifts'];
        break;
      case 'group':
        options = [
          'Marketing Team',
          'Development Team',
          'Sales Team',
          'HR Team',
        ];
        break;
      default:
        options = [];
    }

    return GestureDetector(
      onTap: () {}, // Absorb taps to prevent propagation
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(top: Sizer.hp(4)),
        padding: EdgeInsets.all(Sizer.wp(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: options.map((option) {
            final isSelected = selectedItems.contains(option);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedItems.remove(option);
                  } else {
                    selectedItems.add(option);
                  }
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Sizer.hp(8)),
                child: Row(
                  children: [
                    Container(
                      width: Sizer.wp(20),
                      height: Sizer.wp(20),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: Sizer.wp(14),
                            )
                          : null,
                    ),
                    SizedBox(width: Sizer.wp(12)),
                    Text(
                      option,
                      style: AppTextStyle.f14W400().copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Applies all selected filters
  void _applyFilters() {
    // Collect all filter data
    final filterData = {
      'assigned': selectedAssigned.toList(),
      'status': selectedStatus.toList(),
      'published': selectedPublished.toList(),
      'availableUsers': selectedAvailableUsers.toList(),
      'withShifts': selectedWithShifts.toList(),
      'groups': selectedGroups.toList(),
    };

    // Return filter data and close dialog
    Navigator.of(context).pop(filterData);
  }

  /// Closes all dropdowns
  void _closeAllDropdowns() {
    setState(() {
      showAssignedDropdown = false;
      showStatusDropdown = false;
      showPublishedDropdown = false;
      showAvailableUsersDropdown = false;
      showWithShiftsDropdown = false;
      showGroupDropdown = false;
    });
  }

  /// Clears all selected filters
  void _clearAllFilters() {
    setState(() {
      selectedAssigned.clear();
      selectedStatus.clear();
      selectedPublished.clear();
      selectedAvailableUsers.clear();
      selectedWithShifts.clear();
      selectedGroups.clear();
      // Also close all dropdowns when clearing
      _closeAllDropdowns();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: GestureDetector(
        onTap: _closeAllDropdowns, // Close dropdowns when tapping outside
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: EdgeInsets.all(Sizer.wp(20)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dialog Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: AppTextStyle.f18W600().copyWith(
                      fontSize: Sizer.wp(18),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      size: Sizer.wp(24),
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: Sizer.hp(24)),

              // Scrollable content area
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Shifts Section
                      _buildSectionHeader('Filter Shifts'),

                      // Assigned/Unassigned Dropdown
                      _buildDropdownButton(
                        label: 'Assigned',
                        dropdownType: 'assigned',
                        selectedItems: selectedAssigned,
                        isOpen: showAssignedDropdown,
                      ),

                      SizedBox(height: Sizer.hp(16)),

                      // Status Dropdown
                      _buildDropdownButton(
                        label: 'Status',
                        dropdownType: 'status',
                        selectedItems: selectedStatus,
                        isOpen: showStatusDropdown,
                      ),

                      SizedBox(height: Sizer.hp(16)),

                      // Published/Draft Dropdown
                      _buildDropdownButton(
                        label: 'Published',
                        dropdownType: 'published',
                        selectedItems: selectedPublished,
                        isOpen: showPublishedDropdown,
                      ),

                      SizedBox(height: Sizer.hp(24)),

                      // Filter Users Section
                      _buildSectionHeader('Filter Users'),

                      // Available Users Dropdown
                      _buildDropdownButton(
                        label: 'Available Users',
                        dropdownType: 'availableUsers',
                        selectedItems: selectedAvailableUsers,
                        isOpen: showAvailableUsersDropdown,
                      ),

                      SizedBox(height: Sizer.hp(16)),

                      // With Shifts Dropdown
                      _buildDropdownButton(
                        label: 'With Shifts',
                        dropdownType: 'withShifts',
                        selectedItems: selectedWithShifts,
                        isOpen: showWithShiftsDropdown,
                      ),

                      SizedBox(height: Sizer.hp(16)),

                      // Group Dropdown
                      _buildDropdownButton(
                        label: 'Group',
                        dropdownType: 'group',
                        selectedItems: selectedGroups,
                        isOpen: showGroupDropdown,
                      ),

                      SizedBox(height: Sizer.hp(16)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Sizer.hp(16)),

              // Action Buttons (Fixed at bottom)
              Row(
                children: [
                  // Clear All Button
                  Expanded(
                    child: GestureDetector(
                      onTap: _clearAllFilters,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Sizer.hp(12)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Clear All',
                            style: AppTextStyle.f14W600().copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: Sizer.wp(12)),

                  // Apply Filter Button
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: _applyFilters,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Sizer.hp(12)),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Apply Filter',
                            style: AppTextStyle.f14W600().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
