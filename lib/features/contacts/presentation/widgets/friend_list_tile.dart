import 'package:flutter/material.dart';

class FriendListTile extends StatelessWidget {
  const FriendListTile(
      {super.key, this.onPressed, required this.fullName, this.imageUrl});

  final Function()? onPressed;
  final String fullName;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(imageUrl!))
              : Image.asset('assets/images/user.png'),
          Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2),
                shape: BoxShape.circle,
                color: const Color(0xff2CC069)),
          )
        ],
      ),
      title: Text(fullName),
      subtitle: const Text("Last seen yestarday"),
    );
  }
}
