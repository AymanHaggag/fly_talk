class UserModel {
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? uId;
  String? image = "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745";
  String? cover = "https://img.freepik.com/free-vector/watercolor-leaves-falling-background_52683-74651.jpg?w=1060&t=st=1693658651~exp=1693659251~hmac=307e69fec136e24af9752c9282dda86748a073640b3b323c8220378db3ed1fda";
  String? numberOfPosts = "200";
  String? numberOfPhotos = "350";
  String? numberOfFollowing ="15K";
  String? numberOfFollowers = "35K";
  bool? isVerified = false;

  UserModel ({
    this.name,
  this.email,
  this.phone,
  this.uId,
  this.isVerified,
  this.bio,
  this.image,
  this.cover,
  this.numberOfPosts,
  this.numberOfPhotos,
  this.numberOfFollowing,
  this.numberOfFollowers,
  });



  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isVerified = json['isVerified'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    numberOfPosts = json['numberOfPosts'];
    numberOfPhotos = json['numberOfPhotos'];
    numberOfFollowers = json['numberOfFollowers'];
    numberOfFollowing = json['numberOfFollowing'];
  }

  Map<String, dynamic> toMap(){
    return {
      "name" : name,
      "email" : email,
      "phone" : phone,
      "uId" : uId,
      "isVerified" : isVerified,
      "bio" : bio,
      "image" : image,
      "cover" : cover,
      "numberOfPosts" : numberOfPosts,
      "numberOfPhotos" : numberOfPhotos,
      "numberOfFollowers" : numberOfFollowers,
      "numberOfFollowing" : numberOfFollowing,
    };
  }


}