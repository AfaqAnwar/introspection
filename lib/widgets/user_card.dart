import 'package:age_calculator/age_calculator.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final CustomUser user;
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String parsedDOB =
        '${user.getDob.split('-')[2]}-${user.getDob.split('-')[0]}-${user.getDob.split('-')[1]}';
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                //image:DecorationImage(fit: BoxFit.cover, image: NetworkImage()),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(100, 18, 32, 60),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(3, 3),
                  )
                ]),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.getFirstName},',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                        AgeCalculator.age(DateTime.parse(parsedDOB))
                            .years
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.white)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      user.jobTitle,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
