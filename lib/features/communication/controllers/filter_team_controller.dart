import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller for managing dropdown state and functionality
class DropdownController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxList<String> _allItems = <String>[].obs;
  final RxList<String> _filteredItems = <String>[].obs;
  final RxList<String> _selectedItems = <String>[].obs;
  final RxBool _isOpen = false.obs;

  // Getters
  List<String> get allItems => _allItems;
  List<String> get filteredItems => _filteredItems;
  List<String> get selectedItems => _selectedItems;
  bool get isOpen => _isOpen.value;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_filterItems);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Initialize dropdown with items
  void initializeItems(List<String> items) {
    _allItems.assignAll(items);
    _filteredItems.assignAll(items);
  }

  // Filter items based on search query
  void _filterItems() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredItems.assignAll(_allItems);
    } else {
      _filteredItems.assignAll(
        _allItems.where((item) => item.toLowerCase().contains(query)).toList(),
      );
    }
  }

  // Toggle dropdown open/close state
  void toggleDropdown() {
    _isOpen.value = !_isOpen.value;
    if (!_isOpen.value) {
      searchController.clear();
    }
  }

  // Close dropdown
  void closeDropdown() {
    _isOpen.value = false;
    searchController.clear();
  }

  // Select/deselect item
  void toggleItemSelection(String item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }
  }

  // Clear all selections
  void clearSelection() {
    _selectedItems.clear();
  }

  // Select all filtered items
  void selectAll() {
    _selectedItems.assignAll(_filteredItems);
  }

  // Get display text for dropdown button
  String getDisplayText(String hintText) {
    if (_selectedItems.isEmpty) return hintText;
    if (_selectedItems.length == 1) return _selectedItems.first;
    return '${_selectedItems.length} teams selected';
  }

  // Check if item is selected
  bool isItemSelected(String item) {
    return _selectedItems.contains(item);
  }

  // Get selected value (last selected item or null)
  String? getSelectedValue() {
    return _selectedItems.isNotEmpty ? _selectedItems.last : null;
  }
}

// Custom Dropdown Widget
class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final double? height;
  final String? tag; // For GetX controller tag

  const CustomDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    this.hintText = "Select Team",
    this.height = 48,
    this.tag,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late DropdownController controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller with tag if provided
    controller = Get.put(DropdownController(), tag: widget.tag);
    controller.initializeItems(widget.items);
  }

  @override
  void dispose() {
    _removeOverlay();
    // Remove controller when widget is disposed
    if (widget.tag != null) {
      Get.delete<DropdownController>(tag: widget.tag);
    }
    super.dispose();
  }

  void _toggleDropdown() {
    controller.isOpen ? _removeOverlay() : _showOverlay();
    controller.toggleDropdown();
  }

  void _showOverlay() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height + 4),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSearchField(),
                _buildActionButtons(),
                _buildItemsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextField(
        controller: controller.searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search by names',
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.clearSelection();
              widget.onChanged(null);
              _overlayEntry?.markNeedsBuild();
            },
            child: Text(
              'Clear',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.selectAll();
              widget.onChanged(controller.getSelectedValue());
              _overlayEntry?.markNeedsBuild();
            },
            child: Text(
              'Select all',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.filteredItems.length,
          itemBuilder: (context, index) {
            final item = controller.filteredItems[index];
            final isSelected = controller.isItemSelected(item);
            final isTeamB = item == 'Team B';

            return InkWell(
              onTap: () {
                controller.toggleItemSelection(item);
                widget.onChanged(controller.getSelectedValue());
                _overlayEntry?.markNeedsBuild();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: isSelected ? Colors.blue.shade50 : null,
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(3),
                        color: isSelected ? Colors.blue : null,
                      ),
                      child: isSelected
                          ? Icon(Icons.check, size: 12, color: Colors.white)
                          : null,
                    ),
                    SizedBox(width: 12),
                    Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: isTeamB ? Colors.blue : Colors.black87,
                        fontWeight: isTeamB
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(
                  () => Text(
                    controller.getDisplayText(widget.hintText),
                    style: TextStyle(
                      fontSize: 14,
                      color: controller.selectedItems.isEmpty
                          ? Colors.grey.shade600
                          : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Obx(
                () => Icon(
                  controller.isOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy data list directly in the page
final List<String> dummyTeams = [
  'Team A',
  'Team B',
  'Team C',
  'Team D',
  'Alpha Team',
  'Beta Team',
  'Gamma Team',
  'Delta Team',
  'Development Team',
  'Marketing Team',
];

final RxnString selectedTeam = RxnString();

void onTeamChanged(String? value) {
  selectedTeam.value = value;
  if (value != null) {
    if (kDebugMode) {
      print('Selected team: $value');
    }
  }
}
