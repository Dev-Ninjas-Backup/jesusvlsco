class ApiConstants {
  static const baseurl = "http://148.230.86.72:5005/js";

  // ----------------------- Admin------------------------

  //!-------------------- Shift Scheduling ------------------

  static const String allAdminProjects = '/admin/project';
  static const String deleteProjectById =
      '/admin/project/{id}'; // delete project by id
  static const String updateProjectTitle =
      '/admin/project/{projectId}/update-title'; // update project title
  static const String updateProjectById =
      '/admin/project/{id}'; // update project by id

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

  //--------------------------- User---------------------------
}
