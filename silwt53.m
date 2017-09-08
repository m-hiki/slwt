function frame=silwt53(coef,level)
%silwt53    Inverse lifting 5x3 wavelet transform
%
%
%  Example: 
%
%    frame=silwt53(coef);
%
%  -----------------------------------------------------------------
%  silwt53.m                              Minoru Hiki.     06/06/13
  [height width]=size(coef);
	
  for i=1:level
    hb=ceil(height/2^(level-i));
    wb=ceil(width/2^(level-i));
    coef(1:hb,1:wb)=trx(coef(1:hb,1:wb));
  end
  frame=coef;
  
function frame=trx(coef)
  [height width]=size(coef);
  
  hb=round(height/2);
  wb=round(width/2);
  
  frame(1:2:height,1:2:width)=coef(1:hb,1:wb);
  frame(1:2:height,2:2:width)=coef(1:hb,wb+1:width);
  frame(2:2:height,1:2:width)=coef(hb+1:height,1:wb);
  frame(2:2:height,2:2:width)=coef(hb+1:height,wb+1:width);
  
  frame = double(frame);
  
  % vertical
  if(rem(height,2)==0)
    % update
    frame(1,:)=frame(1,:)-floor((frame(2,:)+1)/2);
    frame(3:2:height-1,:)=frame(3:2:height-1,:)-...
        floor((frame(2:2:height-2,:)+frame(4:2:height,:)+2)/4);
    % predict
    frame(2:2:height-2,:)=frame(2:2:height-2,:)+...
        floor((frame(1:2:height-3,:)+frame(3:2:height-1,:))/2);
    frame(height,:)=frame(height,:)+frame(height-1,:);
  else
    % update
    frame(1,:)=frame(1,:)-floor((frame(2,:)+1)/2);
    frame(3:2:height-2,:)=frame(3:2:height-2,:)-...
        floor((frame(2:2:height-3,:)+frame(4:2:height-1,:)+2)/4);
    frame(height,:)=frame(height,:)-...
        floor((frame(height-1,:)+1)/2);
    % predict
    frame(2:2:height-1,:)=frame(2:2:height-1,:)+...
        floor((frame(1:2:height-2,:)+frame(3:2:height,:))/2);
  end
  
  % horizontal
  if(rem(width,2)==0)
    % update
    frame(:,1)=frame(:,1)-floor((frame(:,2)+1)/2);
    frame(:,3:2:width-1)=frame(:,3:2:width-1)-...
        floor((frame(:,2:2:width-2)+frame(:,4:2:width)+2)/4);
    % predict
    frame(:,2:2:width-2)=frame(:,2:2:width-2)+...
        floor((frame(:,1:2:width-3)+frame(:,3:2:width-1))/2);
    frame(:,width)=frame(:,width)+frame(:,width-1);
  else
    % update
    frame(:,1)=frame(:,1)-floor((frame(:,2)+1)/2);
    frame(:,3:2:width-2)=frame(:,3:2:width-2)-...
        floor((frame(:,2:2:width-3)+frame(:,4:2:width-1)+2)/4);
    frame(:,width)=frame(:,width)-...
        floor((coef(:,width-1)+1)/2);
    % predict
    frame(:,2:2:width-1)=frame(:,2:2:width-1)+...
        floor((frame(:,1:2:width-2)+frame(:,3:2:width))/2);
  end
  
  %frame = uint8(frame);
