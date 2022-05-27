import 'package:flutter/material.dart';
import 'package:whoshere/model/Post.dart';

class Posts extends StatelessWidget {
  final Post post;

  const Posts({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Stack(
        children: [
          SizedBox(
            height: 250.0,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100.0),
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              child: Image.asset(
                post.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Container(
              height: 250.0,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1.0, vertical: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                post.time,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 150.0,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.text,
                          style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        Text(
                          post.place,
                          style: const TextStyle(
                              fontSize: 8.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
