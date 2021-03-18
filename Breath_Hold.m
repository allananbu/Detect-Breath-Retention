clc
clear all
close all

% fs=200;
% fc=4;
% t=0:1/fs:1;
% x=sin(2*pi*fc*t);
% x(:,80:100)=0.01*rand(1,21,'single')';
fs=30;
load('C:\Users\Allan\Desktop\JRF\Realsense\Data\Allan\Allan_RS_8_Filter.mat')
x=Filter(15:end);
t=1:length(x);
plot(t,x)
j=1;
k=1;
l=1;
m=1;
n=1;
z=1;
s=1;
temp=zeros(1,5);
PEAK_FLAG=0;
VALLEY_FLAG=0;
HOLD_FLAG=0;
RET_FLAG=0;
C={};
%find slope
for i=2:length(x)
    con=(x(i)-x(i-1));
    d(i)=sign(con);
    RET_FLAG(i)=0;
    if length(d)>=length(temp)
        temp(5)=0;
        temp=circshift(temp,1);
        temp(1)=d(i);
        if HOLD_FLAG==1 & length(hold)>=1 & length(idx)>=1
            if (i-1)>hold(end) 
                hold(idx(end)-3:idx(end))=0;
                hold=hold(hold~=0);
                HOLD_FLAG=0;
                l=l-4;
            end
        end

        if sum(temp)<=3 & sum(temp)>=-3 & not(ismember(0,any(temp,1)))
            if x(i)>(mean(x(1:i)))
                %if ismember(i-4,hold)
                hold(l)=i;
                %end
%                 if length(hold)>=5
%                     new_hold=hold(l)-hold(l-4);
%                     if new_hold<=5
%                         final_hold(l)=i;
%                     end
%                 end
                HOLD_FLAG=1;
                RET_FLAG(i)=1;
                new=diff(hold);
                tf=new>5;
                idx=find(tf);
                x1=size(idx);
                l=l+1;
                
%                 if length(idx)>=1
%                     hold(idx-3:idx)=0;
%                     idx=idx-3;
%                 end
%                 if length(idx)==1
%                     if new(idx)>5
%                       hold(idx-3:idx)=0;
%                       hold(hold==0)=[];
%                       idx=idx-3;
%                     else
%                         break
%                     end
                
%                     hold(idx+1:idx+4)=0;
%                     hold(hold==0)=[];

%                     l1=idx(end)-3;
%                     l2=idx(end);
%                     new_hold=hold(idx(n));
%                     my_hold=new_hold-3:new_hold;
%                     [X,Y]=ismember(my_hold,hold);
%                     hold(Y(X))=[];
%                     C{l}=hold(1:idx(end)-3);
                    %hold([idx(end)-3:idx(end)])=[];
%                     idx=idx-4;
                    
%                 else if length(idx)>2
%                     idx=idx-4;
%                     hold(idx(length(idx))-3:idx(length(idx)))=[];
%                     end
%                 hold(hold==0)=[];    
                end

%                 idx=idx-4;
        end
        
    
        

    end
%     if  length(hold)>4
%         val=find(hold==i);
%         if val(2)==0
%             idy=i;
%             z=z+1;
%         else
%             z=1;
%         end
%         
%     end
    if length(RET_FLAG)>=4
        if RET_FLAG(i)==1 & RET_FLAG(i-4)==1
            hold_ind=i;
            new_hold(s)=i;
            s=s+1;
        end
    end
   

    if d(i)~=d(i-1)
        if d(i)==-1
%             cond=find(i-1==hold);
            if x(i-1)>mean(x) & VALLEY_FLAG==0 
                
                    
                peak(j)=i-1;
                

                j=j+1;
                PEAK_FLAG=0;
                VALLEY_FLAG=1;
            end
%             z=find(hold==peak(j)+1);
%             z1=find(hold==peak(j)+2);
%             hold(z)=[];
%             hold(z1)=[];
%             j=j+1
%             if length(peak)>=2
%                 peak_val=
%                 if peak_val<=0
%                     peak(j)=[];
%                 end
            
                
            
%             end
        else if d(i)==1
                if x(i-1)<mean(x) & PEAK_FLAG==0 & VALLEY_FLAG==1
                    valley(k)=i-1;
                    PEAK_FLAG=1;
                    VALLEY_FLAG=0;
                    k=k+1;
                end
        
        end
%             
    end
    end
end
        


figure(2)
plot(t,x)
hold on
plot(t(new_hold),x(new_hold),'*')
plot(t(peak),x(peak),'x')
plot(t(valley),x(valley),'o')

    