# body_measurements_app
pre-req : dowload android studio ( ladybug && flutter )

## Configuring and Running the Flutter Application
1. Navigate to the flutter_app directory:
```bash
  cd body_measurements_app
  ```
(activate the conda environment again in a different CMD)

2. Open `lib/main.dart` and locate the `uri.parse` line.
![Screenshot 2024-12-06 111653](https://github.com/user-attachments/assets/2850d30a-7c93-45df-b194-634f715e247d)

3. Replace the placeholder URI with the copied Flask server address from the previous step:(the flask server address 2nd one):
`var uri = Uri.parse("http://<your_flask_server_address>");`

4. Connect Mobile Device
- Connect your mobile device to your PC via USB.
- Enable USB Debugging on the mobile device.
- Run the Flutter Application

5. Ensure the Conda environment is still activated in the VS Code terminal.
- Run the Flutter app using:
```bash
flutter run
```

Follow the on-screen instructions to test the app on your device.
