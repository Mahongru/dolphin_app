# new_app

An new Flutter app; ready for testing widgets.

[] Show photos of dolphins
[] Create Unsplash developer account. Generate Client ID
    - get request url 'https://api.unsplash.com/photos/random?query=dolphin&client_id=<client ID>'
[] Implement a widget that displays a new photo every 2 seconds
[] Include two buttons called 'Pause' and 'Play'
    - Pause sets get request timer to 0 seconds (stop slideshow)
    - Play sets get request timer to default (resume slideshow)
    - Rewind button shows old photos every 2 seconds.
        - Keep 5 photos in memory.
        - When loop ends, pause, show message 'Cannot remember any more dolphins'
    - Implement tests to verify the functionality of the Dolphin photo feature.
[] Addition suggestions:
    - use BLoC pattern to manage state in app.
    - avoid unnecessary Widget rendering.