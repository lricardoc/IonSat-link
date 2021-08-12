%theta (coelevation) from 0 to 180
%phi (azimuth) from 0 to 360)
%theta in X axis
%phi in Y axis
Guhf=zeros(37,73);

step=5;

% for Y=0:step:180
%     Gtest(Y/10+1,1)=gainHF(Y/step+1,3)
% end
% for Y=0:step:180
%     Gtest(Y/10+1,2)=gainHF((2-1)*37+Y/step+1,3)
% end  

for X=0:step:360
    for Y=0:step:180
        Guhf(Y/step+1,X/step+1)=gainuhf((X/step)*73+Y/step+1,3);
    end
end  

%%
Gvhf=zeros(37,73);

step=5;

% for Y=0:step:180
%     Gtest(Y/10+1,1)=gainHF(Y/step+1,3)
% end
% for Y=0:step:180
%     Gtest(Y/10+1,2)=gainHF((2-1)*37+Y/step+1,3)
% end  

for X=0:step:360
    for Y=0:step:180
        Gvhf(Y/step+1,X/step+1)=gainvhf((X/step)*73+Y/step+1,3);
    end
end  

%%
%test
X=[0:step:360];
Y=[0:step:180];
V=Guhf;
%point to test:
Xq=5;
Yq=45;
Vq = interp2(X,Y,V,Xq,Yq)