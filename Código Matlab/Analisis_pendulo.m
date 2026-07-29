%% ANALISIS DEL PENDULO SIMPLE CON PHYPHOX

clear
clc
close all

%% Lectura del archivo Excel

archivo = "PenduloSimple.xls";

datos = readtable(archivo,"Sheet","Raw Data");
auto = readtable(archivo,"Sheet","Autocorrelation");
res = readtable(archivo,"Sheet","Resonance");

%% Nombres de las columnas

datos.Properties.VariableNames

%% Extracción de las variables

tiempo = datos.Time_s_;

rot_x = datos.RotationX_rad_s_;

rot_y = datos.RotationY_rad_s_;

rot_z = datos.RotationZ_rad_s_;

%% Velocidad angular en el eje X

figure

plot(tiempo,rot_x)

grid on

title('Velocidad angular en el eje X')

xlabel('Tiempo (s)')

ylabel('Velocidad angular (rad/s)')

%% Velocidad angular en el eje Y

figure

plot(tiempo,rot_y)

grid on

title('Velocidad angular en el eje Y')

xlabel('Tiempo (s)')

ylabel('Velocidad angular (rad/s)')

%% Velocidad angular en el eje Z

figure

plot(tiempo,rot_z)

grid on

title('Velocidad angular en el eje Z')

xlabel('Tiempo (s)')

ylabel('Velocidad angular (rad/s)')

%% Comparación de las velocidades angulares

figure

plot(tiempo,rot_x)
hold on

plot(tiempo,rot_y)

plot(tiempo,rot_z)

grid on

title('Comparación de las velocidades angulares')

xlabel('Tiempo (s)')

ylabel('Velocidad angular (rad/s)')

legend('Rotation X','Rotation Y','Rotation Z')

%% gRAFICA AUTOCORRELACION 
auto.Properties.VariableNames

%% Variables de autocorrelación

tiempo_auto = auto.TimeShift_s_;

auto_corr = auto.AutocorrelationOfSum;

%% Gráfica de autocorrelación

figure

plot(tiempo_auto,auto_corr)

grid on

title('Autocorrelación del movimiento del péndulo')

xlabel('Desplazamiento temporal (s)')

ylabel('Autocorrelación')

%% Encontrar los máximos

[picos,indices] = findpeaks(auto_corr);

tiempos_maximos = tiempo_auto(indices)

%% Cálculo del período

periodos = diff(tiempos_maximos)

periodo_promedio = mean(periodos)

%% Frecuencia experimental

frecuencia_exp = 1/periodo_promedio

%% Grafica Resonancia 
res.Properties.VariableNames

%% Variables de resonancia

frecuencia = res.Frequency_Hz_;

amplitud = res.Rel_Amplitude_a_u__;



%% Espectro de frecuencias

figure

plot(frecuencia,amplitud)

grid on

title('Espectro de frecuencias del péndulo')

xlabel('Frecuencia (Hz)')

ylabel('Amplitud relativa')

%% Frecuencia predominante

[max_amp,indice_max] = max(amplitud);

frecuencia_predominante = frecuencia(indice_max)

amplitud_maxima = max_amp