class Chat_Model {
  String name = 'junaid';
  String userid = 'jun1234';
  String userimage='';

  Chat_Model({required this.name, required this.userid,required this.userimage});

  // Extract a Reward object from a Map object
  Chat_Model.fromMapObject(Map<String, dynamic> map) {
    this.name = map['name'];
    this.userid= map['userid'];
    this.userimage=map['image'];

  }

}