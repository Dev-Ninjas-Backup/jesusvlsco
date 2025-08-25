import 'package:jesusvlsco/core/models/response_data.dart';
import 'package:jesusvlsco/core/services/network_caller.dart';
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
  /// [token] - Authorization token
  /// Returns ResponseData containing project list or error
  Future<ResponseData> getAllAdminProjects({
    int page = 1,
    int limit = 10,
    String? token,
  }) async {
    try {
      // Construct URL with query parameters
      final String url = '${ApiConstants.baseurl}${ApiConstants.allAdminProjects}?page=$page&limit=$limit';
      
      _logger.i('Fetching admin projects: Page $page, Limit $limit');
      
      // Make GET request to fetch projects
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token,
      );
      
      if (response.isSuccess) {
        _logger.i('Successfully fetched ${response.responseData['data']['projects'].length} projects');
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

  /// Delete project by ID
  /// [projectId] - ID of the project to delete
  /// [token] - Authorization token
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> deleteProjectById({
    required String projectId,
    String? token,
  }) async {
    try {
      // Replace {id} placeholder with actual project ID
      final String url = '${ApiConstants.baseurl}${ApiConstants.deleteProjectById.replaceAll('{id}', projectId)}';
      
      _logger.i('Deleting project with ID: $projectId');
      
      // Make DELETE request
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token,
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

  /// Update project title
  /// [projectId] - ID of the project to update
  /// [newTitle] - New title for the project
  /// [token] - Authorization token
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> updateProjectTitle({
    required String projectId,
    required String newTitle,
    String? token,
  }) async {
    try {
      // Replace {projectId} placeholder with actual project ID
      final String url = '${ApiConstants.baseurl}${ApiConstants.updateProjectTitle.replaceAll('{projectId}', projectId)}';
      
      _logger.i('Updating project title: $projectId -> $newTitle');
      
      // Make POST request with new title
      final ResponseData response = await _networkCaller.postRequest(
        url,
        body: {'title': newTitle},
        token: token,
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
  /// [token] - Authorization token
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> updateProjectById({
    required String projectId,
    required Map<String, dynamic> projectData,
    String? token,
  }) async {
    try {
      // Replace {id} placeholder with actual project ID
      final String url = '${ApiConstants.baseurl}${ApiConstants.updateProjectById.replaceAll('{id}', projectId)}';
      
      _logger.i('Updating project: $projectId');
      
      // Make POST request with project data
      final ResponseData response = await _networkCaller.postRequest(
        url,
        body: projectData.map((key, value) => MapEntry(key, value.toString())),
        token: token,
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
}
