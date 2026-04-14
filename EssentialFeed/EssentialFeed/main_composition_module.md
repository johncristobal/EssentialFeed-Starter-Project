#  Main composition module

==================================================
### composition modules

* Storage binary data en core data
- allows external storage - guarda data en disk (external file)
    - core data lo decide por ti

### Powerful
Creamos nueva app ios
Arrastramos EssentialFeed.xcodeproj a app
Preguntara su queremos mover -> save
Creamos workspace (espacio de trabajo) con el nombre de la app
    - creamos para cobinar proyectos
Listo, reiniciamos xcode con el worksapce, ya tiene todo

Ahora
- En la app, agregamos feed y feedios frameworks
ya podemos utilizar lo que tenemos aqui en la app

KEEP
- no se porque, pero la version del db se regresaba cada que cierro la app
ojo con eso

==================================================
### composite pattern
Compose object to share common interface
try remote and if fails try local
FeedLoader - comparten ambos

OJO para las imagenes
primero checamos en local antes de cargar remotos

### iniciamos con test.. TDD
- naming muy iporatnte para diferenciar
pasamos de devliersRemote - deliveresPrimary

### cada bez mas entendible TDD

### stub now instes spy
tests flexibles, para pasos contables

EssentialApp/EssentialAppTests/Helpers/XCTestCase+MemoryLeakTracking.swift

==================================================
### Interception

- Creamos new composite to intercept the load and inject the save
- intercepting feedloaders

### Decorating
- add compartamiento a un tipo sin aleterar el tipo

- create composables solutions throught abstractions
- add new behaviour sin cambiar - decorators
- compose types that conform common interface - composites

The pattern’s intent is to “attach additional responsibilities to an object dynamically.

### Interception
RemoteFeedLoader.load method is a Query. - save method en otra parte
save side-effect without altering existing components
Decorator to intercept operations easily and alter/extend/inject new behavior into your system.

==================================================
### high level ui test / launch args
    
Pruebas a alto nivel, donde se se ve la UI
Probando la app directamente
OJO estos son tardados, solo se prueba lo escencial
No suelen ser muchos, puede tardar hasta horas    

### interesante forma de checar UI
    let app = XCUIApplication()
    app.launchArguments = ["-reset", "-connectivity", "online"]
    app.launch()
    
    let feedCells = app.cells.matching(identifier: "feed-image-cell")
    XCTAssertEqual(feedCells.count, 2)
    
    let firstImage = app.images.matching(identifier: "feed-image-view").firstMatch
    XCTAssertTrue(firstImage.exists)

- creas XCUIApplication
- launch
- buscas celdas, checas data...

- ojo launchArguments para definir si hay conectividad o no
- reset para limpiar y hacer el test desde cero
    - para esto hay que leer la bandera de reset y eliminar data

### if debug
if DEBUG
    configuration.delegateClass = DebuggingSceneDelegate.self
endif
Para no poner codigo en prod    
podemos crear archivos con todo el if debug    

The DEBUG flag is automatically set for the Debug build configuration. But you can also create your own custom build flags.

### ojo con netwokr
no podemos depender del servidor o de la cantidad de data
hacemos localserver, tests demos (imagenes demo creadsa al tiempo)

### muuuy lentos
acceptance criteria high level
dos celdas, una imagen, casos muy especificos

==================================================
### fast integration tests

the idea is to create a “Main module” responsible for instantiating and composing all independent modules in a centralized place, aka the “Composition Root.”

In iOS apps, the application entry point historically has been the UIApplicationDelegate.didFinishLaunchingWithOptions.

More recently, in single-window apps using the new UIScene APIs, the UISceneDelegate.willConnectToSession can be considered the app entry point.

### @testable

On the other hand, no other module should reference the SceneDelegate. So, it doesn’t have to be public. To enforce other modules to not have access to the Composition Root, you can make its components internal and, when necessary, use @testable import to test them.

### Convenience initializers
You can define a convenience initializer by placing the convenience modifier before the init keyword, separated by a space:

convenience init(parameters) {
    statements
}

### lazy properties in Swift
whose initial value is not calculated until the first time they are used


==================================================
### validation UI with snapshots Tests

Hacer checks with snapshots - validar que las vistas sean las mismas

### create snapshots
let renderer = UIGraphicsImageRenderer(bounds: bounds
- para crear snapshot

### snapspt con data
Creamos data fake y mandamos llamar feecviewcontoller 
    let cells: [FeedImageCellController] = stubs.map { stub in
        let cellController = FeedImageCellController(delegate: stub)
        stub.controller = cellController
        return cellController
    }
    
    display(cells)

### INTRESANTE
primero hace los records, y despues validamos que los records empatan con los nuevos 

recors hastaque esten feliz con el resutlado  - add a git
assert para checar - aqui se ve si sale algo mal
- no hagas test de logica, solo de render

### shortcoming
- reliability: ojo con el tipo de dispositivo que usas para test
- perfoarmance: mas rapidos que ui tests
- precision: validas detalles de vista, puede fallar

==================================================
### uitable events prevent crash

Cuando recargamos feed, si el usuario eliminara un item
pasamos de 0 a 2
y al tratar reloadData, cuando estemos en 0, buscaria recargar una item que no existe

OJO
- prueba que el bug existe, resuleve, refactor

### didEndDisplayingCell
didEndDisplayingCell se llama cuando una celda sale de la vista 
aqui podemos llamar para cancelar expensive operations

As the model is transitioning from 10 items to zero, every cell on screen will be removed from the view hierarchy. So UIKit will call didEndDisplayingCell for those rows.

But we don't have items in the tableModel anymore

### manterne referencia
private var loadingItems = [IndexPath: Item]()

==================================================
### organaizng codebases - vertical/horizontal slicing

ventaja de un codigo en modulos
- puedes conectar otros modulos sin afectar los existentes, dada las dependencias y conexiones

Onion architecture
- center = core modules, interfaces
- use cases, services, presentation - feed api, feed cache
- infraestructure adapters - framework specific
- infraestructure frameworks - uikit, sqlite, firebase, etc

BUENISIMO
separo en otr framework el api
creo el framework, arrastro todo lo de api a ese framework EssentialFeedApi
import el framework donde marcaba error
listo
la app separo otro modulo
OJO
esto crearias muchas carpetar, quiza un poco dificil de mantener
SOLO separa cuando sea necesario, por features 

TODO podria vivir en el mismo proyecto de la appios
pero los tests correrian en el simuladto, => mas tiempo de tests

POR TANTO
la logica si podria vivir en platform agnostic
y solo l ode ios en su propio proyceto
separar en diferentes proyects, EssentialLogin, EssentialFeed

### monolith - todo en el mismo proyecto
para apps pequenas, todo esta en un solo lado, dificil de mantenetr

### vertical slicigin
separar features (login, feed) in separate targets, separate projects (workspace)
_features separados, pero no se separa de losmodulos en el target_

### horizontal slicing
following dependencu inversion principle
los modulos de arriba no conocer los de abajo
_se separan los layers, pero no los features_

### combine hor slicing within feature ver - La mejor opcion
Core Feed feature domain - app logic - adapters - framework
Login feateure domina  - app logic - adapters - framework

mas flexibilidad, mas opciones de separar y agreagr tests

Reference
https://academy.essentialdeveloper.com/ios-lead-essentials/447455/resources/15169635
para ver las iamgenes y mas contexto

==================================================
### CD - automating app to deploy

