clear all;clc;

% Extraido de "Identification for the second-order systems based on the step response"
% Lei Chen, Junhong Li, Ruifeng Ding

% sys_G=tf(2*[8 1],conv([5 1],[6 1])); %la otra planta
sys_G=tf(16*[45 1],conv([25 1],[30 1]))

%aca empieza el codigo para mi programa


StepAmplitude = 1;


y_t1=y(lugar);
t_t1=t0(lugar);
ii=1;

t_2t1=t0(lugar);
y_2t1=y(lugar);

t_3t1=t0(lugar);
y_3t1=y(lugar);

K=y(end)/StepAmplitude;
k1=(1/StepAmplitude)*y_t1/K-1;%Afecto el valor del Escalon
k2=(1/StepAmplitude)*y_2t1/K-1;
k3=(1/StepAmplitude)*y_3t1/K-1;
be=4*k1^3*k3-3*k1^2*k2^2-4*k2^3+k3^2+6*k1*k2*k3;
alfa1=(k1*k2+k3-sqrt(be))/(2*(k1^2+k2));
alfa2=(k1*k2+k3+sqrt(be))/(2*(k1^2+k2));
beta=(k1+alfa2)/(alfa1-alfa2);


T1_ang=-t_t1/log(alfa1);
T2_ang=-t_t1/log(alfa2);
T3_ang=beta*(T1_ang-T2_ang)+T1_ang;
T1(ii)=T1_ang;
T2(ii)=T2_ang;
T3(ii)=T3_ang;
T3_ang=sum(T3/length(T3));
T2_ang=sum(T2/length(T2));
T1_ang=sum(T1/length(T1));
sys_G_ang=tf(K*[T3_ang 1],conv([T1_ang 1],[T2_ang 1]))
step(StepAmplitude*sys_G,'r',StepAmplitude*sys_G_ang,'k',200),hold on
legend('Real','Identificada');
legend('boxoff');