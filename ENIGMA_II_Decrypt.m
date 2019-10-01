function PlainText= ENIGMA_II_Decrypt(ChiperText,Key)

%   Making variables of the different wheels and set a identification
%   number on each 'wheel'.
    w7=['7','azyxwvutsrqponmlkjihgfedcb'];
    w6=['6','acedfhgikjlnmoqprtsuwvxzyb'];
    w5=['5','abcdefghijklmnopqrstuvwxyz'];
    global out;
    out = '';
    
%   Making a matrice of all the wheels. 
    WO=[w7;w6;w5];
    
%   This syncronice every 'wheel' inside a matrix and removes the
%   identifying numbers.
    for i=num2str(Key(1:3))  
        idx=strfind(Key,i);
        if idx==3
            row=find(WO==i);
             WO=RowChange(WO,idx,row);
             WO3=WO(idx,(2:end));
             WO3=circshift(WO3,26-strfind(WO3,Key(6))+1);
        elseif idx==2
            row=find(WO==i);
            WO=RowChange(WO,idx,row);
            WO2=WO(idx,(2:end));
            WO2=circshift(WO2,26-strfind(WO2,Key(5))+1);
        elseif idx==1
            row=find(WO==i);
            WO=RowChange(WO,idx,row);
            WO1=WO(idx,(2:end));
            WO1=circshift(WO1,26-strfind(WO1,Key(4))+1);
        end
    end
    
%   Setting some test paramerters and create a
%   counter.
    TF=isstrprop(ChiperText,'alpha');
    count=0;

%   Starting the decryption.
    for i=1:length(ChiperText)
            Up=isstrprop(ChiperText(1,i),'upper');

%       Testing if the char is 'alpha'
        if TF(i)~= 0
            count=count+1;
          
%           Ask if counter is odd or even. Used to alternate between
%           wheels and syncronicing wheels based on chipertext.
            if mod(count,2)==0
            P=strfind(WO2,lower(ChiperText(1,i)));
            MW=circshift(WO2,26-P+1);
            RW=circshift(WO3,P-1);
            else
            P=strfind(WO1,lower(ChiperText(1,i)));
            LW=circshift(WO1,-P+1);
            RW=circshift(WO3,-P+1);
            end

%                  Asks if chiphertext char is 'upper' and relay that
%                  information based on chipertext
                   if Up==1
                       RW=RW(1,1);
                       out=[out upper(RW)];
                   else
                       RW=RW(1,1);
                       out=[out RW];
                   end
%       If the char in the chipertext is not an 'alpha' its just passing
%       trough.
        else
              out=[out ChiperText(1,i)];
         end
    end
    
    PlainText=out;
end