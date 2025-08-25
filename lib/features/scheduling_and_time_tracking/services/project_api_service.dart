import 'package:jesusvlsco/core/models/response_data.dart';
import 'package:jesusvlsco/core/services/network_caller.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:logger/logger.dart';

/// ProjectApiService handles all project-related API calls
/// This service manages communication with the project endpoints
class ProjectApiService {
  final NetworkCaller _networkCaller = NetworkCaller();
  final Logger _logger = Logger();

  /// Fetch all admin projects with pagination
  /// [page] - Page number (default: 1)
  /// [limit] - Number of projects per page (default: 10)
  /// Returns ResponseData containing project list or error
  Future<ResponseData> getAllAdminProjects({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL with query parameters
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.allAdminProjects}?page=$page&limit=$limit';

      _logger.i('Fetching admin projects: Page $page, Limit $limit');

      // Make GET request to fetch projects
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i(
          'Successfully fetched ${response.responseData['data']['projects'].length} projects',
        );
      } else {
        _logger.e('Failed to fetch projects: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in getAllAdminProjects: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to fetch projects. Please try again.',
      );
    }
  }

  /// Delete project by ID using DELETE method
  /// [projectId] - ID of the project to delete
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> deleteProjectById({required String projectId}) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Replace {id} placeholder with actual project ID
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.deleteProjectById.replaceAll('{id}', projectId)}';

      _logger.i('Deleting project with ID: $projectId');

      // Make DELETE request
      final ResponseData response = await _networkCaller.deleteRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully deleted project: $projectId');
      } else {
        _logger.e('Failed to delete project: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in deleteProjectById: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to delete project. Please try again.',
      );
    }
  }

  /// Update project title using PATCH method
  /// [projectId] - ID of the project to update
  /// [newTitle] - New title for the project
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> updateProjectTitle({
    required String projectId,
    required String newTitle,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Replace {projectId} placeholder with actual project ID
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.updateProjectTitle.replaceAll('{projectId}', projectId)}';

      _logger.i('Updating project title: $projectId -> $newTitle');

      // Make PATCH request with new title
      final ResponseData response = await _networkCaller.patchRequest(
        url,
        body: {'title': newTitle},
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully updated project title: $projectId');
      } else {
        _logger.e('Failed to update project title: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in updateProjectTitle: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to update project title. Please try again.',
      );
    }
  }

  /// Update project by ID (full update)
  /// [projectId] - ID of the project to update
  /// [projectData] - Map containing updated project data
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> updateProjectById({
    required String projectId,
    required Map<String, dynamic> projectData,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Replace {id} placeholder with actual project ID
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.updateProjectById.replaceAll('{id}', projectId)}';

      _logger.i('Updating project: $projectId');

      // Make POST request with project data
      final ResponseData response = await _networkCaller.postRequest(
        url,
        body: projectData.map((key, value) => MapEntry(key, value.toString())),
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully updated project: $projectId');
      } else {
        _logger.e('Failed to update project: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in updateProjectById: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to update project. Please try again.',
      );
    }
  }

  /// Search projects with pagination
  /// [keyword] - Search keyword
  /// [page] - Page number (default: 1)
  /// [limit] - Number of projects per page (default: 10)
  /// Returns ResponseData containing search results or error
  Future<ResponseData> searchProjects({
    required String keyword,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL with search keyword and pagination
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.searchProject.replaceAll('{keyword}', keyword)}&page=$page&limit=$limit';

      _logger.i('Searching projects: "$keyword" - Page $page, Limit $limit');

      // Make GET request to search projects
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i(
          'Successfully found ${response.responseData['data']['projects'].length} projects for "$keyword"',
        );
      } else {
        _logger.e('Failed to search projects: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in searchProjects: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to search projects. Please try again.',
      );
    }
  }
}
