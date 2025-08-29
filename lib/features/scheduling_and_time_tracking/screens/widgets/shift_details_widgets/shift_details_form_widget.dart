import 'package:flutter/material.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/shift_details_controller.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class ShiftDetailsFormWidget extends StatelessWidget {
  final ShiftDetailsController controller;

  const ShiftDetailsFormWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shift Title
        _buildFormField(
          label: 'Shift Title',
          hintText: 'Type Here',
          controller: controller.shiftTitleController,
        ),

        SizedBox(height: Sizer.hp(24)),

        // Job
        _buildFormField(
          label: 'Job',
          hintText: 'Type Job',
          controller: controller.jobController,
          isDropdown: false,
        ),
        SizedBox(height: Sizer.hp(24)),

        // Location
        _buildFormField(
          label: 'Location',
          hintText: 'Type Location',
          controller: controller.locationController,
          hasLocationIcon: true,
          onLocationTap: () => controller.pickCurrentLocation(),
          onChanged: (value) => controller.searchLocation(value),
          isLocationField: true,
        ),

        // Map Widget - Show when location is picked
        Obx(() {
          if (controller.isSearching.value) {
            return Column(
              children: [
                SizedBox(height: Sizer.hp(12)),
                Container(
                  height: Sizer.hp(60),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFC8CAE7)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Searching location...'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          if (controller.showMap.value &&
              controller.latitude != null &&
              controller.longitude != null) {
            return Column(
              children: [
                SizedBox(height: Sizer.hp(12)),
                Container(
                  height: Sizer.hp(200),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFC8CAE7)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          controller.latitude!,
                          controller.longitude!,
                        ),
                        zoom: 15.0,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('selected_location'),
                          position: LatLng(
                            controller.latitude!,
                            controller.longitude!,
                          ),
                          infoWindow: const InfoWindow(
                            title: 'Selected Location',
                          ),
                        ),
                      },
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      onTap: (LatLng position) {
                        // Allow user to select different location by tapping on map
                        controller.selectLocation(
                          position.latitude,
                          position.longitude,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),

        SizedBox(height: Sizer.hp(24)),

        // Note
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormField(
              label: 'Description',
              hintText: 'Type Description',
              controller: controller.noteController,
              maxLines: 4,
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual form field widget
  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isDropdown = false,
    int maxLines = 1,
    Widget? suffixIcon,
    bool hasLocationIcon = false,
    VoidCallback? onLocationTap,
    Function(String)? onChanged,
    bool isLocationField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with optional location icon
        hasLocationIcon
            ? Row(
                children: [
                  Text(
                    label,
                    style: AppTextStyle.f16W600().copyWith(
                      color: const Color(0xFF484848),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(width: Sizer.wp(8)),
                  GestureDetector(
                    onTap: onLocationTap,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ],
              )
            : Text(
                label,
                style: AppTextStyle.f16W600().copyWith(
                  color: const Color(0xFF484848),
                  height: 1.5,
                ),
              ),
        SizedBox(height: Sizer.hp(8)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Sizer.wp(12)),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC8CAE7)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            onChanged: onChanged,
            style: AppTextStyle.f12W400().copyWith(
              color: const Color(0xFF949494),
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyle.f12W400().copyWith(
                color: const Color(0xFF949494),
                height: 1.5,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
              suffixIcon: isDropdown
                  ? Icon(
                      Icons.keyboard_arrow_down,
                      size: Sizer.wp(20),
                      color: const Color(0xFF949494),
                    )
                  : (hasLocationIcon ? null : suffixIcon),
            ),
          ),
        ),
      ],
    );
  }
}
