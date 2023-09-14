
class UserModel {
  final String? uid;
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  final String sex;
  final String historydrug;
  final String diseasencds;
  final String congenitalDisease;

  const UserModel({
    this.uid, 
    required this.email, 
    required this.password, 
    required this.firstname, 
    required this.lastname,
    required this.sex, 
    required this.historydrug, 
    required this.diseasencds, 
    required this.congenitalDisease, 
  });

   factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      sex: map['sex'],
      historydrug: map['historydrug'],
      diseasencds: map['diseasencds'],
      congenitalDisease: map['congenitaldisease'], 
      // "email":email,
      // "password":password,
      // "firsname":firsname,
      // "lastname":lastname,
      // "sex":sex,
      // "historydrug":historydrug,
      // "diseasencds":diseasencds,
      // "congenitalDisease":congenitalDisease
    );
  }
  
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      "email":email,
      "password":password,
      "firstname":firstname,
      "lastname":lastname,
      "sex":sex,
      "historydrug":historydrug,
      "diseasencds":diseasencds,
      "congenitaldisease":congenitalDisease
    };
  }

  // static fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> e) {}

}