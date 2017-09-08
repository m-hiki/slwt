function frame=silwt97r(coef,level)
%silwt97r    Spatial inverse lifting 9x7 wavelet transform (real type)
%
%
%  Example: 
%
%    frame=silwt97r(coef, 5);
%
%    
%  -----------------------------------------------------------------
%  silwt97r.m                             Minoru Hiki.     06/06/13

  [height width]=size(coef);
	
  for i=1:level
     hb=ceil(height/2^(level-i));
     wb=ceil(width/2^(level-i));
     coef(1:hb,1:wb)=trx(coef(1:hb,1:wb));
  end
  frame=coef;

function frame=trx(coef)
  ALPHA = -1.586134342059924;
  BETA  = -0.052980118572961;
  GAMMA =  0.882911075530934;
  DELTA =  0.443506852043971;
  K     =  1.230174104914001;
  
  [height width]=size(coef);

  hb=round(height/2);
  wb=round(width/2);

  frame(1:2:height,1:2:width)=coef(1:hb,1:wb);
  frame(1:2:height,2:2:width)=coef(1:hb,wb+1:width);
  frame(2:2:height,1:2:width)=coef(hb+1:height,1:wb);
  frame(2:2:height,2:2:width)=coef(hb+1:height,wb+1:width);
  
  % vertical
  % K factor
  frame(1:2:height,:)=frame(1:2:height,:)*K;
  frame(2:2:height,:)=frame(2:2:height,:)/K;
  % update 1
  frame(1,:)=frame(1,:)-DELTA*(frame(2,:)*2);
  if(rem(height,2)==0)
    frame(3:2:height-1,:)=frame(3:2:height-1,:)-...
      DELTA*(frame(2:2:height-2,:)+frame(4:2:height,:));
  else
    frame(3:2:height-2,:)=frame(3:2:height-2,:)-...
      DELTA*(frame(2:2:height-3,:)+frame(4:2:height-1,:));
    frame(height,:)=frame(height,:)-...
      DELTA*(frame(height-1,:)*2);
  end
  % predict 1
  if(rem(height,2)==0)
    frame(2:2:height-2,:)=frame(2:2:height-2,:)-...
      GAMMA*(frame(1:2:height-3,:)+frame(3:2:height-1,:));
    frame(height,:)=frame(height,:)-...
      GAMMA*(frame(height-1,:)*2);
  else
    frame(2:2:height-1,:)=frame(2:2:height-1,:)-...
      GAMMA*(frame(1:2:height-2,:)+frame(3:2:height,:));
  end
  % update 0
  frame(1,:)=frame(1,:)-BETA*(frame(2,:)*2);
  if(rem(height,2)==0)
    frame(3:2:height,:)=frame(3:2:height,:)-...
      BETA*(frame(2:2:height-2,:)+frame(4:2:height,:));
  else
    frame(3:2:height-2,:)=frame(3:2:height-2,:)-...
      BETA*(frame(2:2:height-3,:)+frame(4:2:height-1,:));
    frame(height,:)=frame(height,:)-...
      BETA*(frame(height-1,:)*2);
  end
  % predict 0
  if(rem(height,2)==0)
    frame(2:2:height-2,:)=frame(2:2:height-2,:)-...
      ALPHA*(frame(1:2:height-3,:)+frame(3:2:height-1,:));
    frame(height,:)=frame(height,:)-...
      ALPHA*(frame(height-1,:)*2);
  else
    frame(2:2:height-1,:)=frame(2:2:height-1,:)-...
      ALPHA*(frame(1:2:height-2,:)+frame(3:2:height,:));
  end
  
  % horizontal
  % K factor
  frame(:,1:2:width)=frame(:,1:2:width)*K;
  frame(:,2:2:width)=frame(:,2:2:width)/K;
  % update 1
  frame(:,1)=frame(:,1)-DELTA*(frame(:,2)*2);
  if(rem(width,2)==0)
    frame(:,3:2:width)=frame(:,3:2:width)-...
      DELTA*(frame(:,2:2:width-2)+frame(:,4:2:width));
  else
    frame(:,3:2:width-2)=frame(:,3:2:width-2)-...
      DELTA*(frame(:,2:2:width-3)+frame(:,4:2:width-1));
    frame(:,width)=frame(:,width)-...
      DELTA*(frame(:,width-1)*2);
  end
  % predict 1
  if(rem(width,2)==0)
    frame(:,2:2:width-2)=frame(:,2:2:width-2)-...
      GAMMA*(frame(:,1:2:width-3)+frame(:,3:2:width-1));
    frame(:,width)=frame(:,width)-...
      GAMMA*(frame(:,width-1)*2);
  else
    frame(:,2:2:width-1)=frame(:,2:2:width-1)-...
      GAMMA*(frame(:,1:2:width-2)+frame(:,3:2:width,:));
  end
  % update 0
  frame(:,1)=frame(:,1)-BETA*(frame(:,2)*2);
  if(rem(width,2)==0)
    frame(:,3:2:width)=frame(:,3:2:width)-...
      BETA*(frame(:,2:2:width-2)+frame(:,4:2:width));
  else
    frame(:,3:2:width-2)=frame(:,3:2:width-2)-...
      BETA*(frame(:,2:2:width-3)+frame(:,4:2:width-1));
    frame(:,width)=frame(:,width)-...
      BETA*(frame(:,width-1)*2);
  end
  % predict 0
  if(rem(width,2)==0)
     frame(:,2:2:width-2)=frame(:,2:2:width-2)-...
       ALPHA*(frame(:,1:2:width-3)+frame(:,3:2:width-1));
     frame(:,width)=frame(:,width)-...
       ALPHA*(frame(:,width-1)*2);
  else
     frame(:,2:2:width-1)=frame(:,2:2:width-1)-...
       ALPHA*(frame(:,1:2:width-2)+frame(:,3:2:width,:));
  end
		
  frame=uint8(frame);
