import '../../Utilities/Import&Export/export.dart';

class NotificationInSettings extends StatefulWidget {
  const NotificationInSettings({Key? key}) : super(key: key);

  @override
  State<NotificationInSettings> createState() => _NotificationInSettingsState();
}

class _NotificationInSettingsState extends State<NotificationInSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bildirim Ayarları"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.ad_units),
            title: const Text("Anlık Bildirimler"),
            subtitle: const Text(
                "Anlık olarak mobil cihazınıza push notification alın."),
            trailing: Switch(
              activeColor: Colors.blue,
              value: true,
              onChanged: (bool newValue) {
                Fluttertoast.showToast(
                  msg: comingSoon,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sms_outlined),
            title: const Text("SMS Bildirimleri"),
            subtitle: const Text("Mobil cihazınıza SMS bildirimleri alın."),
            trailing: Switch(
              activeColor: Colors.blue,
              value: true,
              onChanged: (bool newValue) {
                Fluttertoast.showToast(
                  msg: comingSoon,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text("E-posta bildirimleri"),
            subtitle: const Text("Bildirimlerinizi E-posta olarak alın."),
            trailing: Switch(
              activeColor: Colors.blue,
              value: true,
              onChanged: (bool newValue) {
                Fluttertoast.showToast(
                  msg: comingSoon,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
