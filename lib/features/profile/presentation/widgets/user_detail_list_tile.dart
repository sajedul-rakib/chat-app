import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:chat_app/theme/color_scheme.dart';
import "package:flutter/material.dart";

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../bloc/profile_bloc.dart';

class UserDetailListTile extends StatelessWidget {
  const UserDetailListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is GetUserDataFailure) {
          CustomSnackbar.show(
              context: context,
              message: state.errMsg!,
              backgroundColor: ColorSchemed.darkColorScheme.error);
        }
      },
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
                    ? NetworkImage(
                        '${dotenv.env['BASE_URL']}${state.user.profilePic!}')
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
          return ListTile(
            leading: CircleAvatar(
              child: Icon(FontAwesomeIcons.person),
            ),
            title: Text(
              'Unknown',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            subtitle: Text(
              'Unknown',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
