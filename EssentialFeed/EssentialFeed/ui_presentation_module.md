#  UI Presentation module

==================================================
### prototypes

Importancia de tener prototipos usando lo minimo
- Creaando data fake para presentar ante clientes
- tener respuestas en 2 semanas que en 3 meses
- incluso puedes liberar versiones a testflight para que vean

- trabajar de la mano con disenadores
    - hazles ver las guias de apple para cieras cosas

==================================================
# Platforms & framework

Podemos agregar otros platforms para que se compile
- ios, simulator, etc
- ojo tmb debe ser en los test par que corra

### creamos framwork
Donde alojaremos el EssentialFeediOS para el prouecto iOS
OJO - creamos CI_ios y CI_macos para separar pipelines, no se pueden mezclar 

==================================================
# MVC

### OJO una opantalla puede contener varios MVCs

### Teomporal coupling
cuando invocas miembros de una clase una tras otra, en acoplan tmeporalmente

EN TEST - combina todo en un solo test
ojo con los mensjaes, deben ser precisos

### Refresh
Si cambiamos refresh por button o barra, tendremos que reescribir el test
so 
DSL func simulateUserInitiatedFeedReload()

Solo se preocupe por el refreshi, no por como lo hace

To simulate a ‘tap’ on a UIButton, you can use the .touchUpInside event:

==================================================
# Tests images request / inside-out vs outside-in dev

### DSL - domain specific language
Separamos test de implementacion, asi podemos cambiar mas adelante si queremos
- de tableview a collectionview por ejemplo

### FeedImageDataLoader
loadImageData(from url:URL)
- Separamos la logica del viewcontroller de cualquier implementacion
- open/closed principle - sin modificar controller podemos modificar metodo

### Dependency injection + interface segragation principle
pasamos dos instancias diferentes para ambos protocolos

- deberiamos tener solo un metodo por protocol = interface segregation interface

### new task protocol
task can be canceled

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>

    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
Nos ahorramos el metodo de cancel, y lo dejamos en uno solo

### crear imagen demo
    static func make(withColor color: UIColor) -> UIImage {
Creamos una imagen de prieba (de 1x1) para hacer pruebas 

### inside-out
codificar de adentro hacia afuera
FeedLoader and FeedImage, modelo y protocolo = CORE y liego hacia afuera

### outside-in
disena la vista y ve definiendo el resto
FeedViewController -> FeedIamgeDataLoader

### OJO
Keeping too many responsibilities in a single MVC Controller is an anti-pattern usually known as Massive View Controller.
- share the complexity to many places instead of one.

## open closed principle in FeedViewController
EL comportamiento de un componente puede ser abierto extender sin hacer cambios en el __extension__
Si fuera URLSession - mucho por probar... cache, in memory, loggin, network

<FeedImageDataLoader> - con este protocolo NO acoplamos nada directamente
Carga la imagen como desee
Puede ser mas de uno
CachedFeedImageDataLoader --->FeedImageDataLoader
LogginFeedImageDataLoader --->FeedImageDataLoader

FeedViewController - abierto a extension y cerrado a modificar

Open Closed Principle (OCP) as a result of respecting other principles such as 
the Interface Segregation (ISP), 
Liskov Substitution (LSP), 
Dependency Inversion (DIP) and 
Single Responsibility (SRP). 
Making sure to follow these guidelines will give you the freedom to extend your system with the minimum cost for changing it.


==================================================
# Refactor massive VC - composers

### Mini MVC
FeedViewContrller:
- refreshcontrol
- tableview - images
- iamgecell
- image url

### FeedRefreshViewController
lazy var para inicializar contrl
inyectamos dependencia - feedLoader
enviamos closure para regresar data 

### dependencias
Al crear otros controllers para manejar refresh y cell, debemos manejar estos componentes en otro componente para que no crezca las deendencias 

- podria sera un Factory, pero serian mas dependencia
- So...
tableModel - ya no sera mas de feedimage, ahora de cells
dentro de cellscontrollers, manejamos el resto

al obtener las imagenes, las pasamos a cells

En el init, crea instancia para refresh y para cells...
So - CREAMOS COMPOSER
- adapt pattern
- te ayuda aconectar unmatching apis
- reglas
Composers should only be used in the Composition Root
Only Composers can use other Composers

Este  componente crea el refresh y las celdas
- crea un FeedViewContrller que piede ser llamado desde cualqueir lado

==================================================
# MVVM - reducing boilerplate / swift generics 

Tenemos mucha funcionalidad en los controllers
- Si tuvieramos que agrear wathckit, se copiaria y pegaria mucho codigo
- Aqui entra MVVM
- it’s common for iOS teams to use frameworks like RxSwift or Combine.

* Creado por microsoft para eliminar boilerplate entre views y models
Model View Binder
* Todo el manejo del __estado__ vive en el ViewModel - queda reusable
* podemos usar el ViewModel para multiples platforms
    * ViewModel no debe depender de UIKit
    
* El ViewModel no tiene una referencia al view, como lo tiene el MVC
    
    
* tambien ayuda como capa para transformar data
- Date a String 

* si te ves duplicando codigo entre controllers, o transormando valores en contrllers
    - muevelo a un platform agnostic viewmodel
    On the other hand, it’s recommended for ViewModels to be platform-and-framework-agnostic so that you can reuse them on __multiple platforms__.

stateful and stateless

### observers
typealias Observer<T> = (T) -> Void
So
    var onLoadingStateChange: ((Bool) -> Void)?
    . . . 
    var onLoadingStateChange: Observer<Bool>?

Tmb
    var onFeedLoad: (([FeedImage]) -> Void)?
    . . .
    var onFeedLoad: Observer<[FeedImage]>?

### generics
final class FeedImageViewModel<Image> {
    
    private let imageTranformer: (Data) -> Image?
}
Dejamos el viewmodel generico y asi podemos convertir la data en cualquier image type

final class FeedImageCellContrller {
    let viewModel: FeedImageController<UIImage>
}
la dependencia de uikit queda en el controller

To decouple the Presentation layer from UIKit types, we defined a generic Image type and used Dependency Injection (construction injection) to pass a transformation closure to convert Data into any Image type.

==================================================
# MVP - proxy pattern

- separar ui from presentation logic
- reusable cross-platforms presnetaton layers

MVC - controller tiene una referencia a la vista (fuerte)
MVVM - el viewmodel notifica cambios a la vista (medio) - reactivo
MVP 
- el presenter tiene un protocolo que hace vista abstracta y coencta con el view - two way communicationg
- tranformar data y la manda en un struct (viewmodel, viewdata)

protocol FeedView {
    func display(feed:[FeedImage])
}

final class FeedPresenter {
. . .
    var feedView: FeedView?
. . .
    self.feedview.display(feed: feed)
}

- PERO OJO
Deberia pasar viewmodel, en casi de agregar mas items, no rompes el protocol
- solo guarda data

### adapter
Creamos capa para manejar un solo camino, no two wayss

### interface segregation principle
Client no deben forzarse a usar o depender de interfaces que no usen

❌ protocol Worker {
    func work()
    func eat()
}

✅
protocol Workable {
    func work()
}

protocol Eatable {
    func eat()
}

==================================================
# Storybard...

Cambiamos del codigo al storyboard, ahora aqui se maneja los aoutles, no mas codigo

- uirefresh vive en el stoyboard


