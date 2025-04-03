import "package:flutter/material.dart";

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../bloc/profile_bloc.dart';

class UserDetailListTile extends StatelessWidget {
  const UserDetailListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is GetUserDataProcess) {
          return Center(
            child: CustomCircularProgressIndicator(),
          );
        } else if (state is GetUserDataSuccess) {
          return ListTile(
            leading: CircleAvatar(
                backgroundImage: state.user.profilePic != null &&
                        state.user.profilePic!.isNotEmpty
                    ? NetworkImage(state.user.profilePic!)
                    : state.user.gender == 'female'
                        ? AssetImage('assets/images/female.jpg')
                        : AssetImage('assets/images/man.jpg')),
            title: Text(
              state.user.fullName ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            subtitle: Text(
              state.user.email ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          );
        } else if (state is GetUserDataFailure) {
          return Center(
            child: Text(state.errMsg.toString()),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
