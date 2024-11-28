clc;close all;clear
slip_angle=xlsread('轮胎数据.csv','B2:B53');
FZ=xlsread('轮胎数据.csv','C2:J2');
cornering_force=xlsread('轮胎数据.csv','C3:J53');
[x,y]=meshgrid(slip_angle,FZ);
z=cornering_force';
figure('Color','w')
surf(x,y,z)
xlabel('侧偏角(deg)');ylabel('垂向载荷(N)');zlabel('测偏力(N)');
%车辆参数：质量、前轴距、后轴距
m=1270;
ms1=88.6;
ms2=88.6;
a=1.015;
b=1.895;
g=9.8;
m1=0.5*(m/(a+b)*b+ms1)*g;
m2=0.5*(m/(a+b)*b+ms2)*g;
[xx,yy]=meshgrid(slip_angle,[m1,m2]);
zz=interp2(x,y,z,xx,yy,'spline');
fy1=zz(1,:);
fy2=zz(2,:);
figure('Color','w')
plot(slip_angle,fy1)
hold on
grid on
plot(slip_angle,fy2,'r')
legend('前轮','后轮')
xlabel('侧偏角\alpha(deg)')
ylabel('测偏力F_f(N)')
%------------------------------------
slip_ref=1;
Ff=interp1(slip_angle,fy1,slip_ref,'spline');
plot(slip_ref,Ff,'o')
Fr=interp1(slip_angle,fy2,slip_ref,'spline');
plot(slip_ref,Fr,'or')
%cf_max=Ff(find(slip_ref==1.8))/1.8*180/pi
%rcf_max=Ffr(find(slip_ref==1.8))/1.8*180/pi
%cf_max=Ff(find(slip_ref==5))/5*180/pi
%cf_max=Ff(find(slip_ref==5))/5*180/pi
%fprintf('前轮侧偏刚度')
cf=2*Ff./slip_ref*180/pi
cr=2*Fr./slip_ref*180/pi
%%j