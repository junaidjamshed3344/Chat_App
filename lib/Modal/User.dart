class User_Model {
  String name = 'junaid';
  String email='junaid@gmail.com';
  String userid = 'jun1234';
  String imageurl='http';

  User_Model({required this.name,required this.email, required this.userid,required this.imageurl});

  // Extract a User object from a Map object
  User_Model.fromMapObject(Map<String, dynamic> map) {
    this.name = map['name'];
    this.email = map['email'];
    this.userid= map['userid'];
    this.imageurl=map['image'];
  }

}