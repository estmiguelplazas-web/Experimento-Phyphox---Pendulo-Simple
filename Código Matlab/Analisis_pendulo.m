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

plot(tiempo,rot_x,"b")

grid on

title('Velocidad angular en el eje X')

xlabel('Tiempo (s)')

ylabel('Velocidad angular (rad/s)')

%% Velocidad angular en el eje Y

figure

plot(tiempo,rot_y,'r')

grid on

title('Velocidad angular en el eje Y')

xlabel('Tiempo (s)')

ylabel('Velocidad angular (rad/s)')

%% Velocidad angular en el eje Z

figure

plot(tiempo,rot_z,"g")

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


%% GRÁFICA AUTOCORRELACIÓN

auto.Properties.VariableNames

%% Variables de autocorrelación

tiempo_auto = auto.TimeShift_s_;
auto_corr = auto.AutocorrelationOfSum;


%% Buscar los máximos de la autocorrelación

[maximos, indices] = findpeaks(auto_corr);

% Obtener el tiempo correspondiente a cada máximo
tiempo_maximos = tiempo_auto(indices);


%% Gráfica de autocorrelación

figure

% Graficar la autocorrelación
plot(tiempo_auto, auto_corr,'LineWidth',1.5)

hold on

% Graficar los máximos encontrados
plot(tiempo_maximos, maximos,'ro','MarkerSize',7,'MarkerFaceColor','r')


%% Mostrar el valor de cada máximo en la gráfica

for i = 1:length(maximos)

    etiqueta = sprintf('(%.2f s, %.2f)',tiempo_maximos(i), maximos(i));

    text(tiempo_maximos(i), maximos(i), etiqueta, 'FontSize',9,'VerticalAlignment','bottom');

end


%% Configuración de la gráfica

grid on

title('Autocorrelación del movimiento del péndulo')

xlabel('Desplazamiento temporal (s)')

ylabel('Autocorrelación')

legend('Autocorrelación','Máximos encontrados', 'Location','northeast')

hold off



%% Cálculo del período

periodos = diff(tiempo_maximos)

periodo_promedio = mean(periodos)

%% Frecuencia experimental

frecuencia_exp = 1/periodo_promedio




%% Grafica Resonancia

res.Properties.VariableNames


%% Variables de resonancia

frecuencia = res.Frequency_Hz_;
amplitud = res.Rel_Amplitude_a_u__;


%% Gráfica de la frecuencia predominante del péndulo

figure

% Datos experimentales
scatter(frecuencia, amplitud,40,'filled')

hold on

% Buscar la frecuencia con mayor amplitud
[amp_max, indice] = max(amplitud);
f_principal = frecuencia(indice);

% Graficar la frecuencia principal
scatter(f_principal, amp_max,80,'filled')

% Mostrar el valor de la frecuencia predominante
texto = sprintf('f = %.4f Hz', f_principal);

text(f_principal, amp_max, texto,'FontSize',10,'VerticalAlignment','bottom','HorizontalAlignment','left');

grid on

title('Frecuencia predominante del péndulo')

xlabel('Frecuencia (Hz)')

ylabel('Amplitud relativa (u.a.)')

legend('Datos experimentales','Frecuencia principal','Location','northeast')

hold off


%% Frecuencia predominante

[max_amp,indice_max] = max(amplitud);

frecuencia_predominante = frecuencia(indice_max)

amplitud_maxima = max_amp