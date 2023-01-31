import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/core/validators/profile_validator.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';
import 'package:wtech_dashboard/core/widgets/r_text_field.dart';

class SettingsPageDesktop extends StatelessWidget {
  const SettingsPageDesktop({super.key});
  static final ValueNotifier<int> _selectedTile = ValueNotifier(0);
  static final List<String> _tileTitles = ['General', 'Admin Account'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Profile Settings',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 12),
            MainContainer(
              height: MediaQuery.of(context).size.height * 0.8,
              addPadding: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: SettingsTile(
                      selectedTile: _selectedTile,
                      tileTitles: _tileTitles,
                    ),
                  ),
                  Container(
                    width: 0.2,
                    height: double.infinity,
                    color: AppColor.captionColor,
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Wrap(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ReactiveForm(
                            formGroup: profile,
                            child: const Expanded(
                              flex: 2,
                              child: LeftFormSide(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeftFormSide extends StatelessWidget {
  const LeftFormSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: ProfileTextField(title: 'First Name'),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ProfileTextField(title: 'Last Name'),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: ProfileTextField(title: 'Email'),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ProfileTextField(title: 'Phone Number'),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: ProfileTextField(title: 'Address'),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(
                child: ProfileTextField(title: 'Birthday'),
              ),
              const SizedBox(width: 35),
              Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU'),
                      radius: 90,
                    ),
                  ),
                  ButtonWithIcon(
                    text: 'Upload',
                    iconData: Icons.cloud_upload_outlined,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          child: ButtonPrimary(
            text: 'Save Changes',
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 14),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          child: const Divider(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: AppColor.captionColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    'You can reset or change your\npassword by clicking here',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  trailing: ButtonWithIcon(
                    text: 'Change',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColor.captionColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    'Remove Account',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    'Once you delete your account,\n there is no go back. please be certain',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  trailing: ButtonWithIcon(
                    text: 'Change',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.bodyText1),
        RTextFormField(
          controllerName: title,
          label: title,
          validationMessages: profileValidator(),
        ),
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    required ValueNotifier<int> selectedTile,
    required List<String> tileTitles,
  })  : _selectedTile = selectedTile,
        _tileTitles = tileTitles,
        super(key: key);

  final ValueNotifier<int> _selectedTile;
  final List<String> _tileTitles;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedTile,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: _tileTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: value == index
                    ? AppColor.primaryColor.withOpacity(0.2)
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                onTap: () {
                  _selectedTile.value = index;
                },
                dense: true,
                hoverColor: value == index
                    ? AppColor.primaryColor.withOpacity(0.2)
                    : AppColor.bgColor,
                selectedTileColor: AppColor.primaryColor.withOpacity(0.5),
                selected: value == index,
                title: Text(
                  _tileTitles[index],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: value == index
                            ? AppColor.primaryColor
                            : AppColor.black,
                      ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
