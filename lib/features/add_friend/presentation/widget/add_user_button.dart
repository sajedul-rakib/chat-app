import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/route_name.dart';
import '../../../chats/data/models/user.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../../../widgets/custom_snackbar.dart';
import '../bloc/add_user_bloc/add_user_bloc.dart';

class AddUserButton extends StatelessWidget {
  const AddUserButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUserBloc, AddUserState>(
      listener: (context, state) {
        if (state is AddFriendSuccess) {
          CustomSnackbar.show(
              context: context, message: 'Add friend successfully');
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomNavBarScreen, (route) => false);
        } else if (state is AddFriendFailure) {
          CustomSnackbar.show(context: context, message: state.errMsg ?? '');
        }
      },
      builder: (context, state) {
        if (state is AddFriendLoading) {
          return CustomCircularProgressIndicator();
        }
        return IconButton(
          icon: const Icon(CupertinoIcons.person_add_solid),
          onPressed: () {
            context.read<AddUserBloc>().add(
                  AddFriendRequestRequired(friend: user),
                );
          },

        );
      },
    );
  }
}
