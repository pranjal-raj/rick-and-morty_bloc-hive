import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CharacterCard extends StatefulWidget {
  final String name;
  final String species;
  final String image;
  bool liked = false;
  CharacterCard(
      {super.key,
      required this.name,
      required this.species,
      required this.image,
      this.liked = false});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 300,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: const Border(),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 5),
                    blurRadius: 5)
              ]),
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: SizedBox(
                    child: ClipRRect(
                  borderRadius: const BorderRadiusDirectional.vertical(
                      top: Radius.circular(20)),
                  child: Image.network(widget.image, fit: BoxFit.fitWidth),
                )),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                  color: Color.fromARGB(150, 39, 2, 139),
                                  fontSize: 30,
                                  fontFamily: 'Mouldy',
                                ),
                              ),
                            ),
                            Text(widget.species,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 97, 97, 97),
                                  fontSize: 20,
                                  fontFamily: 'Mouldy',
                                )),
                          ],
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            widget.liked = !widget.liked;
                          });
                        },
                        icon: toggleLiked(),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Icon toggleLiked() {
    if (widget.liked) {
      return const Icon(
        Icons.favorite_rounded,
        color: Colors.redAccent,
      );
    } else {
      return const Icon(
        Icons.favorite_outline,
        color: Colors.grey,
      );
    }
  }
}
