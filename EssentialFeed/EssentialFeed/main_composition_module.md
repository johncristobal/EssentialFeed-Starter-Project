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

==================================================
### high level ui test / launch args

==================================================
### fast integration tests
