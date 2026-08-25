#  Introduction

========================================
### singletons

- Singleton (S)
una instancia y un solo punto de acceso
El mismo maneja la instancia
No pueden existir otras instancias

- singleton (s)
URSsession.shared
URSsession()
Puede tener convenience init para crear instancias

- Globlal State
En vez de let, es var, lo cual puede variar mucho

- Dependency Inversion
En vez de inyectar una depedencia, incluiso de terceros, directamente...
Lo que haces es usar protocolos, asi ocultas la implementacion y solo ves el protocolo
Incluso, si el framework cambia, el protocolo no, y es mejor para tests

========================================
### Depedency diagrams

- Herencia
Solid line, empty head = "inherits from" / "is a".
    class MyViewController: UIViewController {}


- implementa 
Dashed line, empty head = "conforms to" or "implements"
    protocol HTTPClient {}
    . . .
    class URLSessionHTTPClient: HTTPClient {}

- depende fuerte
Solid line, filled head = "depends on" / "has a" (strong dependency)
When a type instance depends on another type instance to exist

    class RemoteFeedLoader {
      private let client: HTTPClient

      init(client: HTTPClient) {
        self.client = client
      }
    }

You cannot instantiate a RemoteFeedLoader without an HTTPClient instance

- depende debil
Dashed line, filled head = "depends on" (weak dependency)

    class RemoteFeedLoader {
      func load(with client: HTTPClient) {
        client.doSomething()
      }
    }

You can create a RemoteFeedLoader without an HTTPClient.

========================================
### Modular design

Recuerda
1. es mejor correr tests de api y database sin simulador
- por lo tanto, por eso lo dejaron con target mac 

2. Depedency inversion
- para no tener todo conectado, strong coupling
- envias closures en vez de clases

3. protocolos
- son el limite entre ui y procesos

========================================
### BDD & TDD

Bad sowftare
- bad commnucation / suposiciones
Good sotfware
- resolver, acoplarse a lo que venga, suave
- procesos y comunicacion

User stories
- como usuario quiero ver un feed de items
- pero
    - errores, que quieres ver, cual es el proposito
    - load de donde? 

BDD (Behavior-Driven Development)
=> dar informacion revelante por comunicacion
    - definir proceso, accpetance criteria
    - conexiones, cache, offline, errores

Developer
    - tiene los conoci,ientos para hacer las preguntas correctas
    - agregar valor a las ideas => mostrar algo offline o online, tener cache
    - buen diseno, buenons requerimientos
    
= = =
TDD - Test Driven Development 
The process of writing tests before writing the actual production code is known as Test-Driven Development (TDD)

========================================
### Develop apps without backend

Muy buena idea, tener el JSON representado para poder modelar y hacer primeras pruebas 

- Creamos FeedItem
- protocol FeedLoader
- enum LoadFeedResult - success y error
    - Mucho ojo en los nombres

* OJO
    * Dejar el tipo nativo de iOS Error puede ser ambiguo 
    * Tenemos que manejar casos 
    * Puede o no ser definidido desde el principio 

Podemos separar procesos:
FeedLodaer
Remote
Local
Fallback
Factory

Y aparte
ViewContrllers = UI

INTERESANTE
Creo una app macOS - cocoaFramework para iniciar proyecto 
