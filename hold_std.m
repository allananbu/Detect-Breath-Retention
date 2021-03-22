clc
clear all
close all

fs=10;
Ts=1/10;
load('C:\Users\Allan\Desktop\JRF\Realsense\MATLAB\Hold_Eg\Allan_Belt_hold_4.mat')
x=Force;

x=movmean(x,4);
t=linspace(0,50,length(x));
short_win=zeros([1 25]);
j=1;
k=1;
l=1;
l1=10;
H=10;
FLAG=0;
wind_time=length(short_win)*[1:20];

for i =1:length(x)
    short_win=circshift(short_win,1);
    short_win(:,1)=x(i);
    if mod(i,length(short_win))==0
        short_std(j)=std(short_win);
        
        
        if j<=H  
            long_std(k)=median(short_std(1:j));
            k=k+1;
        else
            long_std(k)=median(short_std(j-H:j));
            k=k+1;
        end
        
        if short_std(j)<=long_std(j)/3
            HOLD=1;
            window(l)=j;
            l=l+1;
        end
        j=j+1; 
%         if mod(length(short_std),4)==0
%             long_std(k)=median(short_std);
%             k=k+1;
        end
end


plot(x)
hold on
for i=1:length(wind_time)
    xline(wind_time(i));
end