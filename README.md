# Inverted-pendulum

##### TODO
  - [ ] Describir y explicar el modelo, variables (entradas, salidas, estados) y parámetros.
  - [ ] Implementar el sistema en Simulink utilizando bloques y máscaras (máscara con parámetros
        y condiciones iniciales del modelo). El diagrama debe ser claro, disminuyendo al mínimo la
        longitud de las ramas entre bloques, ubicando bien los bloques, conservando la dirección
        de los integradores de izquierda a derecha, poniendo las entradas a la izquierda y las salidas
        a la derecha, pueden utilizar colores si lo desean para diferenciar variables u operaciones,
        se debe poner títulos adecuados a los bloques y ocultar aquellos innecesarios.
  - [ ] Validar el modelo con información conocida de la bibliografía. Es decir, comparar los
        resultados del modelo obtenido con otros resultados previos dados en otros trabajos
        escritos. No continuar hasta estar seguro de que el modelo es correcto.
  - [ ] Simular y analizar el comportamiento del sistema con diferentes tipos de entrada: escalón,
        seno, escalera. Mostrar figuras de las entradas aplicadas y de las salidas obtenidas.
  - [ ] Analizar el efecto del cambio de dos parámetros del modelo en la respuesta temporal y
        presentar los resultados en una tabla. Comparar en una sola figura los cambios con cada
        uno de los parámetros (dos figuras en total). ¿Tiene sentido? ¿Qué significa?
  - [ ] Programar en Matlab la solución numérica de la ecuación de estado utilizando los métodos
        de Euler y Runge-Kutta, y comparar (en una sola figura) las respuestas temporales por los
        métodos anteriores y Simulink.
  - [ ] Trazar la curva de linealidad para cada par entrada/estado en Simulink, aplicando escalones
        o una señal escalera. De igual manera obtener la curva de linealidad enviando diferentes
        entradas desde Matlab a Simulink y exportando los datos de salida de Simulink a Matlab.
        Finalmente, comparar las dos curvas y explicar las diferencias.
  - [ ] Para una entrada constante de interés de la curva de linealidad, calcular los puntos de
        equilibrio del sistema con la función vpasolve de Matlab y analíticamente, y comparar los
        resultados obtenidos con los de la curva de linealidad. Si hay varios puntos de equilibrio,
        explicar el resultado en términos de las condiciones iniciales.
  - [ ] En el punto de equilibrio anterior de la curva de linealidad, linealizar el sistema utilizando
        cualquier método de Matlab/Simulink y analíticamente. Comparar (en una sola figura) las
        respuestas del sistema linealizado y el sistema no lineal en el punto de operación cambiando
    + la señal de entrada por dentro del rango de linealidad
    + la señal de entrada por fuera del rango de linealidad
    + las condiciones iniciales cerca al punto de equilibrio (dejando la entrada constante).

  - [ ] Determinar la estabilidad del sistema en el punto de equilibrio anterior a partir del cálculo
        de los valores propios.
  - [ ] Dibujar y explicar el retrato de fase (para cada par de variables de estado, dejando
        constantes las demás variables) obtenido con la función pplane8.m de Matlab. Determinar
        el tipo de cada punto de equilibrio con las opciones de la función pplane8.m y validarla
        analíticamente con el cálculo de los valores propios del modelo lineal en cada punto.


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
