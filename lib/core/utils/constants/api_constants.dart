class ApiConstants {
  static const baseurl = "https://lgcglobalcontractingltd.com/js";

  // ----------------------- Admin ------------------------

  //!-------------------- Shift Scheduling ------------------
  static const String allAdminProjects = '/admin/project';

  static const String createProject = '/admin/project'; // create new project

  static const String deleteProjectById =
      '/admin/project/{id}'; // delete project by id
  static const String updateProjectTitle =
      '/admin/project/{projectId}/update-title'; // update project title
  static const String searchProject =
      '/admin/project?search={keyword}'; // search project
  static const String getAllTeams =
      '/admin/team/get-all-teams'; // get all teams
  static const String getAllManager = '/admin/user'; // get all users
  //access Schedule Screen
  static const String getProjectById =
      '/admin/project/{id}'; // get project by id
  static const String allTimeOffRequests =
      '/admin/time-off-request/all-requests';
  static const String updateRequestApprovedOrRejected =
      '/admin/time-off-request/update-request/{id}'; // Patch

  //!-------------------- Shift Management ------------------
  static const String createShift = '/shift'; // POST /shift
  static const String getAllShifts = '/shift'; // GET /shift
  static const String getShiftById = '/shift/{id}'; // GET /shift/{id}
  static const String updateShift = '/shift/{id}'; // PUT /shift/{id}
  static const String deleteShift = '/shift/{id}'; // DELETE /shift/{id}

  //!-------------------- Payroll ------------------

  static const String payrollPayrate =
      '/admin/payroll/payrate'; // POST /admin/payroll/payrate/{userId}
  static const String payrollOffday =
      '/admin/payroll/offday'; // POST /admin/payroll/offday/{userId}

  //!-------------------- User Management ------------------

  static const String createUser = '/admin/user'; // POST /admin/user
  static const String createUserEducation =
      '/admin/user/education/create/multiple'; // POST /admin/user/education/create/multiple/{userId}
  static const String createUserExperience =
      '/admin/user/experience/create/user'; // POST /admin/user/experience/create/user/{userId}

  //--------------------------- Employee ---------------------------

  //!-------------------- Time Clock ------------------
  static const String processClock =
      '/employee/time-clock/process-clock'; // POST /employee/time-clock/process-clock
  static const String currentClock =
      '/employee/time-clock/shift/current-clock'; // GET /employee/time-clock/shift/current-clock
  // Employee dashboard
  static const String employeeDashboard =
      '/employee/dashboard'; // GET /employee/dashboard
}
