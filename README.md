# Library Application
Full stack web application. With a frontend built with Flutter & Microservices based Backend built with Go.

## Introduction
I built this application while I was learning Backend & the Go programming language, used a lot of tools and technologies for the first time here such as Docker, Swagger documentation, GRPC with Protocol buffers, JWT or PASETO, Web Socket, ORM's (GORM), NGINX and more..!

## How It works

![UML Diagram](Workspace.png)


## Hosting
- ### The Flutter Application
    The Flutter Application is hosted with Firebase Hosting. You can check it [here](https://library-app-aefc9.web.app).
- ### The Backend
    The Backend is working on my Raspberry Pi, and I am using CloudFlare Tunnels to redirect the requsets coming to the domain to the Raspberry Pi.

## Frontend
I built the frontend as a single-page application using **Flutter** with **GetX** state management.
Check the Flutter app's [README file](https://github.com/MousaZa/library-app-go/blob/main/library_ui/README.md) for additional information.


## Backend Services

- ### Authentication:
    REST Api built with Go.
    Used **PASETO** (Platform-Agnostic Security Tokens) as the authentication method. 
    Used **bcrypt** for password hashing.
    Stores the users data in a **PostgreSQL** database.
    Check [the Documentation](https://github.com/MousaZa/library-app-go/blob/main/auth/doc.md) for additional information.
- ### Books:
    REST Api built with Go. 
    Used WebSocket to stream the books data.
    Used **Gemini API** to provide additional info about the books, authors or provide book suggesions.
    Stores the books data in a **PostgreSQL** database.
    Check [the Documentation](https://github.com/MousaZa/library-app-go/blob/main/books/doc.md) for additional information.
- ### Borrows:
    GRPC service built with Go using **Protocol Buffers**.
    Stores the borrows data in a **PostgreSQL** database.
    Check [the Documentation](https://github.com/MousaZa/library-app-go/blob/main/borrows/doc.md) for additional information.
- ### Likes:
    GRPC service built with Go using **Protocol Buffers**.
    Stores the likes data in a **PostgreSQL** database.
    Check [the Documentation](https://github.com/MousaZa/library-app-go/blob/main/likes/doc.md) for additional information.
- ### Notifications:
    GRPC service built with Go using **Protocol Buffers**.
    Stores the notifications data in a **PostgreSQL** database.
    Check [the Documentation](https://github.com/MousaZa/library-app-go/blob/main/notifications/doc.md) for additional information.
- ### Images:
    REST Api built with Go. 
    Stores the images in a **Docker volume** (local disk).
    Check [the Documentation](https://github.com/MousaZa/library-app-go/blob/main/images/doc.md) for additional information.

- ### Proxy:
    Used **NGINX** as the proxy here.
    Check [the config file](https://github.com/MousaZa/library-app-go/blob/main/proxy/default.conf) for additional information.

## License

This project is released under the MIT License. See the **[LICENSE](https://www.github.com/MousaZa/library-app-go/blob/main/LICENSE)** file for details.

## Contact

If you have any questions or comments about the project, please contact me mous.zeydan@gmail.com.

## Conclusion
And at the end, thank you for your interest. Hope this can help the newly-starting guys.   