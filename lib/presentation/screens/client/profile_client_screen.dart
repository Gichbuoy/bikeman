import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bikeman/domain/bloc/blocs.dart';
import 'package:bikeman/presentation/components/components.dart';
import 'package:bikeman/presentation/helpers/helpers.dart';
import 'package:bikeman/presentation/screens/client/client_orders_screen.dart';
import 'package:bikeman/presentation/screens/intro/checking_login_screen.dart';
import 'package:bikeman/presentation/screens/profile/change_password_screen.dart';
import 'package:bikeman/presentation/screens/profile/edit_Prodile_screen.dart';
import 'package:bikeman/presentation/screens/profile/list_addresses_screen.dart';


class ProfileClientScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if( state is LoadingAuthState ){
          modalLoading(context);
        } else if ( state is SuccessAuthState ){
          Navigator.pop(context);
          modalSuccess(context, 'Picture Change Successfully', () => Navigator.pushReplacement(context, routeFrave(page: ProfileClientScreen())));
          Navigator.pop(context);
        } else if ( state is FailureAuthState ){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextCustom(text: state.error, color: Colors.white), backgroundColor: Colors.red));
        }

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: ImagePickerFrave()
              ),
              const SizedBox(height: 20.0),
              Center(
                child: TextCustom(text: authBloc.state.user!.firstName + ' ' + authBloc.state.user!.lastName, fontSize: 25, fontWeight: FontWeight.w500 )
              ),
              const SizedBox(height: 5.0),
              Center(
                child: TextCustom(text: authBloc.state.user!.email, fontSize: 20, color: Colors.grey )
              ),
              const SizedBox(height: 15.0),
              const TextCustom(text: 'Account', color: Colors.grey ),
              const SizedBox(height: 10.0),
              ItemAccount(
                text: 'Profile setting',
                icon: Icons.person,
                colorIcon: 0xff01C58C,
                onPressed: () => Navigator.push(context, routeFrave(page: EditProfileScreen())),
              ),
              ItemAccount(
                text: 'Change Password',
                icon: Icons.lock_rounded,
                colorIcon: 0xff1B83F5,
                onPressed: () => Navigator.push(context, routeFrave(page: ChangePasswordScreen())),
              ),
              ItemAccount(
                text: 'Add addresses',
                icon: Icons.my_location_rounded,
                colorIcon: 0xffFB5019,
                onPressed: () => Navigator.push(context, routeFrave(page: ListAddressesScreen())),
              ),
              ItemAccount(
                text: 'Orders',
                icon: Icons.shopping_bag_outlined,
                colorIcon: 0xffFBAD49,
                onPressed: () => Navigator.push(context, routeFrave(page: ClientOrdersScreen())),
              ),
              ItemAccount(
                text: 'Dark mode',
                icon: Icons.dark_mode_rounded,
                colorIcon: 0xff051E2F,
              ),
              const SizedBox(height: 15.0),
              const TextCustom(text: 'Personal', color: Colors.grey ),
              const SizedBox(height: 10.0),
              ItemAccount(
                text: 'Privacy & Policy',
                icon: Icons.policy_rounded,
                colorIcon: 0xff6dbd63,
              ),
              ItemAccount(
                text: 'Security',
                icon: Icons.lock_outline_rounded,
                colorIcon: 0xff1F252C,
              ),
              ItemAccount(
                text: 'Term & Conditions',
                icon: Icons.description_outlined,
                colorIcon: 0xff458bff,
              ),
              ItemAccount(
                text: 'Help',
                icon: Icons.help_outline,
                colorIcon: 0xff4772e6,
              ),
              const Divider(),
              ItemAccount(
                text: 'Sign Out',
                icon: Icons.power_settings_new_sharp,
                colorIcon: 0xffF02849,
                onPressed: () {
                  authBloc.add(LogOutEvent());
                  Navigator.pushAndRemoveUntil(context, routeFrave(page: CheckingLoginScreen()), (route) => false);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationFrave(3),
      ),
    );
  }
}

