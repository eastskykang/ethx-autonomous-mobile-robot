% Probability of heads.
PHeads = 1/2;
        
% Probability of tails.
PTails = 1/2;
        
% Probability of a black ball given heads.
PBlackGHeads = 3/10;
        
% Probability of a black ball given tails.
PBlackGTails = 1/2;
        
% Total probability of picking a black ball.
PBlack = PBlackGHeads * PHeads + PBlackGTails * PTails;
      