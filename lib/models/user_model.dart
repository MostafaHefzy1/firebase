class UserModel {
  String? name;
  String? phone;
  String? email;
  String? docId;
  String? tokeNotfication;

  UserModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.docId , 
      required this.tokeNotfication
      });

  UserModel.fromJson(Map<String, dynamic> map) {
    name = map["name"];
    phone = map["phone"];
    email = map["email"];
    docId = map["docId"];
    tokeNotfication = map["tokeNotfication"];
  }


  Map<String, dynamic> toJson(){
    return {
      "name":name , 
      "phone":phone , 
      "email":email , 
      "docId":docId , 
      "tokeNotfication":tokeNotfication , 
    }; 
  }
}
