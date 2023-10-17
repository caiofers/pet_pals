import 'package:flutter/material.dart';

class TutorPic extends StatelessWidget {
  const TutorPic({
    super.key,
    required this.tutorId,
    required this.tutorName,
    required this.tutorAvatarUrl,
    required this.onTap,
  });

  final String tutorId;
  final String tutorName;
  final String? tutorAvatarUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height: 80,
        width: 80,
        child: Center(
          child: Stack(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  tutorAvatarUrl ?? '',
                  errorBuilder: (context, error, stackTrace) {
                    return const CircleAvatar(
                      child: Icon(Icons.person),
                    );
                  },
                ),
              ),
              Container(
                height: 70,
                width: 70,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  height: 20,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.amber.shade200,
                  ),
                  child: Text(
                    tutorName.split(' ').first,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
