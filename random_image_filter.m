%%%Project by:
%%%Aditya Vashista(101703039,COE2)

clear all;
prompt = 'Enter file path: ';
str = input(prompt,'s');
i = imread(str);
[or oc d]=size(i);
ar=randsample(or,3);
ac=randsample(oc,3);
ar=sort(ar);
ac=sort(ac);

tempLog=double(i);
tempLog=log(1+(tempLog))/log(256);
tempLog=tempLog*255;
tempLog=uint8(tempLog);

tempGrey=rgb2gray(i);

tempGamma=double(i);
tempGamma=((tempGamma/255).^0.3)*255;
tempGamma=uint8(tempGamma);

tempNeg=255-i;
for r=1:or
    for c=1:oc
        if (r<=ar(3) && r>ar(1)) && (c<=ac(3) && c>ac(1))
            %strecting
            if i(r,c)>= 130 && i(r,c)<=180
                 iNew(r,c,1)=100 + ((220-100)/(180-130))*(i(r,c,1)-130);
                 iNew(r,c,2)=100 + ((220-100)/(180-130))*(i(r,c,2)-130);
                 iNew(r,c,3)=100 + ((220-100)/(180-130))*(i(r,c,3)-130);
            else
                iNew(r,c,1)=i(r,c,1);
                iNew(r,c,2)=i(r,c,2);
                iNew(r,c,3)=i(r,c,3);
            end
            
        elseif r<=ar(2) && c<=ac(2)
            %log
            iNew(r,c,:)=tempLog(r,c,:);
        
        elseif r>ar(2) && c<=ac(2)
            %grey
            iNew(r,c)=tempGrey(r,c);
        elseif r<=ar(2) && c>ac(2)
            %neg
            iNew(r,c,:)=tempNeg(r,c,:);
        else
            %gamma
            iNew(r,c,:)=tempGamma(r,c,:);
         
        end
    end
end

%ALPHA BLENDING
iFinal=double(i)*0.6+double(iNew)*0.4;
iFinal=uint8(iFinal);

subplot(3,1,1);
imshow(i);
title("Original image");
subplot(3,1,2);
imshow(iNew);
title("Magic image");
subplot(3,1,3);
imshow(iFinal);
title("NEW image");
