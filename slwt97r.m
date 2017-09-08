function coef=slwt97r(frame,level)
%slwt97r    Spatial lifting 9/7 wavelet transform (real type)
%
%
%  Example: 
%
%    coef=slwt97r(frame,level);
%
%    frame(height, width)
%    
%  -----------------------------------------------------------------
%  slwt97r.m                              Minoru Hiki.     06/06/13
  
  [height width]=size(frame);
  
  for i=1:level
    hb=ceil(height/2^(i-1));
    wb=ceil(width/2^(i-1));
    frame(1:hb,1:wb)=trx(frame(1:hb,1:wb));
  end;
  coef=frame;		
  
function coef=trx(frame)
  ALPHA = -1.586134342059924;
  BETA  = -0.052980118572961;
  GAMMA =  0.882911075530934;
  DELTA =  0.443506852043971;
  K     =  1.230174104914001;
  
  [height width]=size(frame);
  frame=double(frame);
  
  % horizontal
  % predict 0
  if(rem(width,2)==0)
    frame(:,2:2:width-2)=frame(:,2:2:width-2)+...
        ALPHA*(frame(:,1:2:width-3)+frame(:,3:2:width-1));
    frame(:,width)=frame(:,width)+...
        ALPHA*(frame(:,width-1)*2);
  else
    frame(:,2:2:width-1)=frame(:,2:2:width-1)+...
        ALPHA*(frame(:,1:2:width-2)+frame(:,3:2:width));
  end;
  % update 0
  frame(:,1)=frame(:,1)+BETA*(frame(:,2)*2);
  if(rem(width,2)==0)
    frame(:,3:2:width-1)=frame(:,3:2:width-1)+...
        BETA*(frame(:,2:2:width-2)+frame(:,4:2:width));
  else
    frame(:,3:2:width-2)=frame(:,3:2:width-2)+...
        BETA*(frame(:,2:2:width-3)+frame(:,4:2:width-1));
    frame(:,width)=frame(:,width)+...
        BETA*(frame(:,width-1)*2);
  end;
  % predict 1
  if(rem(width,2)==0)
    frame(:,2:2:width-2)=frame(:,2:2:width-2)+...
        GAMMA*(frame(:,1:2:width-3)+frame(:,3:2:width-1));
    frame(:,width)=frame(:,width)+...
        GAMMA*(frame(:,width-1)*2);
  else
    frame(:,2:2:width-1)=frame(:,2:2:width-1)+...
        GAMMA*(frame(:,1:2:width-2)+frame(:,3:2:width));
  end;
  % update 1
  frame(:,1)=frame(:,1)+DELTA*(frame(:,2)*2);
  if(rem(width,2)==0)
    frame(:,3:2:width-1)=frame(:,3:2:width-1)+...
        DELTA*(frame(:,2:2:width-2)+frame(:,4:2:width));
  else
    frame(:,3:2:width-2)=frame(:,3:2:width-2)+...
        DELTA*(frame(:,2:2:width-3)+frame(:,4:2:width-1));
    frame(:,width)=frame(:,width)+...
        DELTA*(frame(:,width-1)*2);
  end;
  % K factor
  frame(:,1:2:width)=frame(:,1:2:width)/K;
  frame(:,2:2:width)=frame(:,2:2:width)*K;
  
  % vertical
  % predict 0
  if(rem(height,2)==0)
    frame(2:2:height-2,:)=frame(2:2:height-2,:)+...
        ALPHA*(frame(1:2:height-3,:)+frame(3:2:height-1,:));
    frame(height,:)=frame(height,:)+...
        ALPHA*(frame(height-1,:)*2);
  else
    frame(2:2:height-1,:)=frame(2:2:height-1,:)+...
        ALPHA*(frame(1:2:height-2,:)+frame(3:2:height,:));
  end;
  % update 0
  frame(1,:)=frame(1,:)+BETA*(frame(2,:)*2);
  if(rem(height,2)==0)
    frame(3:2:height-1,:)=frame(3:2:height-1,:)+...
        BETA*(frame(2:2:height-2,:)+frame(4:2:height,:));
  else
    frame(3:2:height-2,:)=frame(3:2:height-2,:)+...
        BETA*(frame(2:2:height-3,:)+frame(4:2:height-1,:));
    frame(height,:)=frame(height,:)+...
        BETA*(frame(height-1,:)*2);
  end;
  % predict 1
  if(rem(height,2)==0)
    frame(2:2:height-2,:)=frame(2:2:height-2,:)+...
        GAMMA*(frame(1:2:height-3,:)+frame(3:2:height-1,:));
    frame(height,:)=frame(height,:)+...
        GAMMA*(frame(height-1,:)*2);
  else
    frame(2:2:height-1,:)=frame(2:2:height-1,:)+...
        GAMMA*(frame(1:2:height-2,:)+frame(3:2:height,:));
  end;
  % update 1
  frame(1,:)=frame(1,:)+DELTA*(frame(2,:)*2);
  if(rem(height,2)==0)
    frame(3:2:height-1,:)=frame(3:2:height-1,:)+...
        DELTA*(frame(2:2:height-2,:)+frame(4:2:height,:));
  else
    frame(3:2:height-2,:)=frame(3:2:height-2,:)+...
        DELTA*(frame(2:2:height-3,:)+frame(4:2:height-1,:));
    frame(height,:)=frame(height,:)+...
        DELTA*(frame(height-1,:)*2);
  end;
  % K factor
  frame(1:2:height,:)=frame(1:2:height,:)/K;
  frame(2:2:height,:)=frame(2:2:height,:)*K;
  
  hb=round(height/2);
  wb=round(width/2);
  
  coef(1:hb,1:wb)=frame(1:2:height,1:2:width);
  coef(1:hb,wb+1:width)=frame(1:2:height,2:2:width);
  coef(hb+1:height,1:wb)=frame(2:2:height,1:2:width);
  coef(hb+1:height,wb+1:width)=frame(2:2:height,2:2:width);
