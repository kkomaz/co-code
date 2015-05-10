# Euler Interactive

## Description

Co-code is a platform for programmers to work on technical practice problems in a collaborative way - users get the support they need while working on a problem and then gain a deeper understanding of the concept through teaching it to others.

The app allows users to select a track based on their preferred language and begin working collaboratively in chatrooms and forums to solve coding challenges together. Problems are based on the Project Euler question and users can host lessons to lead discussions or be invited to join live discussions.

The core application is built on rails. To support live chatrooms and reflect our user's 'online' status we are using a Faye Rack application  to administer the websocket connections along with a Redis server for handling pub/sub. After logging into the application through email or Facebook, each interaction is customized to the specific user and their progress through each programming challenge.

## License

Euler Interactive is MIT Licensed. See LICENSE for details.
