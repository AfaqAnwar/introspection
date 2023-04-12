import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imgUrls;
  final String bio;
  final String jobTitle;

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.imgUrls,
      required this.bio,
      required this.jobTitle});

  @override
  List<Object?> get props => [id, name, age, imgUrls, bio, jobTitle];

  static List<User> users = [
    User(
        id: 1,
        name: 'Sanzi',
        age: 21,
        imgUrls: [
          "https://blogs.nyit.edu/uploads/career_corner/images/Sanzida_Sultana.jpeg",
          "https://media.licdn.com/dms/image/C4D03AQGj83aveC9otw/profile-displayphoto-shrink_800_800/0/1635120693230?e=2147483647&v=beta&t=Xngetvf8zy6wN6HrUkZbSrbumalHw1bTS99dCHnAT0A",
          "https://cms-assets.tutsplus.com/cdn-cgi/image/width=360/uploads/users/1381/posts/35536/final_image/pastel%20color%20codes%20tutorial%20main%20preview.jpg",
          "https://ih1.redbubble.net/image.559859556.8607/st,small,507x507-pad,600x600,f8f8f8.u2.jpg"
        ],
        bio: 'I like turtles',
        jobTitle: 'subway sufer'),
    User(
        id: 2,
        name: 'Val',
        age: 740,
        imgUrls: [
          "https://media.licdn.com/dms/image/C4E03AQE2VbMHIDyVNA/profile-displayphoto-shrink_800_800/0/1626832875953?e=2147483647&v=beta&t=J4QGZCT1ZUUFiAv5Nw0UhHCPB-c5pIvfda3ApTbkiy0"
        ],
        bio: 'I like hippos',
        jobTitle: 'doodle jumper'),
    User(
        id: 3,
        name: 'Preston',
        age: 1000000,
        imgUrls: [
          "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/7/11/0/YW0305H_chicken-tortilla-casserole-recipe_s4x3.jpg.rend.hgtvcom.616.462.suffix/1387299385758.jpeg"
        ],
        bio: 'I like cats',
        jobTitle: '2049 enjoyer')
  ];
}
