class CreateNewTeamModel {
  final String title;
  final String description;
  final String department;
  final String image;
  final List members;

  CreateNewTeamModel({
    required this.title,
    required this.description,
    required this.department,
    required this.image,
    required this.members,
  });

  factory CreateNewTeamModel.fromJson(Map<String, dynamic> jsonData){
    return CreateNewTeamModel(
      title: jsonData["title"] ?? "", 
      description: jsonData["description"] ?? "", 
      department: jsonData["department"] ?? "", 
      image: jsonData["image"] ?? "", 
      members:List.from(jsonData["members"] ?? "") ,
      );
  }

  Map<String,dynamic> toJson(){
    return {
      "title": title ,
      "description": description ,
      "department": department ,
      "image": image ,
      "members": members ,
    };
  }
}
