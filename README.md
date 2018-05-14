# Inverted-pendulum

##### TODO
  - [ ] Discretizar el modelo lineal en lazo abierto utilizando tres tiempos de
    	muestreo diferentes (aproximación regular, buena y muy buena, según su
  	criterio). Mostrar, analizar y explicar los modelos (continuo y
	discretos) y sus respectivas respuestas a diferentes entradas.

  - [ ] Encuentre la función de transferencia continua del sistema lineal
        (planta). Si su sistema es MIMO, encuentre la matriz de funciones
	de transferencias. Determine los polos, ceros y factor de ganancia
	de la planta (para sistemas MIMO, polos, ceros y factor de ganancia
	para cada par salida-entrada). De igual manera, determine la estabilidad
	de la planta mediante la ubicación de sus polos y ceros en el plano s,
	y finalmente, obtenga su respuesta al escalón y al impulso unitario
	(para sistemas MIMO, realizar esto para cada par salida-entrada).
	Compruebe la salida de estado estacionario aplicando el teorema de valor
	final. Por último, analice los resultados.

  - [ ] Encuentre la función de transferencia discreta (planta) para el sistema
      	del punto 1 que tenga la mejor aproximación. Si su sistema es MIMO,
	encuentre la matriz de funciones de transferencias discretas.
	Determine los polos, ceros y factor de ganancia de la planta
	(para sistemas MIMO, polos, ceros y factor de ganancia para cada par
	salida-entrada). De igual manera, determine la estabilidad de la planta
	discreta mediante la ubicación de sus polos y ceros en el plano z, y
	finalmente, obtenga su respuesta discreta al escalón y al impulso
	unitario (para sistemas MIMO, realizar esto para cada par
	salida-entrada). Compruebe la salida de estado estacionario aplicando
	el teorema de valor final. Por último, analice los resultados.

  - [ ] Si su sistema es de orden superior, reduzca el sistema a un sistema de orden dos.
  Posteriormente, grafique sus polos y ceros y compare las dos respuestas de los sistemas
  ante un escalón unitario. Analice los resultados.

  - [ ] Discretice la planta continua en Simulink utilizando un retenedor de orden cero utilizando
  el Ts de la mejor aproximación del punto 1. Posteriormente compare el sistema discreto
  obtenido con la mejor aproximación del punto 1 y analice los resultados. Si su sistema es
  MIMO, realice el ejercicio para sólo un par salida-entrada.

  - [ ]  Utilizando el método de Routh-Hurwitz, analice la estabilidad de la planta para dos
  parámetros diferentes. Posteriormente, aplique un control con un regulador estático (u = k
  x error) y determine los valores para los cuales el sistema es estable e inestable. Analice los
  resultados.
  
  - [ ]  Utilizando el método de Jury, analice la estabilidad de la planta discreta del punto 1 con la
  mejor aproximación, después de aplicarle un control con un regulador estático (u = k x
  error), y determine los valores para los cuales el sistema es estable e inestable. Analice los
  resultados. Finalmente, compare y analice los resultados del punto 6 y 7.

  - [ ]  Utilizando el método del lugar de las raíces, sintonice un controlador PD y un controlador
  PID para la planta en lazo cerrado de tal manera que logre mejores comportamientos que
  los del sistema en lazo abierto. Grafique los polos y ceros de la función de transferencia de
  lazo cerrado después de sintonizar los controladores y compruebe los resultados ante la
  respuesta escalón unitario y diferentes entradas. Compare los resultados del controlador
  PD con los del PID, analice los resultados y concluya.

##### Contributors:

Santiago Hincapie Potes<br>
Mathematical Engineering Student<br>
Departamento de Ciencia Matematicas, Universidad EAFIT.<br>
Email - [shinca12[at]eafit.edu.co](mailto:shinca12@eafit.edu.co)<br>
Github - https://github.com/shpotes

Andrea Posada Cárdenas<br>
Mathematical Engineering Student<br>
Departamento de Ciencia Matematicas, Universidad EAFIT.<br>
Email - [aposad31[at]eafit.edu.co](mailto:aposad31@eafit.edu.co)<br>
Github - https://github.com/anpoc
