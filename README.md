# Kammerer-Weather
A fun little weather fetching app.

The weather obtained here is from the free version of Open Weather - https://openweathermap.org/ and requires an API key from them. 

The app will not build immediately upon download of this code.  To build, a `Secrets.plist` file needs to be created with a key-value entry added named `OpenWeatherApiKey` and the value you obtain from Open Weather.

Alternatively, in `GetWeatherService`, you can add your key value to `var key =` and remove the references to `loadAPIKey` and all the checks for `if key.isEmpty`. You will alos need to remove references of `Secrets.plist` from the project file.

