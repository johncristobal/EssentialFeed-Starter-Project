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



