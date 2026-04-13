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
