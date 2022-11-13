## Dolphin App

An App that displays images of dolphins. Works on Web. 

### Features
- [x] Display a new photo of a Dolphin every 2 seconds
- [x] Button that plays/pauses loading of photos every 2 seconds 
- [x] Button that rewinds up to 5 old photos then shows ```Cannot remember any more dolphins ```
- [x] UI modifications
- [ ] Testing

### Installation
After cloning this repository, migrate to ```dolphin_app``` folder. Then, follow the following steps:
- Setup enviroment variables
    - Create .env (see .env.example)
    - Populate Unsplash api credentials
    - Note: Terminated and restart the application to update .env
- Run your app:
```bash
  flutter pub get
  flutter run
```
