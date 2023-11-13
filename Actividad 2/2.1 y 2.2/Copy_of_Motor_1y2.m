clear all;close all;clc;


ruta_archivo = 'D:\Facultad Jeremías\2023 primer semestre\Sistemas de control 2\TPS\TP3 pucheta\Motor\Curvas_Medidas_Motor_2023.xls';
hoja_trabajo = 'Hoja1';
[num, txt, raw] = xlsread(ruta_archivo, hoja_trabajo);
tiempo = num(:, 1)+1; % Primera columna de datos numéricos
angulo = num(:, 2); % Segunda columna de datos numéricos
velocidadAngular = num(:, 3);
CorrienteDeArm = num(:, 4);
TensionAplicada = num(:, 5);
Torque = num(:, 6);

%Definicion de parametros

Laa=0.56e-3;
J=0.0019;
Ra=1.35;
Bm=0.000792; %Pagina 357 
Ki=.1;
Km=.1;

A=[-Ra/Laa -Km/Laa 0;Ki/J -Bm/J 0; 0 1 0];
B=[1/Laa 0;0 -1/J;0 0];

%Definiion de vectores y Dt=h
tsim=10;
h=1e-3;
t=0:h:(tsim-h);

%Entradas del sistema
flag=1;
contador=0;
ref=zeros(1,round(tsim/h));
for i=1:1:(tsim/h)
    if flag==1 
    ref(1,i)=pi/2;
    contador=contador+1;
        if contador==round(5/h)
            flag=0;
            contador=0;
        end
    else 
    ref(1,i)=-pi/2;
    contador=contador+1;
             if contador==round(5/h)
                flag=1;
                contador=0;
            end
    end
   
end
% figure(1)
% plot(t,ref);
% title('Referencia');
flag=1;
contador=0;
tLin=zeros(1,round(tsim/h));
for i=1:1:(tsim/h)
    if flag==1 
%     tLin(1,i)=0.103;
    tLin(1,i)=0;
    contador=contador+1;
        if contador==round(5/h)
            flag=0;
            contador=0;
        end
    else 
    tLin(1,i)=0.103;
    contador=contador+1;
             if contador==round(5/h)
                flag=1;
                contador=0;
            end
    end
   
end
% figure(1)
% plot(t,tLin);
% title('Torque de entrada');


%Simulacion 
%condiciones iniciales
x(1,1)=0;
x(2,1)=0;
x(3,1)=0;
% u=[TensionAplicada Torque]';

B1=[1/Laa;0;0];
B2=[0;-1/J;0];

for i=1:1:(tsim/h+h)
    %Variables del sistema lineal
    x1(1,i)= x(1,1);
    x2(1,i)= x(2,1);
    x3(1,i)= x(3,1);
    %Sistema lineal
    %     xp=A*x+B*u(:,i);
    xp=A*x+B1*ref(1,i)+B2*tLin(1,i);
    x=x+h*xp;
    
end


figure(3)
plot(t,x1);
title('Corriente de armadura i_a');
xlabel('Tiempo (seg.)');
ylabel('Corriente (A)');
grid on;

figure(4)
plot(t,x2);
title('Velocidad angular \omega_r');
xlabel('Tiempo (seg.)');
ylabel('Velocidad angular (rad/s)');
grid on;

figure(5)
plot(t,x3);
title('Poscion angular \theta_t');
xlabel('Tiempo (seg.)');
ylabel('Posicion angular (Rad)');
grid on;











