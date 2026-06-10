#  Advanced module

### Image Comments API

1. Copiamos codigo que ya tenemos para Feed feature ahora para ImageComments feature
2. Ojo con las carpetas, ayudan mucho a separar
3. Vemos generics, para hacer un solo generic loader, es casi el mismo codigo
- Inyctamos el generic en la clase
- dejamos test especificos para feed y images loader
- en el generic, dejamos los casos genericos

4. Separamos tests, por un lado el loader generic y por otro los mappers unicmanete
- en los mpaeers, no checamos infraestructure, solo que el mapper funcione ok

    extension RemoteLoader: FeedLoader where Resource == [FeedImage]
- este tipo de extension usando where, pfffff

---
The RemoteFeedLoader and RemoteImageCommentsLoader implementations are identical apart from the mapping logic.

==============================
### Presnetation

Carga y error es lo mismo, se crea un module que comparte estp
FeedPresneter => debe ser generic para feed, images, comments

- typealias
    public typealias Mapper = (Resource) throws -> View.ResourceViewModel
Recuerda usarlos para simplificar nombres

- file, line
Para saber exactamente donde truena el codigo

- inyectar locale, calendar
Para contrlar el ambiente

==============================
### Reusable
OJO
cuando dejas un metodo vacio, violas IntegrationSegreationProtocol
Estas obligando que una clase implementa algo que no necesitas

==============================
### Navigation

Recuerda
No queremos nodos conectados para navigation
todo en un solo punto
COMPOSITION root

So when showing a view with complex dependencies, doing it directly via segues or code in the parent view is not the best approach

- Instead, the composition should be done in the Composition Root
- With a Composer in place, you can then move the navigation between the Feed and Comments to the Composition Root leaving the two features agnostic of each other.

* Composition
Desde aqui crea toda la estructura de composer, ui, etc y lanza el image comments

==============================
### pagination
Interesante
after/before key - mandamos parametro para que no se repita el elemento en caso que agregue mas
itemX
itemA
itemB

after_key{itemB.key}
itmeC
itemD

We can avoid the nested operations by using zip:

makeRemoteFeedLoader(after: last)
  .zip(localFeedLoader.loadPublisher())
  .map { (newItems, cachedItems) in
      (cachedItems + newItems, newItems.last)
  }
  
For example, you can use zip to combine a publisher that produces A with a publisher that produces B. The result will be a new publisher that produces a tuple (A, B).

==============================
### logging

Apple recommends you use the unified logging system via the os_log functions (iOS 10+) or the Logger struct (iOS 14+) from the os framework.

### assertionFailure vs print
• In debug builds, calling assertionFailure("message") will stop the program’s execution (it raises a breakpoint), making it easy for you to find and fix logic errors during development.
• print Does not stop the program or trigger a breakpoint

### Logging as a cross-cutting concern
The Decorator pattern is one effective way of adding the logging behavior through polymorphism.
Con un decorator, podemos poner un log desde un nivel mas alto sin poner logs en todos lados 

When using Combine or similar frameworks, it can be even simpler. You can add the logging behavior directly into the publisher chain with the HandleEvents publisher.
Si usas combine, puedes usar el handelEvents para log

Conclusion:
Either way, we recommend you inject this behavior in the Main application module instead of polluting all your components with logging responsibility. This way, the modules will remain decoupled from the logging responsibility and libraries. You can then easily replace those libraries with other implementations when needed.

### optimizations
Guardar bateria y uso de datos 
- imagenes en una app donde no hace falta cargar todo de nuevo
    - se guardan imagenes en cache
    

### nullobject
“A null object is an object with no referenced value or with defined neutral ("null") behavior.”—Wikipedia

==============================
### async injection

That's why it’s desired to run such infrastructure operations asynchronously - without blocking clients.
making all APIs synchronous, and dealing with async and threading details in the Composition Root.

- ir quitando callbacks de las llamdas, hacerlos sincrono
- este es async, tiene completion
    func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void)
- quitamos completion y lo hacemos sinc
    func insert(_ data: Data, for url: URL) throws

- dispatchgroup
para lanzar tareas asincronas, uso DEMO para refafctor code

- generics
    func performSync<R>(_ action: (NSManagedObjectContext) -> Result<R, Error>) throws -> R {
        let context = self.context
        var result: Result<R, Error>!
para devolver el tipo que se necesita

* In this example, cache operations that query a database will run in a background queue, but clients will receive values in the main queue.

- Recomienda
    * infra abstraccion sync
    * async en composition root
    
    
