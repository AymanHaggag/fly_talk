import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:
                  Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                Image(
                  image: NetworkImage(
                    "https://img.freepik.com/free-photo/indoor-photo-satisfied-teenage-girl-texts-cellular-reads-interesting-article-online-wears-casual-outfit-creats-new-publication-own-web-page-isolated-brown-wall-with-free-space_273609-26359.jpg?w=1060&t=st=1693541879~exp=1693542479~hmac=ba02e3e0dec115a2a1b073f41c9ca55892cfcacc87ea59a17b44a0cb05c69d52",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Communicate with your friends Now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]),
            ),
            ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context ,index) => postCard(context),
                separatorBuilder: (context ,index) => SizedBox(height: 10,),
                itemCount: 10),
           
          ],
        ),
      ),
    ));
  }
}





Widget? postCard (context){
   return Container(
     decoration: BoxDecoration(
       boxShadow: [
         // BoxShadow(
         //   color: Colors.grey, // Shadow color
         //   blurRadius: 5.0,   // Spread radius
         //   offset: Offset(0, 3), // Offset in the x and y direction
         // ),
         // BoxShadow(
         //   color: Colors.black.withOpacity(0.6),
         //   offset: Offset(
         //     0.0,
         //     10.0,
         //   ),
         //   blurRadius: 10.0,
         //   spreadRadius: -6.0,
         // ),
       ],
     ),
     child: Card(
       // clipBehavior: Clip.antiAliasWithSaveLayer,
       // elevation: 5.0,
       // margin: EdgeInsets.all(
       //   8.0,
       // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/satisfied-lovely-woman-holds-modern-cell-phone_273609-28232.jpg?w=1060&t=st=1693541874~exp=1693542474~hmac=fc1bffa9b0dc2e5b3ab579f70318aaa26536af1ee033b84f7c6ec17ef69bf4fd"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Isabella Thompson",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 15,
                            )
                          ],
                        ),
                        Text(
                          "1 September, 2023 at 12:30 am",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.7)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                      "\"Embrace the journey of today with the hope of a better tomorrow, for every step you take is a stride toward your dreams.\"")),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://img.freepik.com/free-photo/silhouette-people-happy-time_1150-5360.jpg?w=1060&t=st=1693546098~exp=1693546698~hmac=9b9169484475fbc665d2a54409f2034288b93533b4db3a0ae8cb0b4aaafa1093",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Row(children: [
                      FaIcon(FontAwesomeIcons.heart,color: Colors.red,size: 20,),
                      SizedBox(width: 5,),
                      Text(" 3K ")
                    ],),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FaIcon(FontAwesomeIcons.comment,color: Colors.amber,size: 20),
                        SizedBox(width: 5,),
                        Text("150 comment"),
                      ],),
                  ),
                ],),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-photo/satisfied-lovely-woman-holds-modern-cell-phone_273609-28232.jpg?w=1060&t=st=1693541874~exp=1693542474~hmac=fc1bffa9b0dc2e5b3ab579f70318aaa26536af1ee033b84f7c6ec17ef69bf4fd"),
                ),
                SizedBox(width: 8,),
                Text("Write a comment...")
              ],),
            ],
          ),
        ),
      ),
  ),
   ) ;
}
