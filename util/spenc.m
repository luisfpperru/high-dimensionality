function [spencresult,x]=spenc(x);
spencresult=[];
persistent aln first firstCall nspenc pi26 spenc spencs xbig ; if isempty(firstCall),firstCall=1;end; 

if isempty(aln), aln=0; end;
if isempty(pi26), pi26=0; end;
if isempty(spencresult), spencresult=0; end;
if isempty(spencs), spencs=zeros(1,19); end;
if isempty(xbig), xbig=0; end;
if isempty(nspenc), nspenc=0; end;
%***BEGIN PROLOGUE  SPENC
%***PURPOSE  Compute a form of Spence's integral due to K. Mitchell.
%***LIBRARY   SLATEC (FNLIB)
%***CATEGORY  C5
%***TYPE      SINGLE PRECISION (SPENC-S, DSPENC-D)
%***KEYWORDS  FNLIB, SPECIAL FUNCTIONS, SPENCE'S INTEGRAL
%***AUTHOR  Fullerton, W., (LANL)
%***DESCRIPTION
%
% Evaluate a form of Spence's function defined by
%        integral from 0 to X of  -LOG(1-Y)/Y  DY.
% For ABS(X) .LE. 1, the uniformly convergent expansion
%        SPENC = sum K=1,infinity  X**K / K**2     is valid.
%
% Spence's function can be used to evaluate much more general integral
% forms.  For example,
%        integral from 0 to Z of  LOG(A*X+B)/(C*X+D)  DX  =
%             LOG(ABS(B-A*D/C))*LOG(ABS(A*(C*X+D)/(A*D-B*C)))/C
%             - SPENC (A*(C*Z+D)/(A*D-B*C)) / C.
%
% Ref -- K. Mitchell, Philosophical Magazine, 40, p. 351 (1949).
%        Stegun and Abromowitz, AMS 55, p. 1004.
%
%
% Series for SPEN       on the interval  0.          to  5.00000D-01
%                                        with weighted error   6.82E-17
%                                         log weighted error  16.17
%                               significant figures required  15.22
%                                    decimal places required  16.81
%
%***REFERENCES  (NONE)
%***ROUTINES CALLED  CSEVL, INITS, R1MACH
%***REVISION HISTORY  (YYMMDD)
%   780201  DATE WRITTEN
%   890531  Changed all specific intrinsics to generic.  (WRB)
%   890531  REVISION DATE from Version 3.2
%   891214  Prologue converted to Version 4.0 format.  (BAB)
%***end PROLOGUE  SPENC
if isempty(first), first=false; end;
if firstCall,   spencs(1)=[.1527365598892406e0];  end;
if firstCall,   spencs(2)=[.08169658058051014e0];  end;
if firstCall,   spencs(3)=[.00581415714077873e0];  end;
if firstCall,   spencs(4)=[.00053716198145415e0];  end;
if firstCall,   spencs(5)=[.00005724704675185e0];  end;
if firstCall,   spencs(6)=[.00000667454612164e0];  end;
if firstCall,   spencs(7)=[.00000082764673397e0];  end;
if firstCall,   spencs(8)=[.00000010733156730e0];  end;
if firstCall,   spencs(9)=[.00000001440077294e0];  end;
if firstCall,   spencs(10)=[.00000000198444202e0];  end;
if firstCall,   spencs(11)=[.00000000027940058e0];  end;
if firstCall,   spencs(12)=[.00000000004003991e0];  end;
if firstCall,   spencs(13)=[.00000000000582346e0];  end;
if firstCall,   spencs(14)=[.00000000000085767e0];  end;
if firstCall,   spencs(15)=[.00000000000012768e0];  end;
if firstCall,   spencs(16)=[.00000000000001918e0];  end;
if firstCall,   spencs(17)=[.00000000000000290e0];  end;
if firstCall,   spencs(18)=[.00000000000000044e0];  end;
if firstCall,   spencs(19)=[.00000000000000006e0];  end;
if firstCall,   pi26=[1.644934066848226e0];  end;
if firstCall,   first=[true];  end;
firstCall=0;
%***FIRST EXECUTABLE STATEMENT  SPENC
if( first )
[nspenc ,spencs]=inits(spencs,19,0.1.*r1mach(3));
xbig = 1.0./r1mach(3);
end;
first = false;
%
if( x>2.0 )
%
% X .GT. 2.0
%
spencresult = 2.0.*pi26 - 0.5.*log(x).^2;
if( x<xbig )
spencresult = spencresult -(1.0+csevl(4.0./x-1.0,spencs,nspenc))./x;
end;
elseif( x>1.0 ) ;
%
% 1.0 .LT. X .LE. 2.0
%
spencresult = pi26 - 0.5.*log(x).*log((x-1.0).^2./x) +(x-1.).*(1.0+csevl(4.0.*(x-1.)./x-1.0,spencs,nspenc))./x;
csnil=dbstack(1); csnil=csnil(1).name(1)~='@';
if csnil&&~isempty(inputname(1)), assignin('caller','FUntemp',x); evalin('caller',[inputname(1),'=FUntemp;']); end
return;
elseif( x>0.5 ) ;
%
% 0.5 .LT. X .LE. 1.0
%
spencresult = pi26;
if( x~=1.0 )
spencresult = pi26 - log(x).*log(1.0-x) -(1.0-x).*(1.0+csevl(4.0.*(1.0-x)-1.0,spencs,nspenc));
end;
csnil=dbstack(1); csnil=csnil(1).name(1)~='@';
if csnil&&~isempty(inputname(1)), assignin('caller','FUntemp',x); evalin('caller',[inputname(1),'=FUntemp;']); end
return;
elseif( x>=0.0 ) ;
%
% 0.0 .LE. X .LE. 0.5
%
spencresult = x.*(1.0+csevl(4.0.*x-1.0,spencs,nspenc));
csnil=dbstack(1); csnil=csnil(1).name(1)~='@';
if csnil&&~isempty(inputname(1)), assignin('caller','FUntemp',x); evalin('caller',[inputname(1),'=FUntemp;']); end
return;
elseif( x>(-1.) ) ;
%
% -1.0 .LT. X .LT. 0.0
%
spencresult = -0.5.*log(1.0-x).^2 - x.*(1.0+csevl(4.0.*x./(x-1.0)-1.0,spencs,nspenc))./(x-1.0);
csnil=dbstack(1); csnil=csnil(1).name(1)~='@';
if csnil&&~isempty(inputname(1)), assignin('caller','FUntemp',x); evalin('caller',[inputname(1),'=FUntemp;']); end
return;
else;
%
% HERE IF X .LE. -1.0
%
aln = log(1.0-x);
spencresult = -pi26 - 0.5.*aln.*(2.0.*log(-x)-aln);
if( x>(-xbig) )
spencresult = spencresult +(1.0+csevl(4.0./(1.0-x)-1.0,spencs,nspenc))./(1.0-x);
end;
csnil=dbstack(1); csnil=csnil(1).name(1)~='@';
if csnil&&~isempty(inputname(1)), assignin('caller','FUntemp',x); evalin('caller',[inputname(1),'=FUntemp;']); end
return;
end;
%
csnil=dbstack(1); csnil=csnil(1).name(1)~='@';
if csnil&&~isempty(inputname(1)), assignin('caller','FUntemp',x); evalin('caller',[inputname(1),'=FUntemp;']); end
end
%DECK SPIGMR