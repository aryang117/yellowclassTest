import 'package:flutter/material.dart';

// This File contains widgets that are being used throughout the app
// and are very similar to each other, therefore they are being standardized

// TextFormField being used throughout the app
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.textEditingController,
      required this.label,
      this.getPosterLink})
      : super(key: key);

  final TextEditingController textEditingController;
  final String label;
  final Function? getPosterLink;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //onEditingComplete: () => ,
      controller: textEditingController,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}

// Poster Previews shown to the user when they enter the movie names in the addtoDB and UpdateDB Form
Widget posterPreview(String _posterURL) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Container(
      height: 250,
      width: 175,
      child: Card(
        child: FadeInImage(
            image: NetworkImage(_posterURL),
            fit: BoxFit.fill,
            placeholder: NetworkImage(
                'https://pbs.twimg.com/media/E7VuaNRXEAEloYi.jpg')),
        elevation: 5,
      ),
    ),
  );
}

// vertical Padding between elements
Padding vertPaddingbetweenElements() {
  return Padding(padding: const EdgeInsets.only(top: 20.0));
}