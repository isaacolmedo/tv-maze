
# Explicar la arquitectura que utilizaste en tu proyecto y la razón por la que decidiste utilizarla

Se uso la arquitectura MVVM para su desarrollo, de la siguiente manera

  |──── Common\ 
  Clases de uso en común en el proyecto como extensiones, singletons, etc

  |──── MVVM\
  Modelo-Vista-VistaModelo Son protocolos que funcionan como contratos, así cuando se genera un nuevo modulo, se asegura que se cumplan las reglas de MVVM para este proyecto.

	|──── Builder
	Genera el modulo MVVM

	|──── Context
	Contiene datos que se pasan a través de la aplicación

	|──── Router
	Es el que controla la navegación de la aplicación

	|──── View
	Se encuentran todos los elementos necesarios para el control y diseño de la vista 

	|──── ViewModel
	Se encuentran todos los objetos para implementar la lógica de negocio
  
  |──── Modules 
  Modulos individuales que generan la aplicación

	|──── ViewModelDataSource
	Se encuentran los datos que se inyectan al viewModel
  


Se decidió usar esta arquitectura, ya que la aplicación es muy sencilla, se pudo usar MVC pero, ya que es lo más sencillo, sin embargo, la capa de negocio no esta aislada de la vista, y en MVVM, esta se encuentra en el ViewModel. Se prefirió tener una lógica aislada y por eso MVVM. VIPER también aisla esta parte, pero se considero no usarla debido que es demasiado robusta para una aplicación tan sencilla.

# Lista de las librerías externas que utilizaste, explicándo qué hacen y la razón por la que la elegiste

RxSwift -> Es una librería que nos ayuda a implementar la programación reactiva con Swift. Básicamente su funcionamiento es a través de emisión de señales que se envián observadores y suscriptores. Por ejemplo, cuando un sujeto A pide una suscripción a un periodico B, el sujeto B envía una señal(periodico) al sujeto A. Esta señal se lee, el sujeto A puede reaccionar (de aquí que se le conozca como programación reactiva) y enviar otra señal, esta señal puede ser otro mensaje (por ejemplo, que ya no quiere recibir más periodicos), una señal de cancelación, o una señal de confirmación que el periodico se ha recibido de manera correcta. 

Como su comportamiento natural es el envío de señales, encaja perfecto con MVVM ya que la vista reacciona a datos enviados por el viewModel y el viewModel se suscribe a esas señales. 

SDWebImage -> Es un manejador de descargas para imagenes y contiene muchas funciones útiles como guardar e caché, descarga progresiva, étc. Es bastante robusto, y nos facilita mucho la vida a la hora de descargar varias imagenes de manera asíncrona. 

Si bien es muy robusto, y hasta a veces se condidero no usarla debido a esto, finalmente se decidió que si debido a su facilidad de implementación.

Lottie: Es una librería creada por ARBNB para crear animaciones. 

Se uso para facilitar el uso de animaciones


# Qué parte(s) de tu código pueden ser mejoradas si tuvieras más tiempo

La parte de las transiciones de las vistas quedo un poco desorganizado, también me falto separar los componentes configuraciones generales de la app. Y por último, hacer más prubeas unitarias

# Cuáles fueron los mayores problemas que encontraste en el desarrollo de la práctica y cómo los resolviste?
Sinceramente creo que las animaciones, ya que tenía un tiempo que no las usaba. Lo resolví con una librería externa que me facilito la implementación.





































