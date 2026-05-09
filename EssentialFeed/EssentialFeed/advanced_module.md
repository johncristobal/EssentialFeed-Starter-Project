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
