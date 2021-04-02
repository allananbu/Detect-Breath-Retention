clc
clear all
close all

fs=10;
Ts=1/10;
load('C:\Users\Allan\Desktop\JRF\Realsense\MATLAB\Hold_Eg\Allan_Belt_hold_9.mat')
x=Force;

x=movmean(x,10);
final_digi=ones(length(x),1);
t=linspace(0,100,length(x));
short_win=zeros([1 10]);
j=1;
k=1;
l=1;
y=1;
z=1;
l1=10;
H=20;
HOLD=0;
PEAK_FLAG=0;
VALLEY_FLAG=0;
HOLD_FLAG=0;
tot_time=[];
g=1;
wind_time=length(short_win)*[1:length(x)/length(short_win)];

for i =1:length(x)
    short_win=circshift(short_win,1);
    short_win(:,1)=x(i);
    HOLD_FLAG(i)=0;
    if mod(i,length(short_win))==0
        short_std(j)=std(short_win);
        
        
        if j<=H  
            long_std(k)=median(short_std(1:j));
            k=k+1;
        else
            long_std(k)=median(short_std(j-H:j-1));
            k=k+1;
        end
        
        if short_std(j)<=long_std(j)/3
            HOLD_FLAG(i)=1;
            window(l)=j;
            
        if length(window)>=2 & window(l)-window(l-1)==1
            tot_time=[tot_time wind_time(l-1):wind_time(l)];
           % tot_time(1:end)=1;
            final_digi(tot_time)=0;
        end
%if length(window)>=2 & window(l-1)==j-1
%                 temp_window(g)=j;
%                 g=g+1;
%                 end
            l=l+1;
        end
        j=j+1;
%         if ismember(j-1,window)
%             idx=find(diff(window)==1);
%             result=find(diff(idx)==1);
%         end
            
        
%         if mod(length(short_std),4)==0
%             long_std(k)=median(short_std);
%             k=k+1;
    end
    
       
     
    if i>=2
        con=(x(i)-x(i-1));
        d(i)=sign(con);
        if d(i)~=d(i-1)
            if d(i)==-1
                if x(i-1)>mean(x) & VALLEY_FLAG==0 
                    peak(y)=i-1;
                    y=y+1;
                    PEAK_FLAG=0;
                    VALLEY_FLAG=1;
                end
            else if d(i)==1
                    if x(i-1)<mean(x) & PEAK_FLAG==0 & VALLEY_FLAG==1
                        valley(z)=i-1;
                        PEAK_FLAG=1;
                        VALLEY_FLAG=0;
                        z=z+1;
                    end
                end
            end
        end
    end
end


plot(x,'LineWidth',3)
hold on
for i=1:length(window)
    %xline(wind_time(window(i)),'LineWidth',3);
    wind_time(window(i))=0;
end
for i=1:length(wind_time)
    xline(wind_time(i),'LineWidth',1);
%     wind_time(i)=1;
end

figure(2)
plot(t,x,'LineWidth',3)
hold on
plot(t(peak),x(peak),'x','LineWidth',3,'MarkerSize',7)
plot(t(valley),x(valley),'o','LineWidth',3,'MarkerSize',7)    

figure(3)
plot(final_digi)

digi_sig=[];
wind_count=9;

for i=1:length(wind_time)
    for j=1:9
        if wind_time(i)~=0 & length(i)>=2
            tot_len=wind_time(i)-wind_count;
            wind_count=wind_count-1;
            digi_sig=[digi_sig tot_len];
        else
            wind_count=9;
        end
    end
end

plot(x,'LineWidth',3)
hold on
all_length=zeros(1,1000);
for i=1:length(digi_sig)
    %xline(digi_sig(i),'LineWidth',2)
    all_length(digi_sig(i))=1;
end